<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>[INSERT title HERE]</title>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/style/vgb.css"  type="text/css">
	<script>

	</script>
	<style>
            
	</style>
</head>
<body>
	<jsp:include page="/subviews/header.jsp">
	  <jsp:param value="[INSERT title HERE]" name="subheader" />
	</jsp:include>

	<%@include file="/subviews/nav.jsp" %>
	<article>
		
	</article>
	<%@include file="/subviews/footer.jsp" %>
</body>
</html>