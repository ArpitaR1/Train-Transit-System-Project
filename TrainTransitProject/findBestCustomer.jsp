<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find Best Customer</title>
</head>
<body>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://cs336group11.cizcmkra6h8d.us-east-2.rds.amazonaws.com:3306/TrainDB","group11", "rutgers2020");
	
	Statement st=con.createStatement();
	ResultSet rs;
	rs=st.executeQuery("select sum(if(reservationNumChR=reservationNumber and usernameC=usernameChR,totalFare,0)) as total, firstName, lastName from user join customerUser on username = usernameC join customer_has_reservation on usernameC = usernameChR join reservation on reservationNumChR=reservationNumber group by usernameC order by total desc;");
	
	int count=0;
	while (rs.next() && count<1){
		count++;
		double total = Math.round(rs.getFloat("total") * 100.0) / 100.0;
		out.print("The best customer is "+rs.getString("firstName")+" "+rs.getString("lastName")+" with a total revenue of "+total);
				
	}
		
%>

</body>
</html>