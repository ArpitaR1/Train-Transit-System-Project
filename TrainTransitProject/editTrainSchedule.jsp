<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Train Schedules</title>
</head>
<body>

	Go back to Customer Representative:
	<form method="get" action="successCR.jsp">
       <input type="submit" value="Back"/>
     </form>
<br> 

<%
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336group11.cizcmkra6h8d.us-east-2.rds.amazonaws.com:3306/TrainDB","group11", "rutgers2020");
        
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from trainSchedule");
   	String strStop="";
   	
    String tsID = (request.getParameter("tsID"));
    String numberOfStops = "";
    String travelTime = "";
    String transitLineName = "";
    String fixedFare = "";
    String date = "";
    
    if (tsID != null && tsID != ""){
	 	 st = con.createStatement();	
	 	 rs = st.executeQuery("select * from trainSchedule where tsID="+tsID+";");
	 	 if (rs.next()){
		 	 numberOfStops = rs.getString("numberOfStops");
		 	 travelTime = rs.getString("travelTime");
		 	 transitLineName = rs.getString("transitLineName");
		 	 fixedFare = rs.getString("fixedFare");
		 	 date = rs.getString("date");
	 	 }
    }

%>

<div>
	<form method="get" >
	<label>Enter the Train Schedule ID you want to Edit</label><br/>
       Train Schedule ID: <input type="text" name="tsID" > <br/><br/>
       <label>Edit Values</label><br>
       Number of Stops: <input type="text" id ="numStops" name="numStops" > <br/>
       Travel Time: <input type="text" name="travelTime" > <br/>
       Transit Line Name: <input type="text" name="transitLine" > <br/>
       Total Fare: <input type="text" name="fare" > <br/>  
       Date: <input type="text" name="date" > <br/>  
       <input type="submit" id="submit" value="Edit" onclick="myFunction()"/><br/><br/> 
     </form>
</div>


<script>
function myFunction() {
	<% 
	numberOfStops = request.getParameter("numStops");
	travelTime = request.getParameter("travelTime");
	transitLineName = request.getParameter("transitLine");
	fixedFare = request.getParameter("fare");
	date = request.getParameter("date");
	
	if (tsID != null){
		if (numberOfStops != null && numberOfStops != ""){
			String insert = "UPDATE trainSchedule SET numberOfStops = ? WHERE tsID = ?";
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1, numberOfStops);
			ps.setString(2, tsID);
			ps.executeUpdate();		
		}
		
		if (travelTime != null && travelTime != ""){
			String insert = "UPDATE trainSchedule SET travelTime = ? WHERE tsID = ?";
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1, travelTime);
			ps.setString(2, tsID);
			ps.executeUpdate();		
		}
		
		if (transitLineName != null && transitLineName != ""){
			String insert = "UPDATE trainSchedule SET transitLineName = ? WHERE tsID = ?";
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1, transitLineName);
			ps.setString(2, tsID);
			ps.executeUpdate();	
		}
		
		if (fixedFare != null && fixedFare != ""){
			String insert = "UPDATE trainSchedule SET fixedFare = ? WHERE tsID = ?";
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1, fixedFare);
			ps.setString(2, tsID);
			ps.executeUpdate();	
		}
		
		if (date != null && date != ""){
			String insert = "UPDATE trainSchedule SET date = ? WHERE tsID = ?";
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1, date);
			ps.setString(2, tsID);
			ps.executeUpdate();	
		}
	}
    %>
	
}
</script>


<%
	String sort=request.getParameter("command");
	
	st = con.createStatement();
	
	rs = st.executeQuery("select * from trainSchedule");
	
%>


	<table>
		<tr>    
			<td> TRAIN ID </td>
			<td> NUMBER OF STOPS </td>		
			<td> TRAVEL TIME </td>
			<td> TRANSIT LINE NAME || </td>
			<td> TOTAL FARE || </td>
			<td> DATE </td>
		</tr>
			
			<%
			//parse out the results
			while (rs.next()) { %>
				<tr>    
					<td><%= rs.getString("tsID")%></td>
					<td><%= rs.getString("numberOfStops")%></td>
					<td><%= rs.getString("travelTime")%></td>
					<td><%= rs.getString("transitLineName")%></td>
					<td><%= rs.getString("fixedFare")%></td>	
					<td><%= rs.getString("date")%></td>							
				</tr>
				

		<% } 
		con.close();
		%>
		</table>


</body>
</html>