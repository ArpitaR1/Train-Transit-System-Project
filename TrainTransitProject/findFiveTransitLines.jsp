<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find Five Transit Lines</title>
</head>
<body>


<%
	String input=request.getParameter("activeMonth");
	String month=input.substring(0,2);
	String year=input.substring(3,7);	

	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://cs336group11.cizcmkra6h8d.us-east-2.rds.amazonaws.com:3306/TrainDB","group11", "rutgers2020");
	
	Statement st=con.createStatement();
	ResultSet rs;
	rs=st.executeQuery("select sum(if(reservationNumberRHT=reservationNumber,1,0)) as total, transitLineName from reservation r join reservation_has_train on reservationNumberRHT = reservationNumber join train_has_trainSchedule on tIDRHT = tIDTHS join trainSchedule on tsIDTHS=tsID where r.date like '"+year+"-"+month+"%' group by transitLineName order by total desc;");
	
	%> The five most active transit lines for <% out.print(month+"/"+year); %> were <br> <%
	int count=0;
	while (rs.next() && count<5){
		System.out.println("in count");
		count++;
		out.println(count+". "+rs.getString("transitLineName")+" with "+rs.getString("total")+" reservations.");
		%><br><%
				
	}
		
%>

</body>
</html>