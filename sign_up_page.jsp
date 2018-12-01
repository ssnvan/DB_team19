<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
	<body>
		<form action = "sign_up.jsp" method = "POST">
			ID  : <input type = "text" name = "sign_id">
			<br />
			PW : <input type = "text" name ="sign_pw">
			<br />
			Address : <input type = "text" name ="address">
			<br />
			Phone : <input type = "text" name ="phone">
			<br />
			Sex : <input type = "text" name ="sex">
			<br />
			Age : <input type = "text" name ="age">
			<br />
			Job : <input type = "text" name ="job">
			<br />
			Type : <select name ="type">
				<option value="wholesaler">wholesaler</option>
				<option value="retailer">retailer</option>
				<option value="etc">etc</option>
			</select>
			<br />
			
			<input type = "submit" value = "SIGN UP">
		</form>


</body>
</html>