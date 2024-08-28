<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>404</title>
	<link rel="stylesheet" href="../style/vgb.css"  type="text/css">
	<script>

	</script>
	<style>
		img{
			width: 300px;
			display: block;
			margin: auto;
		}
	</style>
</head>
<body>
	<jsp:include page="../subviews/header.jsp">
	  <jsp:param value="404" name="subheader" />
	</jsp:include>
	<%@include file="../subviews/nav.jsp" %>
	<article>
	<p>找不到檔案:<%=request.getAttribute("javax.servlet.error.request_uri") %></p>
	<img src="/vgb/images/404_icon.png" >
	</article>
	<%@include file="../subviews/footer.jsp" %>
</body>
</html>