<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Customer Rep Update</title>
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
	try{
		String editUser=request.getParameter("crIDedit");
		
		String newPassword=request.getParameter("newPW");
		String newFN=request.getParameter("newFirstName");
		String newLN=request.getParameter("newLastName");
		String newEmail=request.getParameter("newEmail");
		
		ApplicationDB db = new ApplicationDB();
		Connection con=db.getConnection();
		
		Statement st=con.createStatement();
	
		ResultSet rs;
	    rs=st.executeQuery("select * from user where username='" + editUser+"'");	
	    
	    if (!(rs.next()))
	    	throw new Exception();	
		
		if (newPassword!=null && newPassword!=""){
	
	st=con.createStatement();
	String update="UPDATE user SET password = ? WHERE username = ?";
	PreparedStatement ps=con.prepareStatement(update);
	if (newPassword.equals("N/A"))
		ps.setString(1, null);
	else 
		ps.setString(1,newPassword);
	
	ps.setString(2,editUser);
	ps.executeUpdate();
		
		}
		
		if (newFN!=null && newFN!=""){
	
	st=con.createStatement();
	String update="UPDATE user SET firstName = ? WHERE username = ?";
	PreparedStatement ps=con.prepareStatement(update);
	if (newFN.equals("N/A")){
		System.out.println("in if");
		ps.setString(1, null);
	}
	else 
		ps.setString(1,newFN);
	
	ps.setString(2,editUser);
	ps.executeUpdate();
		
		}
		
		if (newLN!=null && newLN!=""){
	
	st=con.createStatement();
	String update="UPDATE user SET lastName = ? WHERE username = ?";
	PreparedStatement ps=con.prepareStatement(update);
	if (newLN.equals("N/A")){
		System.out.println("in if");
		ps.setString(1, null);
	}
	else 
		ps.setString(1,newLN);
	
	ps.setString(2,editUser);
	ps.executeUpdate();
		
		}		
		
		if (newEmail!=null && newEmail!=""){
	
	st=con.createStatement();
	String update="UPDATE user SET email = ? WHERE username = ?";
	PreparedStatement ps=con.prepareStatement(update);
	if (newEmail.equals("N/A")){
		System.out.println("in if");
		ps.setString(1, null);
	}
	else 
		ps.setString(1,newEmail);
	
	ps.setString(2,editUser);
	ps.executeUpdate();
	out.println(editUser + " edited");
		}
		
	}catch (Exception e){
		out.println("There was an error. Possible reasons are: empty user ID field, account does not exist, input too long, etc.");
%><br><a href='successAdmin.jsp'> Try Again</a><%
	}
%>

</body>
</html>