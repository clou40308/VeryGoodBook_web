<%@page import="java.util.Random"%>
<%@page pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Insert title here</title>
        <link rel="stylesheet" href="../style/vgb.css" type="text/css">
        <script>

        </script>
        <style>

        </style>
    </head>

    <body>
        <h1>Hello World</h1>
        <hr>
        <%
        	Random random = new Random();
        	int i = random.nextInt(20)+1; 
        	if(i>10){
        		out.println("<p>i 是大於10的整數</p>");
        	}else{
        		out.println("<p>i 是小於等於10的整數</p>");
        	}
        	out.println(i);
        %>
    </body>

    </html>