<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="member_edit_2.jsp">
		Address : <input type = "text" name ="m_address">
		<br />
		Phone : <input type = "text" name ="m_phone">
		<br />
		Sex : <input type = "text" name ="m_sex">
		<br />
		Age : <input type = "text" name ="m_age">
		<br />
		Job : <input type = "text" name ="m_job">
		<br />
		Type : <select name ="type">
			<option value="wholesaler">wholesaler</option>
			<option value="retailer">retailer</option>
			<option value="etc" selected>etc</option>
		</select>
		
		
		<input type="submit" value="EDIT">
		<br />
</form>
</body>
</html>