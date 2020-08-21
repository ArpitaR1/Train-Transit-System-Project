<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.LocalDateTime"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Questions</title>
</head>
<body>

<br>
	Go back to user account:
	<form method="get" action="success.jsp">
       <input type="submit" value="Back"/>
     </form>
<br> 
<br>

<%

		
    String keyword = request.getParameter("command");
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336group11.cizcmkra6h8d.us-east-2.rds.amazonaws.com:3306/TrainDB","group11", "rutgers2020");
        
    Statement st = con.createStatement();
    ResultSet rs;
	rs = st.executeQuery("select * from messages;");

%>
<script>
function myFunction() {
  document.getElementById("keyword").value = "";
}
</script>

<form method="post">

<div>

<label for="keyword">Search by Keyword</label>
<br>
<input type="text" id="keyword" name="command">
<br>
</div>

<div>
	<button type="submit">Search</button>
</div>
<br>



</form>

<%
	String newQuestion = request.getParameter("question");
	keyword =  request.getParameter("command");	
	st = con.createStatement();
	rs = st.executeQuery("select count(*) as count from messages where question ='"+newQuestion+"';");
	
	if (rs.next()){
		if (Integer.parseInt(rs.getString("count")) == 0){
			if (newQuestion !=null){
				String mID = "";
				st = con.createStatement();
				rs = st.executeQuery("select mID from messages where mID=(SELECT max(mID) from messages);");
				
				   DateTimeFormatter d = DateTimeFormatter.ofPattern("MM/dd/yyyy");  
				   DateTimeFormatter t = DateTimeFormatter.ofPattern("HH:mm:ss");  
				   LocalDateTime now = LocalDateTime.now();  
				   String date = (d.format(now));
				   String time = (t.format(now));
				
				if (rs.next()){
					mID = (Integer.parseInt(rs.getString("mID"))+1) + "";
					String insert = "INSERT INTO messages(mid,question,date,time)" + "VALUES (?,?,?,?)";
					PreparedStatement ps = con.prepareStatement(insert);
					ps.setString(1, mID.toString());
					ps.setString(2, newQuestion);
					ps.setString(3, date);
					ps.setString(4, time);
					ps.executeUpdate();
					
					insert = "INSERT INTO customerUser_asksQuestion_messages(mIDaQM,usernameCaM)" + "VALUES (?,?)";
					ps = con.prepareStatement(insert);
					ps.setString(1, mID.toString());
					String userID = request.getSession().getAttribute("user").toString();
					ps.setString(2,userID);
					ps.executeUpdate();
				}
			}
		}
	}
	
	st = con.createStatement();
	if (keyword == null  ){
		rs = st.executeQuery("select * from messages;");
		
	}else{
		rs = st.executeQuery("select * from messages where question like '%"+keyword+"%';");
		
	}
	
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
</div>
<div>
<label for="submit">Enter New Question</label>
<br>
	<form method="get" >
       Question: <input type="text" name="question"/> <br/>
       <input type="submit" value="Submit"/>
     </form>
<br>
</div>

</body>
</html>