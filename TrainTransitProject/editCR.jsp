<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Customer Rep</title>
</head>
<body>
 <%
 	try {
 		ApplicationDB db = new ApplicationDB();
 		Connection con = db.getConnection();
 		Statement stmt = con.createStatement();
 		
 		String editUser = request.getParameter("crIDedit");
 		
 		ResultSet rs;
 	    rs=stmt.executeQuery("select * from user where username='" + editUser+"'");	
 	    
 	    if (!(rs.next()))
 	    	throw new Exception();
 %>
	    	<form method="get" action="editCRupdate.jsp">
			<div>
				New Password? <br> <input type="text" id="password" name="newPW"><br>
				New First Name? <br> <input type="text" id="firstName" name="newFirstName"><br>
				New Last Name? <br> <input type="text" id="lastName" name="newLastName"><br>
				New Email? <br> <input type="text" id="email" name="newEmail"><br>				
			</div>
			<div>
			<input type="submit" value="Submit">
			</div>
			</form>	    
	    <%

	    	
	    
	} catch (Exception e){
		out.println("There was an error. Possible reasons are: empty fields, account does not exist, input too long, etc.");
		%><br><a href='successAdmin.jsp'> Try Again</a><%
	}
 %>

</body>
</html>