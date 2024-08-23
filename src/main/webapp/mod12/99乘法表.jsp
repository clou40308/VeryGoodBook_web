<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>99乘法表</title>
	<link rel="stylesheet" href="../style/vgb.css"  type="text/css">
	<script>

	</script>
	<style>
            
	</style>
</head>
<body>
	<h2>99乘法表</h2>
	<% for(int i = 1; i<10 ;i++){ %>
		<% for(int j = 1; j<10 ;j++){ %>
	<p><% out.println(i); %>*<% out.println(j); %>=<% out.println(i*j); %></p>
		<% } %>
	<% } %>
</body>
</html>