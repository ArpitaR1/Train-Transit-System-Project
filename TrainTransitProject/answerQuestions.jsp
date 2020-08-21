<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Answer Questions</title>
</head>
<body>

<br>
	Go back to customer rep account:
	<form method="get" action="successCR.jsp">
       <input type="submit" value="Back"/>
     </form>
<br> 


<%
		
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336group11.cizcmkra6h8d.us-east-2.rds.amazonaws.com:3306/TrainDB","group11", "rutgers2020");
        
    Statement st = con.createStatement();
    ResultSet rs;
	rs = st.executeQuery("select * from messages where answer is NULL;");

%>



<%
	String id = request.getParameter("mID");   
	String answer = request.getParameter("answer");



		String insert = "UPDATE messages SET answer = ? WHERE mID = ?";
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setString(1, answer);
		ps.setString(2, id);
		ps.executeUpdate();
	
		st = con.createStatement();
		rs = st.executeQuery("select * from messages where mID=" + id + ";");
		if (rs.next()){
		insert = "INSERT INTO customerRepUser_repliesQuestion_messages(mID,usernameCRrM)" + "VALUES (?,?)";
		ps = con.prepareStatement(insert);
		ps.setString(1, id);
		String userID = request.getSession().getAttribute("user").toString();
		ps.setString(2,userID);
		ps.executeUpdate();
		}
	
	st = con.createStatement();
		rs = st.executeQuery("select * from messages where answer = 'Not answered yet.';");

	
%>

	<table>
		<tr>    
			<td> ID  </td>
			<td> QUESTION	 </td>		
			<td> ANSWER  </td>
			<td> DATE  </td>
			<td> TIME </td>
		</tr>
			
			<%
			//parse out the results
			while (rs.next()) { %>
				<tr>    
					<td><%= rs.getString("mID")%></td>
					<td><%= rs.getString("question")%></td>
					<td><%= rs.getString("answer")%></td>
					<td><%= rs.getString("date")%></td>
					<td><%= rs.getString("time")%></td>
				</tr>
				

		<% } %>
		</table>

<div>
<br>
<label for="keyword">Reply Here</label>
<br>
	<form method="get" >
       Message ID: <input type="text" name="mID"/> <br/>
       Response: <input type="text" name="answer"/> <br/>
       <input type="submit" value="Submit"/>
     </form>
<br>

</div>

</body>
</html>