using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Threading;
using System.Threading.Tasks;

namespace PlacementAgency.Helpers
{
    /// <summary>
    /// A modernized Database helper with async support, centralized command creation,
    /// transaction support, null handling, and optional logging.
    /// </summary>
    public class DatabaseHelper
    {
        private readonly string _connectionString;
        private readonly int _defaultTimeoutSeconds;
        private readonly Action<Exception> _logger;

        /// <summary>
        /// Create helper using connection string from config `connectionStringName`.
        /// </summary>
        /// <param name="connectionStringName">Name of connection string in config (e.g. "conn")</param>
        /// <param name="defaultTimeoutSeconds">Default command timeout in seconds</param>
        /// <param name="logger">Optional logger delegate (e.g. ex => logger.LogError(ex, ...))</param>
        public DatabaseHelper(string connectionStringName = "conn", int defaultTimeoutSeconds = 30, Action<Exception> logger = null)
        {
            var cs = ConfigurationManager.ConnectionStrings[connectionStringName]?.ConnectionString;
            if (string.IsNullOrWhiteSpace(cs))
                throw new ArgumentException($"Connection string '{connectionStringName}' not found or empty in configuration.");

            _connectionString = cs;
            _defaultTimeoutSeconds = defaultTimeoutSeconds;
            _logger = logger;
        }

        /// <summary>
        /// Create helper directly from a connection string (useful for tests).
        /// </summary>
        public DatabaseHelper(string connectionString, Action<Exception> logger = null)
        {
            if (string.IsNullOrWhiteSpace(connectionString))
                throw new ArgumentException("connectionString must not be null or empty.", nameof(connectionString));

            _connectionString = connectionString;
            _defaultTimeoutSeconds = 30;
            _logger = logger;
        }



        #region Public Sync APIs

        public int ExecuteNonQuery(string storedProcedure, IEnumerable<SqlParameter> parameters = null, int? commandTimeoutSeconds = null)
        {
            try
            {
                using (var conn = new SqlConnection(_connectionString))
                using (var cmd = CreateCommand(conn, storedProcedure, parameters, commandTimeoutSeconds))
                {
                    conn.Open();
                    return cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                _logger?.Invoke(ex);
                throw;
            }
        }

        public object ExecuteScalar(string storedProcedure, IEnumerable<SqlParameter> parameters = null, int? commandTimeoutSeconds = null)
        {
            try
            {
                using (var conn = new SqlConnection(_connectionString))
                using (var cmd = CreateCommand(conn, storedProcedure, parameters, commandTimeoutSeconds))
                {
                    conn.Open();
                    return cmd.ExecuteScalar();
                }
            }
            catch (Exception ex)
            {
                _logger?.Invoke(ex);
                throw;
            }
        }

        public DataTable ExecuteQuery(string storedProcedure, IEnumerable<SqlParameter> parameters = null, int? commandTimeoutSeconds = null)
        {
            var dt = new DataTable();
            try
            {
                using (var conn = new SqlConnection(_connectionString))
                using (var cmd = CreateCommand(conn, storedProcedure, parameters, commandTimeoutSeconds))
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
                return dt;
            }
            catch (Exception ex)
            {
                _logger?.Invoke(ex);
                throw;
            }
        }

        public DataSet ExecuteQueryDataSet(string storedProcedure, IEnumerable<SqlParameter> parameters = null, int? commandTimeoutSeconds = null)
        {
            var ds = new DataSet();
            try
            {
                using (var conn = new SqlConnection(_connectionString))
                using (var cmd = CreateCommand(conn, storedProcedure, parameters, commandTimeoutSeconds))
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(ds);
                }
                return ds;
            }
            catch (Exception ex)
            {
                _logger?.Invoke(ex);
                throw;
            }
        }

        #endregion

        #region Public Async APIs

        public async Task<int> ExecuteNonQueryAsync(string storedProcedure, IEnumerable<SqlParameter> parameters = null, int? commandTimeoutSeconds = null, CancellationToken cancellationToken = default)
        {
            try
            {
                using (var conn = new SqlConnection(_connectionString))
                using (var cmd = CreateCommand(conn, storedProcedure, parameters, commandTimeoutSeconds))
                {
                    await conn.OpenAsync(cancellationToken).ConfigureAwait(false);
                    return await cmd.ExecuteNonQueryAsync(cancellationToken).ConfigureAwait(false);
                }
            }
            catch (Exception ex)
            {
                _logger?.Invoke(ex);
                throw;
            }
        }

        public async Task<T> ExecuteScalarAsync<T>(string storedProcedure, IEnumerable<SqlParameter> parameters = null, int? commandTimeoutSeconds = null, CancellationToken cancellationToken = default)
        {
            try
            {
                object result;
                using (var conn = new SqlConnection(_connectionString))
                using (var cmd = CreateCommand(conn, storedProcedure, parameters, commandTimeoutSeconds))
                {
                    await conn.OpenAsync(cancellationToken).ConfigureAwait(false);
                    result = await cmd.ExecuteScalarAsync(cancellationToken).ConfigureAwait(false);
                }

                if (result == null || result == DBNull.Value) return default(T);
                return (T)Convert.ChangeType(result, typeof(T));
            }
            catch (Exception ex)
            {
                _logger?.Invoke(ex);
                throw;
            }
        }

        public async Task<DataTable> ExecuteQueryAsync(string storedProcedure, IEnumerable<SqlParameter> parameters = null, int? commandTimeoutSeconds = null, CancellationToken cancellationToken = default)
        {
            var dt = new DataTable();
            try
            {
                using (var conn = new SqlConnection(_connectionString))
                using (var cmd = CreateCommand(conn, storedProcedure, parameters, commandTimeoutSeconds))
                using (var da = new SqlDataAdapter(cmd))
                {
                    // SqlDataAdapter doesn't support async Fill directly. Use Task.Run to avoid blocking
                    await Task.Run(() => da.Fill(dt), cancellationToken).ConfigureAwait(false);
                }
                return dt;
            }
            catch (Exception ex)
            {
                _logger?.Invoke(ex);
                throw;
            }
        }

        /// <summary>
        /// Execute a reader and map each row to T using the provided mapper delegate.
        /// </summary>
        public async Task<List<T>> ExecuteReaderAsync<T>(string storedProcedure, Func<SqlDataReader, T> map, IEnumerable<SqlParameter> parameters = null, int? commandTimeoutSeconds = null, CancellationToken cancellationToken = default)
        {
            if (map == null) throw new ArgumentNullException(nameof(map));

            var list = new List<T>();
            try
            {
                using (var conn = new SqlConnection(_connectionString))
                using (var cmd = CreateCommand(conn, storedProcedure, parameters, commandTimeoutSeconds))
                {
                    await conn.OpenAsync(cancellationToken).ConfigureAwait(false);
                    using (var reader = await cmd.ExecuteReaderAsync(CommandBehavior.CloseConnection, cancellationToken).ConfigureAwait(false))
                    {
                        while (await reader.ReadAsync(cancellationToken).ConfigureAwait(false))
                        {
                            list.Add(map(reader));
                        }
                    }
                }
                return list;
            }
            catch (Exception ex)
            {
                _logger?.Invoke(ex);
                throw;
            }
        }

        #endregion

        #region Transaction Support

        /// <summary>
        /// Execute multiple commands inside a transaction. If any command fails, transaction rolls back.
        /// Each function gets the open SqlConnection and SqlTransaction to execute whatever it needs.
        /// </summary>
        public async Task ExecuteTransactionAsync(Func<SqlConnection, SqlTransaction, Task> transactionalWork, CancellationToken cancellationToken = default)
        {
            if (transactionalWork == null) throw new ArgumentNullException(nameof(transactionalWork));

            try
            {
                using (var conn = new SqlConnection(_connectionString))
                {
                    await conn.OpenAsync(cancellationToken).ConfigureAwait(false);
                    using (var tran = conn.BeginTransaction())
                    {
                        try
                        {
                            await transactionalWork(conn, tran).ConfigureAwait(false);
                            tran.Commit();
                        }
                        catch
                        {
                            try { tran.Rollback(); } catch { /* swallow rollback exceptions intentionally */ }
                            throw;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                _logger?.Invoke(ex);
                throw;
            }
        }

        #endregion

        #region Helpers

        /// <summary>
        /// Centralized command builder that sets command type, timeout and handles null parameter conversion.
        /// The returned SqlCommand is not yet associated with an open connection; caller should open connection as needed.
        /// </summary>
        private SqlCommand CreateCommand(SqlConnection conn, string storedProcedure, IEnumerable<SqlParameter> parameters, int? commandTimeoutSeconds)
        {
            if (conn == null) throw new ArgumentNullException(nameof(conn));
            if (string.IsNullOrWhiteSpace(storedProcedure)) throw new ArgumentNullException(nameof(storedProcedure));

            var cmd = new SqlCommand(storedProcedure, conn)
            {
                CommandType = CommandType.StoredProcedure,
                CommandTimeout = commandTimeoutSeconds ?? _defaultTimeoutSeconds
            };

            if (parameters != null)
            {
                foreach (var p in parameters)
                {
                    // Defensive: convert nulls to DBNull.Value
                    if (p.Value == null) p.Value = DBNull.Value;
                    cmd.Parameters.Add(p);
                }
            }

            return cmd;
        }

        /// <summary>
        /// Convenience: create SqlParameter from name + value; automatically maps null -> DBNull.
        /// Use this instead of `new SqlParameter(...)` to keep code neat.
        /// </summary>
        public static SqlParameter Param(string name, object value, SqlDbType? dbType = null, ParameterDirection direction = ParameterDirection.Input, int? size = null)
        {
            var p = dbType.HasValue ? new SqlParameter(name, dbType.Value) : new SqlParameter(name, value ?? DBNull.Value);
            p.Direction = direction;
            if (size.HasValue) p.Size = size.Value;
            if (value == null) p.Value = DBNull.Value;
            else p.Value = value;
            return p;
        }

        #endregion
    }
}
