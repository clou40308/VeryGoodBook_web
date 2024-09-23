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
	<%//request.setCharacterEncoding("UTF-8"); %>
	<jsp:include page="./subviews/header.jsp">
	  <jsp:param value="產品清單" name="subheader" />
	</jsp:include>
	<%@include file="./subviews/nav.jsp" %>
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
            //1.取得requser的Form Data/QueryString
            String keyword = request.getParameter("keyword");
       		String latest = request.getParameter("latest");
        	String category = request.getParameter("category");
        	
            //2.呼叫商業邏輯
            ProductService pService = new ProductService();
            List<Product> list= null;
            if(keyword != null && (keyword=keyword.trim()).length()>0) {
                list = pService .getAllProductsByKeyword(keyword);
            }else if(latest != null && (latest=latest.trim()).length()>0){
                	list = pService .getLatestProducts();
            }else if(category != null && (category=category.trim()).length()>0){
            	list = pService .getProductsByCategory(category);
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
                <a href="products_detail.jsp?productId=<%=p.getId() %>"><img src="<%=p.getPhotoUrl()%>"></a> <!--TODO: ajax+json-->
                <a href="products_detail.jsp?productId=<%=p.getId() %>"><h4><%=p.getName()%></h4></a> <!--同步GET請求-->
              
                <div>優惠價:<%= p instanceof SpecialOffer?((SpecialOffer)p).getDiscountString():"" %><%=p.getUnitPrice()%>元</div>
            </div>
            <% } %>
        </div>
        <%} %>
    </article>
	<%@include file="./subviews/footer.jsp" %>
</body>

</html>