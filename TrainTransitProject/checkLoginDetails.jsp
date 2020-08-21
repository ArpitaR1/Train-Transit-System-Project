<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Check Login Details</title>
</head>
<body>

<%
	

    String userid = request.getParameter("username");   
    String pwd = request.getParameter("password");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336group11.cizcmkra6h8d.us-east-2.rds.amazonaws.com:3306/TrainDB","group11", "rutgers2020");
    
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from user where username='" + userid + "' and password='" + pwd + "'");
   
  
    if (rs.next()){
        request.getSession().setAttribute("user", userid); // the username will be stored in the session
        
        //checks if Customer
        st=con.createStatement();
        ResultSet rsC=st.executeQuery("select * from customerUser where usernameC='" + userid + "'");
        if (rsC.next()){
        	 out.println("welcome " + userid);
             out.println("<a href='logout.jsp'>Log out</a>");
             response.sendRedirect("success.jsp");
        }
        
        //checks if CR
        st=con.createStatement();
        ResultSet rsCR=st.executeQuery("select * from customerRepUser where usernameCR='" + userid + "'");
        if (rsCR.next()){
        	 out.println("welcome " + userid);
             out.println("<a href='logout.jsp'>Log out</a>");
             response.sendRedirect("successCR.jsp");
        }  
        
        //check if Admin
        st=con.createStatement();
        ResultSet rsA=st.executeQuery("select * from adminUser where usernameAdmin='" + userid + "'");
        if (rsA.next()){
        	 out.println("welcome " + userid);
             out.println("<a href='logout.jsp'>Log out</a>");
             response.sendRedirect("successAdmin.jsp");
        }        
       
    } 
    
    else {
        out.println("Invalid credentials <a href='login.jsp'>Try again</a>");
    }
%>


</body>
</html>