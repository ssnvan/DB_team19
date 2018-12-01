<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language = "java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Log in</title>
</head>
<body>
<% 
	String serverIP="localhost";
	String strSID="orcl";
	String portNum="1521";
	String url="jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	String user="knu";
	String pass="comp322";
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);

	String a="";
	String id = (String)request.getParameter("id"), pw = (String)request.getParameter("pw");
	
	if( id.equals("admin")&& pw.equals("0000")){
		a="login admin";
	}
	else{
	
		String query="SELECT PW FROM Customer WHERE Customer_ID = " + id;
		pstmt = conn.prepareStatement(query);
		rs=pstmt.executeQuery();
	
		String t_pw="";
		out.println("<table border=\"1\">");
		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		
		while(rs.next()){
		
			t_pw  = (String)rs.getString(1);
		}
	
		
		if( t_pw.equals("3373") ){
			a="login";
		}
		else{
			a="Your ID / PW is wrong...";
		}
		out.println("<h2>"+pw+"</h2>");
		out.println("<h2>"+t_pw+"</h2>");
		out.println("<h2>"+t_pw.equals(pw)+"</h2>");
		out.println("<h2>"+a+"</h2>");
	}
	
%>
	

</body>
</html>