<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New Account</title>
</head>
<body>

<%
	try {

		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

	
		Statement stmt = con.createStatement();
		
		String insert = "insert into reservation (discount, totalFare, date, tripType) values (?, ?, current_date(), ?)";
	
		PreparedStatement ps = con.prepareStatement(insert);
		
		int discount;
		float fare;
		
		String discountString = request.getParameter("discount");
		
		if(discountString.equals("Senior")){
	
	discount = 35;
	
		}else if(discountString.equals("Child")){
	
	discount = 25;
	
		}else if(discountString.equals("Disabled")){
	
	discount = 50;
	
		}else{
	discount = 0;
		}
		
		String tripType = request.getParameter("tripType");
		
		 Statement stTemp1 = con.createStatement();
		 ResultSet rsTemp1 = stTemp1.executeQuery("select numberOfStops, fixedFare from trainSchedule where tsID = " + request.getParameter("trainID") + ";");
		 rsTemp1.next();
		 
		 int totalNumberOfStops = rsTemp1.getInt("numberOfStops");
		 int fixedFare = rsTemp1.getInt("fixedFare");
		 
		 Statement stTemp2 = con.createStatement();
		 ResultSet rsTemp2 = stTemp2.executeQuery("select s2.stopNumber - s1.stopNumber as numberOfStops from (select stopNumber from trainSchedule_hasStops_station join station on sIDStops = sID where tsIDStops = " +  request.getParameter("trainID") + " and name = '" +  request.getParameter("origin") + "') s1, (select stopNumber from trainSchedule_hasStops_station join station on sIDStops = sID where tsIDStops = "+  request.getParameter("trainID") +" and name = '" +  request.getParameter("destination") + "') s2;");
		 
		 rsTemp2.next(); 	
		 int numberOfStops =  rsTemp2.getInt("numberOfStops");
		
	
		
		
		 
		 double price = ((double)fixedFare / (double)totalNumberOfStops) * (double)numberOfStops * ((double)((double)(100.00 - discount) / 100.00));
		 
		if(tripType.equals("Round Trip")){
		price = 2 * price;
		}
		
		
		
		
		price = Math.round(price * 100.0) / 100.0;
		
		fare = Float.valueOf(String.valueOf(price));
		
		
		ps.setInt(1, discount);
		ps.setFloat(2, fare);
		ps.setString(3, request.getParameter("tripType"));
		ps.executeUpdate();
		
		insert = "insert into customer_has_reservation (reservationNumChR, usernameChR) values (?, ?)";
		
		ps = con.prepareStatement(insert);
		
		 Statement st = con.createStatement();
		 ResultSet rs;
		 rs = st.executeQuery("select max(reservationNumber) from reservation;");
		 rs.next();
		 int rID = rs.getInt("max(reservationNumber)");
		 
		 String user = String.valueOf(session.getAttribute("user"));
		
		ps.setInt(1, rID);
		ps.setString(2, user);
		ps.executeUpdate();
		
		
		
		insert = "insert into reservation_hasOrigin_station (reservationNumberRHOS, sIDRHOS, originTime) values (?, ?, ?)";
		
		ps = con.prepareStatement(insert);
		
		st = con.createStatement();
		ResultSet rs2;
		rs2 = st.executeQuery("select sID from station where name = '" + request.getParameter("origin") +"';");
		rs2.next();
		int origin = rs2.getInt("sID");
		
		st = con.createStatement();
		rs2 = st.executeQuery("select departureTime from trainSchedule_hasStops_station where tsIDStops = "+ request.getParameter("trainID") + " and sIDStops = " + origin + ";"); 
	   	rs2.next();
		ps.setInt(1, rID);
		ps.setInt(2, origin);
		ps.setTime(3, rs2.getTime("departureTime"));
		ps.executeUpdate();
		
		insert = "insert into reservation_has_destinationStation (reservationNumRhS, sIDRhS, destinationTime) values (?, ?, ?)";
		
		ps = con.prepareStatement(insert);
		
		st = con.createStatement();
		ResultSet rs3;
		rs3 = st.executeQuery("select sID from station where name = '" + request.getParameter("destination") +"';");
		rs3.next();
		int destination = rs3.getInt("sID");
		
		st = con.createStatement();
		rs3 = st.executeQuery("select arrivalTime from trainSchedule_hasStops_station where tsIDStops = "+ request.getParameter("trainID") + " and sIDStops = " + destination + ";"); 
	   	rs3.next();
		
		
		ps.setInt(1, rID);
		ps.setInt(2, destination);
		ps.setTime(3, rs3.getTime("arrivalTime"));
		ps.executeUpdate();
		
		insert = "insert into reservation_has_train (reservationNumberRHT, tIDRHT) values (?, ?)";
		
		ps = con.prepareStatement(insert);
		
		st = con.createStatement();
		ResultSet rs4;
		rs4 = st.executeQuery("select tIDTHS as tID from train_has_trainSchedule where tsIDTHS = " + request.getParameter("trainID") + ";");
		rs4.next();
		int tID = rs4.getInt("tID");
		
		ps.setInt(1, rID);
		ps.setInt(2, tID);
		ps.executeUpdate();
		
		//ADMIN MANAGES RESERVATION OR NO!!!!!!!!!!!!!
		//
		//
		//
		//
		//
		
		con.close();
		out.print("Reservation made for train from " + request.getParameter("origin") +" to " + request.getParameter("destination") + " on " + request.getParameter("date"));
%><br><a href='success.jsp'>Go back to User Account</a><%
		
		}catch (Exception ex) {
			out.print(ex);
			out.print("Error please try again");
		%><br><a href='success.jsp'>Go back to User Account</a><%
		}
	%>


</body>
</html>