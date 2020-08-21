<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Check Sales Reports</title>
</head>
<body>

<%
	String input=request.getParameter("reportMonth");
	String month=input.substring(0,2);
	String year=input.substring(3,7);

	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://cs336group11.cizcmkra6h8d.us-east-2.rds.amazonaws.com:3306/TrainDB","group11", "rutgers2020");
	
    Statement st = con.createStatement();
    ResultSet rs;
    
    rs=st.executeQuery("select date, reservationNumber, totalFare from reservation where date like'"+year+"-"+month+ "%' order by date;");
    
%>

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


<%
	st=con.createStatement();
	rs=st.executeQuery("select sum(if(date like'"+year+"-"+month+ "%',totalFare,0)) as total from reservation;");
	while (rs.next()){	
		double total =  Math.round(rs.getFloat("total") * 100.0) / 100.0;
		out.print("The month of "+month+"/"+year+" had a total revenue of: "+total);
	}
	
%>

</body>
</html>