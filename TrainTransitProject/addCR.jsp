<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Customer Rep</title>
</head>
<body>


<br>
	Go back to Admin account:
	<form method="get" action="successAdmin.jsp">
       <input type="submit" value="Back"/>
     </form>
<br> 
<br>

	<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			
			String newUser = request.getParameter("crIDadd");	
			String newPW = request.getParameter("crPWadd");
			//Create a SQL statement
			
			ResultSet rs;
		    rs=stmt.executeQuery("select * from user where username='" + newUser+"'");		
			

			if (rs.next()){
		throw new Exception();
			}
		

			String insert = "INSERT INTO user(username,password) VALUES (?,?)";

			PreparedStatement ps = con.prepareStatement(insert);
			
			ps.setString(1, newUser);
			ps.setString(2, newPW);
			ps.executeUpdate();
			
			insert="INSERT INTO customerRepUser(usernameCR)"
			+ "VALUES (?)";
		
			PreparedStatement psC = con.prepareStatement(insert);
			psC.setString(1, newUser);
			psC.executeUpdate();		
		
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			out.print("Customer Rep User Account Created.");
		
		
	}catch (Exception ex) {
		System.out.println("in catch");
		out.println("There was an error. Possible reasons are: empty fields, duplicate ID for an existing representative, input too long, etc.");
		%><br><a href='successAdmin.jsp'> Try Again</a><%
	} 
%>

</body>
</html>