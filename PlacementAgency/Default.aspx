<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PlacementAgency._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

     <div class="card" style="width: 100%;">
<div class="card-body">

    <label for="month">Select Month:</label>
<select id="month" name="month" class="form-select">
  <option value="">-- Select Month --</option>
  <option value="1">January</option>
  <option value="2">February</option>
  <option value="3">March</option>
  <option value="4">April</option>
  <option value="5">May</option>
  <option value="6">June</option>
  <option value="7">July</option>
  <option value="8">August</option>
  <option value="9">September</option>
  <option value="10">October</option>
  <option value="11">November</option>
  <option value="12">December</option>
</select>
    </div>
         </div>
    <br />
   
   
      <div class="container text-center">


<table class="table table-bordered">
     
  <thead>
          
    <tr  class="alert alert-primary">
      <th scope="col"> S.no</th>
      <th scope="col">  PARTICULARS</th>  
      <th scope="col">Duties</th>
    </tr>
  </thead>
  <tbody> 
                <tr style="background-color:#dcedff">
    <td colspan="3">Month</td>
</tr>
    <tr>
      <th scope="row">1</th>
      <td>CHIEF SALESMAN (Office)</td>
    
        <td>  <input type="text" /></td>
 
    </tr>
      <tr>
  <th scope="row">2</th>
  <td>CHIEF SALESMAN (Shop)</td>
  
    <td> <input type="text" /> </td>
   
</tr>
      <tr>
  <th scope="row">3</th>
  <td>SALESMAN (Office)</td>
 
    <td>  <input type="text" /></td>
  
</tr>
      <tr>
  <th scope="row">4</th>
  <td>SALESMAN (Shop)</td>
 
    <td> <input type="text" /> </td>
 
</tr>
      <tr>
  <th scope="row">5</th>
  <td>MULTIPURPOSE (Office)</td>
 
    <td> <input type="text" /> </td>
   
</tr>
      <tr>
  <th scope="row">6</th>
  <td>MULTIPURPOSE (Shop)</td>
 
    <td> <input type="text" /> </td>
   
</tr>
       <tr style="background-color:#dcedff">
    <td colspan="3" >OT</td>
</tr>
    <tr>
      <th scope="row">1</th>
      <td>CHIEF SALESMAN (Shop)</td>
   
        <td> <input type="text" /> </td>
      
    </tr>
      <tr>
  <th scope="row">2</th>
  <td>SALESMAN (Shop)</td>
 
    <td> <input type="text" /> </td>

</tr>
      <tr>
  <th scope="row">3</th>
  <td>MULTIPURPOSE (Shop)</td>
    <td> <input type="text" /> </td>
 
</tr> 
             <tr style="background-color:#dcedff">
    <td colspan="3">Day(Total Week off 4 Days)</td>
</tr>
    <tr>
      <th scope="row">1</th>
      <td>CHIEF SALESMAN (Office)</td>
      
        <td> <input type="text" /> </td>
        
    </tr>
      <tr>
  <th scope="row">2</th>
  <td>CHIEF SALESMAN (Shop)</td>
 
    <td>  <input type="text" /></td>

</tr>
      <tr>
  <th scope="row">3</th>
  <td>SALESMAN (Office)</td>
  
    <td>  <input type="text" /></td>
  
</tr>
      <tr>
  <th scope="row">4</th>
  <td>SALESMAN (Shop)</td>
 
    <td>  <input type="text" /></td>
 
</tr>
      <tr>
  <th scope="row">5</th>
  <td>MULTIPURPOSE (Office)</td>
  
    <td> <input type="text" /> </td>
   
</tr>
      <tr>
  <th scope="row">6</th>
  <td>MULTIPURPOSE (Shop)</td>
 
    <td> <input type="text" /></td>
   
</tr>
    
       
   <tr>
     
     
       <td colspan="3"><button type="submit" class="btn btn-success">Submit</button>&nbsp&nbsp&nbsp<button type="submit" class="btn btn-warning">Reset</button></td>
   </tr>
   
  </tbody>
</table>
</div>
  
        

</asp:Content>

