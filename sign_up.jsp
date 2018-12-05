<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language = "java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String DB_URL = "jdbc:mysql://localhost:3306/shoppingmallX?characterEncoding=UTF-8&serverTimezone=UTC";
	String DB_USER = "root";
	String DB_PASSWORD= "8888";
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	Statement stmt;
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

	stmt = conn.createStatement();

	String query ="";
	
	String s_id = (String)request.getParameter("s_id");
	String s_pw = (String)request.getParameter("s_pw");
	String s_address = (String)request.getParameter("s_address");
	String s_phone = (String)request.getParameter("s_phone");
	String s_sex = (String)request.getParameter("s_sex");
	String s_age = (String)request.getParameter("s_age");
	String s_job = (String)request.getParameter("s_job");
	String s_type = (String)request.getParameter("s_type");
	
	
	int age = -1;
	boolean a = true;
	try{
		age = Integer.parseInt(s_age);
	}catch(NumberFormatException e){
		System.out.println(e.getMessage());
		a=false;
	}
	
	boolean s_value=false;
	if(s_sex.equals("F") || s_sex.equals("M")){
		s_value = false;
	}
	else{
		s_value=true;
	}
	
	
	if( s_id.equals("") || s_id.length()>10 || s_pw.length()>10 || s_address.length() > 10 || s_phone.length() > 10 || s_value || (age <0 && age>100) || s_job.length() > 10 ){
		response.sendRedirect("sign_up.html");
	}
	
	if(a){
	query="INSERT INTO Customer values ('" + s_id+"', '"
			+s_pw + "', '" +s_address + "', '" +s_phone + "', '" +s_sex + "', "+s_age + ", '"
			+s_job + "', '"+s_type + "')";
	}else{
		query="INSERT INTO Customer values ('" + s_id+"', '"
				+s_pw + "', '" +s_address + "', '" +s_phone + "', '" +s_sex + "', null, '"
				+s_job + "', '"+s_type + "')";
		
	}
	System.out.println(query);
	pstmt = conn.prepareStatement(query);
	int rst=0;
	try{
		rst=pstmt.executeUpdate();
	}catch(com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e){
		System.out.println(e.getErrorCode());
	}
	if(rst == 1){
		query="SELECT Cart_code FROM Cart order by Cart_code desc limit 1";
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		
		String cart_code = "";
		while(rs.next()){
			cart_code = rs.getString(1);
		}
		cart_code = cart_code.substring(4);
		int cart_num = Integer.parseInt(cart_code)+1;
		cart_code = "cart"+cart_num;
		query = "insert Cart values('"+cart_code+"', '"+s_id+"')";
		System.out.println(query);
		stmt.executeUpdate(query);
		out.println("<br />"
				+"<a href=\"start.html\">SUCCESS!</a>"
				+"<br />");
	}
	else{
		response.sendRedirect("sign_up.html");	
	}
	%>
	
</body>
</html>