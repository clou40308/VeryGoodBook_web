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
    <style>
        #productsListDiv{

        }
        .productItem{
            display: inline-block;
            width: 280px;
            height: 350px;
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
    <h2>
        <a href="index.html">NoteBook</a> <sub>產品清單</sub>
    </h2>
    <form action="products_list.jsp" method="get" >
        <input type="search" name="keyword" required placeholder="請輸入關鍵字">
        <input type="submit"  value="查詢">
    </form>
    <hr>
    <a href="?">買筆電</a>|
    <a href="login.jsp">登入</a> |
    <a href="register.jsp">註冊</a> |
    <hr>
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
        <!-- <div class="productItem">
            <img src="https://cs-a.ecimg.tw/items/DHAS4JA900H9FQB/000001_1724406567.jpg" alt="">
            <h4>ASUS ROG 華碩TUF Gaming A15 15.6吋電競筆電黑色(R5-7535HS/16GB/1TB/RTX 3050-4G/WIN11/FA506NC-0042B7535HS)</h4>
            <div>定價:29499元</div>
        </div>
        <div class="productItem">
            <img src="https://cs-a.ecimg.tw/items/DHAEC91900HQNYI/000001_1724135632.jpg" alt="">
            <h4>ACER 宏碁【Belkin旅充組】ACER Aspire 5 15.6吋 文書效能筆電灰色(i3-1305U/8GB/512GB/WIN11/A515-58P-30EZ)</h4>
            <div>定價:13400元</div>
        </div>
        <div class="productItem">
            <img src="https://cs-a.ecimg.tw/items/DHAM8IA900GISH4/000001_1724407130.jpg" alt="">
            <h4>AVITA SATUS S102 NE15A1 粉</h4>
            <div>定價:9999元</div>
        </div>
        <div class="productItem">
            <img src="https://cs-a.ecimg.tw/items/DHAG7ZA900HLURU/000001_1724406838.jpg" alt="">
            <h4>HP 惠普Pavilion Aero 13.3吋 文書效能筆電白色(R5-7535U/16GB/512GB/WIN11/13-be2014AU)</h4>
            <div>定價:32900元</div>
        </div> -->
    </div>
    <%} %>
</body>

</html>