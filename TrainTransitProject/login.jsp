<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>

<html>
   <head>
      <title>Login Form</title>
   </head>
   <body>
  
     
     
 Enter your Login Details Below: 
<br>
	<form method="get" action="checkLoginDetails.jsp">
       Username: <input type="text" name="username"/> <br/>
       Password:<input type="password" name="password"/> <br/>
       <input type="submit" value="Submit"/>
     </form>
<br>    
     
Or, if you are a customer, create a new account
<br>
	<form method="post" action="newAccount.jsp">
	New Username: <input type="text" name="newUsername"/> <br/>
    New Password:<input type="password" name="newPassword"/> <br/>
	<input type="submit" value="Add me!">
	</form>
<br>     
     
   </body>
</html>
