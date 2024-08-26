<%@page pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>99乘法表(Table)</title>
		<link rel="stylesheet" href="../style/vgb.css" type="text/css">
		<script>

		</script>
		<style>
			#_99table {
				font-family: Arial, Helvetica, sans-serif;
				border-collapse: collapse;
				background-color: burlywood;
				width: 100%;
			}

			#_99table td,
			#_99table th {
				border: 1px solid #ddd;
				padding: 8px;
			}

			#_99table tr:nth-child(even) {
				background-color: #f2f2f2;
			}

			#_99table tr:hover {
				background-color: #ddd;
			}

			#_99table caption {
				padding-top: 12px;
				padding-bottom: 12px;
				text-align: center;
				background-color: #04AA6D;
				color: white;
				font-size: 20px;
			}
		</style>
	</head>

	<body>
		<table id="_99table">
		<caption>99乘法表</caption>
		<%  for(int i=1; i<10 ;i++){ %>
			<tr>
			<% for(int j=1; j<10 ;j++){ %>
				<td><%= i %> * <%= j %> = <%= i * j %></td>	
			<% } %>
			</tr>
		<% } %>
		</table>
	</body>

	</html>