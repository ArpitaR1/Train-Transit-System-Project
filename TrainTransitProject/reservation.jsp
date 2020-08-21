<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>

<html>
   <head>
   <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
      <title>Reservation</title>
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


<form method="post" action="reservationMade.jsp">
	Trip Type: 
	<select name="tripType">
	 <option value="Round Trip">Round Trip</option>
	  <option value="One Way">One Way</option>
  </select>
  <br>
  
  Age/Discount:
  <select name="discount">
  	<option value="Adult">Adult</option>
	 <option value="Senior">Senior</option>
	 <option value="Child">Child</option>
	 <option value="Disabled">Disabled</option>
  </select>
  <br>
   	<input type="hidden" value="<%=request.getParameter("origin")%>" name="origin"/> 
     <input type="hidden" value="<%=request.getParameter("destination")%>" name="destination"/>
  	 <input type="hidden" value="<%=request.getParameter("date")%>"  name="date"/>
  	 <input type="hidden" value="<%=request.getParameter("trainID")%>"  name="trainID"/>
	<input type="submit" value="Reserve">
	</form>
<br>  
  
	

	

</body>
</html>