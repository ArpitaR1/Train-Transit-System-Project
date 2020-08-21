<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CR Successfully Logged In</title>
</head>
<body>
<%	
    if ((request.getSession().getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="login.jsp">Please Login</a>
<%} else {
%>

Welcome Customer Representative,  <%=session.getAttribute("user")%> 
<br>
 <br>
 
Answer Customer Questions:
	<form method="get" action="answerQuestions.jsp">
       <input type="submit" value="Browse"/>
     </form>
 <br>

Edit Train Schedule:
	<form method="get" action="editTrainSchedule.jsp">
       <input type="submit" value="Edit"/>
     </form>
 <br>
 
 Delete Train Schedule:
	<form method="get" action="deleteTrainSchedule.jsp">
		Train Schedule ID: <input type="text" name="tsID"/> <br/>
       <input type="submit" value="Delete"/>
     </form>
 <br>
 
Produce a List of Train Schedules by:
	<form method="get" action="createTrainScheduleList.jsp">
       Origin: <input type="text" name="origin"/> <br/>
       Destination:<input type="text" name="destination"/> <br/>
       <input type="submit" value="Submit"/>
     </form>
 <br>
 
<a href='logout.jsp'>Click if you want to log out</a>
<%
    }
%>
</body>
</html>