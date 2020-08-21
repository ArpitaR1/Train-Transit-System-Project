<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Successfully Logged In </title>
</head>
<body>
<%	
    if ((request.getSession().getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="login.jsp">Please Login</a>
<%} else {
%>
Welcome Admin,  <%=session.getAttribute("user")%> 
<br>
<br>

See list of reservations based on by transit line name or by customer name
<br>
<form method="post" action="reservationList.jsp">
	<select name="listType">
	 <option value="Transit Line">Transit Line</option>
	  <option value="Customer Name">Customer Name</option>
  </select>
	<br>
  <input type="submit" value="List">
</form>
<br>    
<br>

Enter a month (MM/YYYY) to obtain a sales report: 
<br>
<form method="get" action="checkSalesReport.jsp">
	<input type="text" name="reportMonth"/> <br/>
	<input type="submit" value="Submit"/>
</form>
<br>    
<br>
Enter a transit line to produce a listing of revenue:
<form method="get" action="checkRevenueTransit.jsp">
	<input type="text" name="transitLineRev"/> <br/>
	<input type="submit" value="Submit"/>
</form>
<br>
<br>
Enter a customer name (FirstName LastName) to produce a listing of revenue:
<form method="get" action="checkRevenueCustomer.jsp">
	<input type="text" name="customerRev"/> <br/> 
	<input type="submit" value="Submit"/>
</form>
<br>
<br>

<form method="get" action="findBestCustomer.jsp">
	<input type="submit" value="Find Best Customer"/>
</form>
<br>
<br>
Enter a month (MM/YYYY) to obtain the five most active transit lines: 
<form method="get" action="findFiveTransitLines.jsp">
	<input type="text" name="activeMonth"/> <br/>
	<input type="submit" value="Find 5 most active transit lines"/>
</form>
<br>
<br>
Enter a username and password for the customer representative you'd like to add to the database:
<form method="get" action="addCR.jsp">
	Username: <input type="text" name="crIDadd"/> <br/>
	Password: <input type="password" name="crPWadd"/> <br/>	
	<input type="submit" value="Submit"/>
</form>
<br>
<br>
Enter the ID for the customer representative you'd like to edit:
<br>
Type "N/A" for any field you'd like to delete from the database.
<br>
If you do not want to change it, leave it blank.
<br>
<form method="get" action="editCRupdate.jsp">
	ID: <br><input type="text" name="crIDedit"/> <br/>
				New Password? <br> <input type="text" name="newPW"><br>
				New First Name? <br> <input type="text" name="newFirstName"><br>
				New Last Name? <br> <input type="text" name="newLastName"><br>
				New Email? <br> <input type="text"name="newEmail"><br>		
	<input type="submit" value="Submit"/>
</form>
<br>
<br>
Enter the ID for the customer representative you'd like to delete from the database:
<form method="get" action="deleteCR.jsp">
	<input type="text" name="crIDdelete"/> <br/>	
	<input type="submit" value="Submit"/>
</form>
<br>
<br>
<a href='logout.jsp'>Log Out</a>
<%
    }
%>
</body>
</html>