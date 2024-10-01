<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>結帳成功</title>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/style/vgb.css"  type="text/css">
	<script>

	</script>
	<style>
            
	</style>
</head>
<body>
	<jsp:include page="/subviews/header.jsp">
	  <jsp:param value="結帳成功" name="subheader" />
	</jsp:include>

	<%@include file="/subviews/nav.jsp" %>
	<article>
		<h2>已經收到訂單，會盡快安排出貨</h2>
	</article>
	<%@include file="/subviews/footer.jsp" %>
</body>
</html>