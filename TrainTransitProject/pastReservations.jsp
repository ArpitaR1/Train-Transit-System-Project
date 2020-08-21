<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Past Reservations</title>
</head>
<body>

<br>
	Go back to user account:
	<form method="get" action="success.jsp">
       <input type="submit" value="Back"/>
     </form>
<br> 

<%
 	ApplicationDB db = new ApplicationDB();	
 	Connection con = db.getConnection();
 	
 	 String user = String.valueOf(session.getAttribute("user"));

 	 Statement st = con.createStatement();
 	 ResultSet rs;
 	 //rs = st.executeQuery("select reservationNumber, discount, totalFare, date, tripType from reservation join customer_has_reservation on reservationNumChR = reservationNumber where usernameChR = '" + user + "' and date >= current_date();");
 	rs = st.executeQuery("select transitLineName, reservationNumber, str_to_date(trainSchedule.date, '%m/%d/%Y') as tripDate, discount, totalFare, reservation.date as reservationDate, tripType from reservation join customer_has_reservation on reservationNumChR = reservationNumber join reservation_hasOrigin_station on reservationNumberRHOS = reservationNumber join reservation_has_train on reservationNumber = reservationNumberRHT join train_has_trainSchedule on tIDTHS = tIDRHT join trainSchedule on tsIDTHS = tsID where usernameChR = '"+ user + "' and timestamp(str_to_date(trainSchedule.date, '%m/%d/%Y'), originTime) < current_timestamp();");
 %>
	
	<table>
		<tr>    
			<td>Reservation Number|| </td>
			<td>Discount(%)	|| </td>		
			<td>Fare	|| </td>
			<td>Date Reserved	   || </td>
			<td>Trip Type || </td>
			<td>Transit Line Name   || </td>
			<td>Date of Trip||</td>
			<td>Origin    || </td>
			<td>Departure Time ||</td>
			<td>Destination ||</td>
			<td>Arrival Time </td>
		</tr>


<%
			
			while (rs.next()) { %>
				<tr>    
					<td><%= rs.getString("reservationNumber")%></td>
					<td><%= rs.getString("discount")%></td>
					<td><%= rs.getString("totalFare")%></td>
					<td><%= rs.getString("reservationDate")%></td>
					<td><%= rs.getString("tripType")%></td>
					<td><%= rs.getString("transitLineName")%></td>
					<td><%= rs.getString("tripDate")%></td>
					
					<% Statement st2 = con.createStatement();
					 ResultSet rs2; 
					 rs2 = st2.executeQuery("select name, originTime from reservation_hasOrigin_station join station on sIDRHOS = sID where reservationNumberRHOS =" + rs.getInt("reservationNumber") + ";");
					 rs2.next();%>
					 <td><%= rs2.getString("name")%></td>
					 <td><%= rs2.getString("originTime")%></td>
					 
					 <%
					 st2 = con.createStatement();
					 ResultSet rs3; 
					 rs3 = st2.executeQuery("select name, destinationTime from reservation_has_destinationStation join station on sIDRhS = sID where reservationNumRhS =" + rs.getInt("reservationNumber") + ";");
					 rs3.next();%>
					 
					 <td><%= rs3.getString("name")%></td>
					 <td><%= rs3.getString("destinationTime")%></td>
					 
					 
					
					</tr>
				

		<% } %>
		</table>
		
<br>
<br>




</body>
</html>