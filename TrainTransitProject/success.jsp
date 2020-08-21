<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Successfully Logged In</title>
</head>
<body>
<%	
    if ((request.getSession().getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="login.jsp">Please Login</a>
<%} else {
%>
Welcome Customer,  <%=session.getAttribute("user")%> 
<br>
<br>
Search for a Train Schedule:
	<form method="get" action="checkScheduleResults.jsp">
       Origin: <input type="text" name="origin"/> <br/>
       Destination:<input type="text" name="destination"/> <br/>
       MM/DD/YYYY:<input type="text" name="date"/><br/>
       <input type="submit" value="Submit"/>
     </form>
 <br>
 
 <br>
View Current Reservations:
	<form method="get" action="currentReservations.jsp">
       <input type="submit" value="Current Reservations"/>
     </form>
 <br>
 
 View Past Reservations:
	<form method="get" action="pastReservations.jsp">
       <input type="submit" value="Past Reservations"/>
     </form>
 <br>
 
 Browse or Search Questions:
	<form method="get" action="questions.jsp">
       <input type="submit" value="Browse"/>
     </form>
 <br> 
 
<a href='logout.jsp'>Logout</a> <br/>
<%
    }
%>
</body>
</html>