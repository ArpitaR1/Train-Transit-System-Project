<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transit Line Revenue</title>
</head>
<body>

<%
	String lineName=request.getParameter("transitLineRev");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://cs336group11.cizcmkra6h8d.us-east-2.rds.amazonaws.com:3306/TrainDB","group11", "rutgers2020");	

	Statement st=con.createStatement();
	ResultSet rs;
	rs=st.executeQuery("select reservationNumber, reservation.date as date, totalFare from reservation join reservation_has_train on reservationNumber = reservationNumberRHT join train on tIDRHT=tID join train_has_trainSchedule on tID = tIDTHS join trainSchedule on tsIDTHS = tsID where transitLineName = '"+lineName+"'order by date;");
	
	out.println("The following is a revenue list for: "+lineName);
%>
<br>
<br>
<table>
	<tr>
		<td> RESERVATION DATE || </td>
		<td> RESERVATION NUMBER || </td>
		<td> FARE </td>
	</tr>	
		<% while (rs.next()){  %>	
		<tr>
			<td><%=rs.getString("date")%></td>
			<td><%=rs.getString("reservationNumber")%></td>
			<td><%=rs.getString("totalFare")%></td>
		<tr>
		<% } %>
	</tr>
</table>
<br>


</body>
</html>