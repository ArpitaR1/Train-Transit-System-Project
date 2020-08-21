<%@page import="javax.print.attribute.standard.Destination"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Check Schedule Results</title>
</head>
<body>


<br>
	Go back to user account:
	<form method="get" action="success.jsp">
       <input type="submit" value="Back"/>
     </form>
<br> 


<%
		
    String origin = request.getParameter("origin");   
    String destination = request.getParameter("destination");
    String date=request.getParameter("date");
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336group11.cizcmkra6h8d.us-east-2.rds.amazonaws.com:3306/TrainDB","group11", "rutgers2020");
        
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select tsID, numberOfStops, travelTime, transitLineName, fixedFare, DepartureTime, arrivalTime, departureDate, s1.name, s2.name from trainSchedule as s join trainSchedule_hasOrigin_station on tsID = tsIDorg join trainSchedule_hasDestination_station on tsID = tsIDDest join station s1 on s1.sID=sIDorg join station s2 on s2.sID=sIDDest where s1.name='" + origin + "' and s2.name='" + destination + "' and departureDate='"+date+"' ORDER BY arrivalTime;");
   	String strStop="";

%>

<form method="post">

<div>
<input type="radio" id="arrival" name="command" value="arrivalTime">
<label for="arrival">Sort by Arrival</label>
<br>
<input type="radio" id="departure" name="command" value="departureTime">
<label for="departure">Sort by Departure</label>
<br>
<input type="radio" id="fare" name="command" value="fixedFare">
<label for="fare">Sort by Fare</label>
<br>
</div>

<div>
	<button type="submit">Submit</button>
</div>

</form>

<%ArrayList<String> trainIDs = new ArrayList<String>(); %>

<%

	
	String sort=request.getParameter("command");
		
	origin = request.getParameter("origin");   
	destination = request.getParameter("destination");
	date=request.getParameter("date");	
	
	st = con.createStatement();
	
	//rs = st.executeQuery("select tsID, numberOfStops, travelTime, transitLineName, fixedFare, DepartureTime, arrivalTime, departureDate, s1.name, s2.name from trainSchedule as s join trainSchedule_hasOrigin_station on tsID = tsIDorg join trainSchedule_hasDestination_station on tsID = tsIDDest join station s1 on s1.sID=sIDorg join station s2 on s2.sID=sIDDest where s1.name='" + origin + "' and s2.name='" + destination + "' and departureDate='"+date+"' ORDER BY "+sort+";");
	rs = st.executeQuery("select t1.tsIDStops as tsID, t1.transitLineName as transitLineName, t1.departureTime as departureTime, t1.name as Origin, t2.arrivalTime as arrivalTime, t2.name as Destination, t1.fixedFare as fixedFare from (select * from trainSchedule as s join trainSchedule_hasStops_station on tsID = tsIDStops join station s1 on s1.sID=sIDStops where s1.name='"+ origin + "') as t1, (select * from trainSchedule as s join trainSchedule_hasStops_station on tsID = tsIDStops join station s2 on s2.sID=sIDStops where s2.name= '" + destination + "') as t2 where t2.stopNumber > t1.stopNumber and t1.date = t2.date and t1.date = '"+ date + "' and t1.tsIDStops = t2.tsIDStops ORDER BY "+sort+";");
	
%>

	<table>
		<tr>    
			<td> TRAIN ID || </td>
			<td> DEPARTURE TIME	|| </td>		
			<td> ARRIVAL TIME || </td>
			<td> TRANSIT LINE NAME || </td>
			<td> ORIGIN || </td>
			<td> DESTINATION || </td>
			<td> FIXED FARE || </td>
			<td> STOPS </td>
			
		</tr>
			
			<%
			//parse out the results
			while (rs.next()) { %>
				<tr>    
				<%trainIDs.add(rs.getString("tsID"));%>
					<td><%= rs.getString("tsID")%></td>
					<td><%= rs.getString("departureTime")%></td>
					<td><%= rs.getString("arrivalTime")%></td>
					<td><%= rs.getString("transitLineName")%></td>
					<td><%= rs.getString("Origin")%></td>
					<td><%= rs.getString("Destination")%></td>	
					<td><%= rs.getString("fixedFare")%></td>				
					<%
						ResultSet rs2;
						st=con.createStatement();
						//rs2=st.executeQuery("select name from station join trainSchedule_hasStops_station on sidStops=sID where tsIDStops="+rs.getString("tsID")+";");
						rs2 = st.executeQuery("select name from station join trainSchedule_hasStops_station on sidStops=sID where tsIDStops="+ rs.getString("tsID")+ " and stopNumber >= (select stopNumber from station join trainSchedule_hasStops_station on sidStops=sID where tsIDStops="+ rs.getString("tsID")+ " and name = '" + rs.getString("Origin") + "') and stopNumber <= (select stopNumber from station join trainSchedule_hasStops_station on sidStops=sID where tsIDStops="+ rs.getString("tsID")+ " and name = '" + rs.getString("Destination") + "');");
						while (rs2.next()) { 	
							strStop+=rs2.getString("name")+ ", ";			   
										
						 }
						%>	

					<td> <%=strStop.substring(0,strStop.length()-2)%></td>	
					<% strStop=""; %>				
				</tr>
				

		<% } %>
		</table>
		
		<br>
		
		<br>
See more information for the stops:
	<form method="get" action="stopsWithTime.jsp">
	  Choose the ID of the train: <select name="trainID">
 <%for(int i = 0; i < trainIDs.size(); i++){
	 %>
	 <option value="<%=trainIDs.get(i)%>"><%=trainIDs.get(i)%></option>
	 
	<%
 } %>
  </select>
       <input type="hidden" value="<%=request.getParameter("origin")%>" name="origin"/>
      <input type="hidden" value="<%=request.getParameter("destination")%>" name="destination"/> 
      <input type="hidden" value="<%=request.getParameter("date")%>"  name="date"/>
       <input type="submit" value="Submit"/>
     </form>
<br> 



Book a ticket for a train with ID:<form method="get" action="reservation.jsp"> <select name="trainID">
 <%for(int i = 0; i < trainIDs.size(); i++){
	 %>
	 <option value="<%=trainIDs.get(i)%>"><%=trainIDs.get(i)%></option>
	 
	<%
 } %>
  </select>
      <input type="hidden" value="<%=request.getParameter("origin")%>" name="origin"/>
      <input type="hidden" value="<%=request.getParameter("destination")%>" name="destination"/> 
      <input type="hidden" value="<%=request.getParameter("date")%>"  name="date"/>
       <input type="submit" value="Book"/>
     </form>
<br> 
		

		
</body>
</html>