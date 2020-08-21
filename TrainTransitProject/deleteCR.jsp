<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete Customer Rep</title>
</head>
<body>

	<%
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			
			String deleteUser = request.getParameter("crIDdelete");	
			//Create a SQL statement
			
			ResultSet rs;
		    rs=stmt.executeQuery("select * from user where username='" + deleteUser+"'");		
			

			if (!(rs.next())){
		throw new Exception();
			}
		

			String delete = "DELETE FROM user where username='"+deleteUser+"'";

			PreparedStatement ps = con.prepareStatement(delete);
			
			//ps.setString(1, deleteUser);
			ps.executeUpdate();		
		
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			out.print("Customer Rep User Account "+deleteUser+" Deleted.");
			
		}catch (Exception ex) {
			System.out.println("in catch");
			out.println("There was an error. Possible reasons are: empty fields, the user does not exist, input too long, etc.");
	%><br><a href='successAdmin.jsp'> Try Again</a><%
	} 
%>	

</body>
</html>