<!-- <%@page pageEncoding="UTF-8"%> -->
<!DOCTYPE html>
<%@page import="java.util.List"%>
<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>登入</title>
	<link rel="stylesheet" href="style/vgb.css"  type="text/css">
	<script>
		function refreshCaptcha() {
			//alert("refreshCaptcha");
			// var captchaImg = document.getElementById("captchaImg");
			captchaImg.src = "images/captcha.png?renew=" + new Date();
		}
		function displayPwd(){
			// alert(theCheckbox.checked);
			if(theCheckbox.checked){
				//顯示密碼
				thePassword.type="text";
			}else{
				//不顯示密碼
				thePassword.type="password";
			}
		}
	</script>
</head>

<body>
	<jsp:include page="./subviews/header.jsp">
	  <jsp:param value="登入" name="subheader" />
	</jsp:include>
	<%@include file="./subviews/nav.jsp" %>

	<%
		List<String> errors = (List<String>)request.getAttribute("errors");
	%>
	<div id="theErrorsDiv" style="color: red;">
	<%
		out.print(errors!=null?errors:"");
	%>
	</div>
	<form action="login.do" method="post">
		<p>
			<label for="id">帳號:</label>
			<input type="text" name="id" id="id" placeholder="請輸入ROC ID/Email/手機號碼">
		</p>
		<p>
			<label for="password">密碼:</label>
			<input type="password" name="password" id="thePassword" required placeholder="請輸入密碼">
			<input type="checkbox" onchange="displayPwd()"  id="theCheckbox"><label>顯示密碼</label>
		</p>
		<p>
			<label for="captcha">驗證碼:</label>
			<input type="text" name="captcha" id="captcha" required placeholder="請輸入驗證碼">
			<img src="images/captcha.png" alt="" title="點選即可更新驗證碼" id="captchaImg" onclick="refreshCaptcha()">
		</p>
		<input type="submit" value="確定">
	</form>
	<%@include file="./subviews/footer.jsp" %>
</body>

</html>