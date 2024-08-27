<%@page pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Insert title here</title>
		<script>

		</script>
		<style>
			p label {
				color: blue;
			}
		</style>
	</head>

	<body>
		<h2>Implicit Variables 隱含變數(request,session)</h2>
		<hr>
		<h3>request</h3>
		<p><label>request.getMethod():</label>
			<%=request.getMethod() %>
		</p>
		<p><label>request.getRequestURL():</label>
			<%=request.getRequestURL() %>
		</p>
		<p><label>request.getRequestURI():</label>
			<%=request.getRequestURI() %>
		</p>
		<p><label>request.getProtocol():</label>
			<%=request.getProtocol() %>
		</p>
		<p><label>request.getLocalName():伺服器名稱</label>
			<%=request.getLocalName() %>
		</p>
		<p><label>request.getLocalPort():伺服器port</label>
			<%=request.getLocalPort() %>
		</p>	
		<p><label>request.getLocalAddr():伺服器 ip address</label>
			<%=request.getLocalAddr() %>
		</p>
		<p><label>request.getRemoteHost():Client 名稱</label>
			<%=request.getRemoteHost() %>
		</p>
		<p><label>request.getRemotePort():Client port</label>
			<%=request.getRemotePort() %>
		</p>
		<p><label>request.getRemoteAddr():Client Addr</label>
			<%=request.getRemoteAddr() %>
		</p>
		<p><label>request.getQueryString():</label>
			<%=request.getQueryString() %>
		</p>
		<hr>
		request headers:
		<p><label>request.getHeader("accept-language"):</label>
			<%=request.getHeader("accept-language") %></p>
		<p><label>request.getHeader("user-agent"):</label>
			<%=request.getHeader("user-agent") %></p>
		<hr>
		request form data:
		<form action="" method="post">
			<input name="id">
			<input name="name">
			<input name="phone">
			<input type="submit">
		</form>
		<p>request.getParameter("id"): <%= request.getParameter("id") %></p>
		<p>request.getParameter("name"): <%= request.getParameter("name") %></p>
		<p>request.getParameter("phone"): <%= request.getParameter("phone") %></p>
		<hr>
		<h3>session(邏輯的連線)</h3>
		<p>session id<%= session.getId() %></p>
	</body>

	</html>