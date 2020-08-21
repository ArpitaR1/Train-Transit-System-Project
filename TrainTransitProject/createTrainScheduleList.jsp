<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create List of Train Schedules</title>
</head>
<body>

<%
		
    String origin = request.getParameter("origin");   
    String destination = request.getParameter("destination");
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336group11.cizcmkra6h8d.us-east-2.rds.amazonaws.com:3306/TrainDB","group11", "rutgers2020");
        
    Statement st = con.createStatement();
    ResultSet rs;
   	rs = st.executeQuery("select t1.tsIDStops as tsID, t1.transitLineName as transitLineName, t1.departureTime as departureTime, t1.name as Origin, t2.arrivalTime as arrivalTime, t2.name as Destination, t1.fixedFare as fixedFare from (select * from trainSchedule as s join trainSchedule_hasStops_station on tsID = tsIDStops join station s1 on s1.sID=sIDStops where s1.name like '"+origin+"') as t1, (select * from trainSchedule as s join trainSchedule_hasStops_station on tsID = tsIDStops join station s2 on s2.sID=sIDStops where s2.name like '"+destination+"') as t2 where t2.stopNumber > t1.stopNumber and t1.date = t2.date and t1.tsIDStops = t2.tsIDStops;");
    
%>

	<table>
		<tr>    
			<td> TRAIN ID || </td>
			<td> TRANSIT LINE NAME || </td>
			<td> DEPARTURE TIME || </td>
			<td> ORIGIN || </td>	
			<td> ARRIVAL TIME || </td>
			<td> DESTINATION || </td>
			<td> FIXED FARE  </td>
		</tr>
			
			<%
			//parse out the results
			while (rs.next()) { %>
				<tr>    
					<td><%= rs.getString("tsID")%></td>
					<td><%= rs.getString("transitLineName")%></td>
					<td><%= rs.getString("departureTime")%></td>
					<td><%= rs.getString("Origin")%></td>
					<td><%= rs.getString("arrivalTime")%></td>
					<td><%= rs.getString("Destination")%></td>		
					<td><%= rs.getString("fixedFare")%></td>	
						
				</tr>
				

		<% } %>
		</table>
</body>
</html>