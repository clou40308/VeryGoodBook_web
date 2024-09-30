<%@page import="java.util.List"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>註冊</title>
	<link rel="stylesheet" href="style/vgb.css"  type="text/css">
	<script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" crossorigin="anonymous"></script>
	<script>
		//$(document).ready(init);
		$(init);

		function init(){
			//alert("init");
			<% if(request.getMethod().equals("POST")){%>
			  repopulateFormData();
			
		}

		function repopulateFormData(){
			$("input[name=id]").val('${param.id}');
			$("input[name=email]").val('${param.email}');
			$("input[name=phone]").val('${param.phone}');
			$("input[name=password]").val('<%=request.getParameter("password") %>');
			$("input[name=name]").val('<%=request.getParameter("name") %>');
			$("input[name=birthday]").val('<%=request.getParameter("birthday") %>');
			$("textarea[name=address]").text('<%=request.getParameter("address") %>');
			
			$("input[name=gender][value=<%=request.getParameter("gender")%>]").prop('checked',true);
			$("input[name=subscribed]").prop('checked',<%=request.getParameter("subscribed")!=null%>);
			
			<% } %>
		}

		function refreshCaptcha() {
			//alert("refreshCaptcha");
			// var captchaImg = document.getElementById("captchaImg");
			captchaImg.src = "images/captcha.png?renew=" + new Date();
		}
	</script>
</head>

<body>
	<jsp:include page="./subviews/header.jsp">
	  <jsp:param value="註冊" name="subheader" />
	</jsp:include>
	<%@include file="./subviews/nav.jsp" %>
	<form action="register.do" method="post">
		<p>
			<label for="id">帳號:</label>
			<input type="text" name="id" id="id" required placeholder="請輸入ROC ID" pattern="[A-Z][1289][0-9]{8}">
		</p>
		<p>
			<label for="email">Email:</label>
			<input type="email" name="email" id="email" required placeholder="請輸入Email">
		</p>
		<p>
			<label for="phone">手機號碼:</label>
			<input type="tel" name="phone" id="phone" placeholder="請輸入手機號碼">
		</p>
		<p>
			<label for="password">密碼:</label>
			<input type="password" name="password" id="password" required placeholder="請輸入密碼" minlength="6" maxlength="20">
			<input type="checkbox"><label>顯示密碼</label>
		</p>
		<!-- <p>
			<label>確認密碼:</label>
			<input type="password" name="checkedPassword" required placeholder="請再次輸入確認密碼" minlength="6" maxlength="20">
			<input type="checkbox"><label>顯示密碼</label>
		</p> -->
		<p>
			<label for="name">姓名:</label>
			<input type="text" name="name" id="name" placeholder="請輸入姓名" minlength="2" maxlength="20">
		</p>
		<p>
			<label for="birthday">生日:</label>
			<input type="date" name="birthday" id="birthday" max="<%= LocalDate.now().plusYears(-Customer.MIN_AGE)%>" required>
		</p>
		<P>
			<label for="gender">性別:</label>
			<input type="radio" name="gender" id="gender" required value="<%= Customer.MALE %>"><label for="gender">男</label>
			<input type="radio" name="gender" id="gender" required value="<%= Customer.FEMALE %>"><label for="gender">女</label>
			<input type="radio" name="gender" id="gender" required value="<%= Customer.OTHERS %>"><label for="gender">不願透漏</label>
			<!-- <select name="gender" id="gender">
				<option value="">請選擇...</option>
				<option value="M">男</option>
				<option value="F">女</option>
				<option value="O">不願透漏</option>
			</select> -->
		</P>
		<p>
			<label for="address">地址:</label>
			<textarea name="address" id="address" rows="2" cols="30"></textarea>
		</p>
		<p>
			<input type="checkbox" name="subscribed">
			<label for="">是否訂閱電子報</label>
		</p>
		<p>
			<label for="captcha">驗證碼:</label>
			<input type="text" name="captcha" id="captcha"  required placeholder="請輸入驗證碼">
			<img src="images/captcha.png" alt="" title="點選即可更新驗證碼" id="captchaImg" onclick="refreshCaptcha()">
		</p>
		<%
		List<String> errors = (List<String>)request.getAttribute("errors");
		%>
		<div id="theErrorsDiv" style="color: red;">
		<%
		out.print(errors!=null?errors:"");
		%>
		</div>
		<input type="submit" value="確定">
	</form>
		<%@include file="./subviews/footer.jsp" %>
</body>

</html>