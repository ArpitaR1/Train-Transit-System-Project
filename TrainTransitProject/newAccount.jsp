<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
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

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			String newUser = request.getParameter("newUsername");
			String newPW = request.getParameter("newPassword");
			//Create a SQL statement
			Statement stmt = con.createStatement();
			ResultSet rs;
		    rs=stmt.executeQuery("select * from user where username='" + newUser+"'");		
			

			if (rs.next()){
		throw new Exception();
			}
		
			
			String insert = "INSERT INTO user(username,password)"
			+ "VALUES (?,?)";
			
			PreparedStatement ps = con.prepareStatement(insert);

			ps.setString(1, newUser);
			ps.setString(2, newPW);
			ps.executeUpdate();
			
			insert="INSERT INTO customerUser(usernameC)"
			+ "VALUES (?)";
		
			PreparedStatement psC = con.prepareStatement(insert);
			psC.setString(1, newUser);
			psC.executeUpdate();		
		
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			out.print("Customer User Account Created");
	%><br><a href='login.jsp'> Login</a><%
		
	}catch (Exception ex) {
		out.println("There was an error. Possible reasons are: empty fields, duplicate username, input too long, etc.");
		%><br><a href='login.jsp'> Try Again</a><%
	} 
%>



</body>
</html>