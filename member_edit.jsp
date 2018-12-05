<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>MEMBER INFO EDIT</h2>
<form action="member_edit_2.jsp">
		Address : <input type = "text" name ="m_address">
		<th>(length: 1 ~ 10)</th>
		<br />
		Phone : <input type = "text" name ="m_phone">
		<th>(length: 1 ~ 13)</th>
		<br />
		Sex : <input type = "text" name ="m_sex">
		<th>(F or M)</th>
		<br />
		Age : <input type = "text" name ="m_age">
		<th>(0~100)</th>
		<br />
		Job : <input type = "text" name ="m_job">
		<th>(length: 1 ~ 15)</th>
		<br />
		Type : <select name ="m_type">
			<option value="wholesaler">wholesaler</option>
			<option value="retailer">retailer</option>
			<option value="etc" selected>etc</option>
		</select>
		
		
		<input type="submit" value="EDIT">
		<br />
		<a href="login_success.jsp">BACK</a>
</form>
</body>
</html>