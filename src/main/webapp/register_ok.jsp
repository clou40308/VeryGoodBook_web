<%@page import="uuu.vgb.entity.Customer"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>註冊成功</title>
    <link rel="stylesheet" href="style/vgb.css"  type="text/css">
    <meta http-equiv="refresh" content="10;url=./">
</head>

<body>
    <h2>
        <a href="./">NoteBook</a> <sub>註冊成功</sub>
    </h2>
    <hr>
    <a href="login.jsp">登入</a> |
    <a href="register.jsp">註冊</a> |
    <hr>
    <p>
        <%
        Customer member = (Customer)request.getAttribute("member");
        //out.println(member!=null?member.getName():"XXX");
        %>
        <%=member!=null?member.getName():"XXX"%>，您好!10秒後自動轉址至<a href="./">首頁</a>
    </p>
	<%@include file="./subviews/footer.jsp" %>
    <!-- <script>
        document.write(new Date());
    </script> -->
</body>

</html>