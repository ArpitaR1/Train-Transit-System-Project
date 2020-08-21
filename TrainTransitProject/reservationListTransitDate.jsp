<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Reservation List</title>
</head>
<body>

<br>
	Go back to customer rep account:
	<form method="get" action="successCR.jsp">
       <input type="submit" value="Back"/>
     </form>
<br> 



<%
 	ApplicationDB db = new ApplicationDB();	
 	Connection con = db.getConnection();

 	String transitLine = request.getParameter("transitLine");
 	String date = request.getParameter("date");
 	 Statement st = con.createStatement();
 	 ResultSet rs;
 	 
 	 rs = st.executeQuery("select usernameChR from customer_has_reservation join reservation_has_train on reservationNumChR = reservationNumberRHT join train_has_trainSchedule on tIDTHS = tIDRHT join trainSchedule on tsID = tsIDTHS where transitLineName = '"+ transitLine + "' and trainSchedule.date = '"+ date + "' group by usernameChR;");
 %>
	 <table>
		<tr>    
			<td> Customers that took <%=request.getParameter("transitLine")%> on <%=request.getParameter("date")%> :</td>
		<% while(rs.next()) { %>
				<tr>    
					<td><%= rs.getString("usernameChR")%></td>
				</tr>

		<% } %>
		</table>


</body>
</html>