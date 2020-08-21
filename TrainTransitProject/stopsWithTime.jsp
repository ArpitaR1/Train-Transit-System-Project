<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Stops</title>
</head>
<body>


<br>
	Go back to train schedules:
	<form method="get" action="checkScheduleResults.jsp">
	 <input type="hidden" value="<%=request.getParameter("origin")%>" name="origin"/> 
      <input type="hidden" value="<%=request.getParameter("destination")%>" name="destination"/> 
      <input type="hidden" value="<%=request.getParameter("date")%>"  name="date"/>
       <input type="submit" value="Back"/>
     </form>
<br> 
	<%
	
	 Class.forName("com.mysql.jdbc.Driver");
	   Connection con = DriverManager.getConnection("jdbc:mysql://cs336group11.cizcmkra6h8d.us-east-2.rds.amazonaws.com:3306/TrainDB","group11", "rutgers2020");
	  
	    Statement stTemp = con.createStatement();
	    
	    String trainID = request.getParameter("trainID"); 
	    ResultSet tempTransitLineName = stTemp.executeQuery("select transitLineName from trainSchedule where tsID = "+trainID+";");
	    
  if(tempTransitLineName.next()){
	out.println("Information for train number " + trainID + " of transit line " + tempTransitLineName.getString("transitLineName"));
  	}
  
  
 
	 
		Statement st = con.createStatement();
	    ResultSet rs;
	    rs = st.executeQuery("select s.name, ts.departureTime, ts.arrivalTime from trainSchedule_hasStops_station ts, station s where ts.sIDStops = s.sID and tsIDStops = "+ trainID + " order by ts.stopNumber;");
  %>
  
  <br>
  <br>
  <table>
		<tr>    
			<td> STATION || </td>
			<td> DEPARTURE TIME	|| </td>		
			<td> ARRIVAL TIME || </td>
		</tr>
		
			<%
			//parse out the results
			while (rs.next()) { %>
				<tr>    
					<td><%= rs.getString("name")%></td>
					<td><%= rs.getString("departureTime")%></td>
					<td><%= rs.getString("arrivalTime")%></td>
					
				</tr>
				

		<% } %>
		</table>


</body>
</html>
