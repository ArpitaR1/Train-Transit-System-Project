<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reservation List</title>
</head>
<body>


<br>
	Go back to admin account:
	<form method="get" action="successAdmin.jsp">
       <input type="submit" value="Back"/>
     </form>
<br> 

	<%
 		ApplicationDB db = new ApplicationDB();	
 		Connection con = db.getConnection();


 		Statement stmt = con.createStatement();
 		ResultSet rs;
 		String type = request.getParameter("listType"); 
 		
 			if(type.equals("Transit Line")){
 		
 		
 		rs = stmt.executeQuery("select tsID, transitLineName, reservationNumber, discount, totalFare, reservation.date, tripType from reservation join reservation_has_train on reservationNumber = reservationNumberRHT join train_has_trainSchedule on tIDTHS = tIDRHT join trainSchedule on tsID = tsIDTHS order by tsID;");
 	%>
			 <table>
		<tr>    
			<td> tsID || </td>
			<td> Transit Line Name	|| </td>		
			<td> Reservation Number || </td>
			<td> Discount || </td>
			<td> Fare 		|| </td>
			<td> Date 			|| </td>
			<td> Trip Type </td>
		</tr>
		
		<%
			//parse out the results
			while (rs.next()) { %>
				<tr>    
					<td><%= rs.getInt("tsID")%></td>
					<td><%= rs.getString("transitLineName")%></td>
					<td><%= rs.getInt("reservationNumber")%></td>
					<td><%= rs.getInt("discount") +  "%"%></td>
					<td><%= "$" + rs.getFloat("totalFare")%></td>
					<td><%= rs.getDate("reservation.date") %></td>
					<td><%= rs.getString("tripType")%></td>
				</tr>
				

		<% } %>
		</table>
	<% 
		}else{
			
			
			
			rs = stmt.executeQuery("select usernameChR, reservationNumber, discount, totalFare, date, tripType from reservation join customer_has_reservation on reservationNumChR = reservationNumber order by usernameChR;");
			
			%>
			 <table>
		<tr>    
			<td> Customer Username || </td>	
			<td> Reservation Number || </td>
			<td> Discount || </td>
			<td> Fare 	|| </td>
			<td> Date 			|| </td>
			<td> Trip Type </td>
		</tr>
		
		<%
			//parse out the results
			while (rs.next()) { %>
				<tr>    
					<td><%= rs.getString("usernameChR")%></td>
					<td><%= rs.getInt("reservationNumber")%></td>
					<td><%= rs.getInt("discount") + "%"%></td>
					<td><%= "$" + rs.getFloat("totalFare")%></td>
					<td><%= rs.getDate("reservation.date")%></td>
					<td><%= rs.getString("tripType")%></td>
				</tr>
				

		<% } %>
		</table>
	<% 
						
			
			
		}
	
	
	
	
	
	%>

</body>
</html>