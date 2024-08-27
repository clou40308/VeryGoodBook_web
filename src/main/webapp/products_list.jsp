<%@page import="java.time.LocalDate"%>
<%@page import="uuu.vgb.entity.SpecialOffer"%>
<%@page import="uuu.vgb.entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="uuu.vgb.service.ProductService"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>產品清單</title>
    <link rel="stylesheet" href="./style/vgb.css"  type="text/css">
    <style>
        /* #productsListDiv{

        } */
        .productItem{
            display: inline-block;
            width: 280px;
            height: 380px;
            vertical-align: top;
            text-align: center;
            box-shadow: gray 2px 2px 5px;
            margin: 5px;
            /* border: black 1px solid; */
        }
        .productItem img{
            width: 200px;
            height: 200px;
            display: block;
            margin: auto;
        }
        .productItem div{
            text-align: center;
        }
    </style>
</head>

<body>
    <header>
        <h2>
            <a href="./">NoteBook</a> <sub>產品清單</sub>
        </h2>
        <form action="products_list.jsp" method="get" >
            <input type="search" name="keyword" required placeholder="請輸入關鍵字">
            <section name=category>
                <option value=""></option>
            </section>
            <input type="submit"  value="查詢">
        </form>
        <hr>
    </header>
    <nav>
        <a href="?">買筆電</a>|
        <a href="login.jsp">登入</a> |
        <a href="register.jsp">註冊</a> |
        <hr>
    </nav>
    <article> 
        <section>
            <a href="?latest=">新品</a>
            <a href="?category=華碩">華碩</a>
            <a href="?category=宏碁">宏碁</a>
            <a href="?category=AVITA">AVITA</a>
            <a href="?category=HP 惠普">HP 惠普</a>
            <a href="?">全部</a>
        </section>
        <%
            //1.取得requser的Form Data
            String keyword = request.getParameter("keyword");
            //2.呼叫商業邏輯
            ProductService pService = new ProductService();
            List<Product> list= null;
            if(keyword != null && (keyword=keyword.trim()).length()>0) {
                list = pService .getAllProductsByKeyword(keyword);
            }else{
                list = pService .getAllProducts();
            }
            
            //若查無資料
            if(list == null || list.size()==0){	
        %>
            <h2>查無資產品資料</h2>
        <%}else{ %>
    <%--     <%= list %> --%>
        <div id="productsListDiv">
            <% for(int i =0 ; i < list.size() ; i++) {
                Product p = list.get(i);
            %>
            <div class="productItem">
                <img src="<%=p.getPhotoUrl()%>">
                <h4><%=p.getName()%></h4>
                <div>優惠價:<%= p instanceof SpecialOffer?((SpecialOffer)p).getDiscountString():"" %><%=p.getUnitPrice()%>元</div>
            </div>
            <% } %>
        </div>
        <%} %>
    </article>
    <footer>
            <hr>
                <h3>NoteBook&copy;2024-08~<%=LocalDate.now().getYear()%>-<%=LocalDate.now().getMonthValue()%></h3>
    </footer>
</body>

</html>