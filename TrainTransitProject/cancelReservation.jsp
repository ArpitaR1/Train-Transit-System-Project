<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cancel Screen</title>
</head>
<body>

<%
	int reservationNumber = Integer.parseInt(request.getParameter("reservationNumbers"));

	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();


	Statement stmt = con.createStatement();

	String insert = "delete from reservation where reservationNumber = ?";

	PreparedStatement ps = con.prepareStatement(insert);
	
	ps.setInt(1, reservationNumber);
	
	ps.executeUpdate();
	
	con.close();
	out.print("Reservation cancelled");
%><br><a href='currentReservations.jsp'>Go back to Current Reservations</a><%
	
	


%>



</body>
</html>