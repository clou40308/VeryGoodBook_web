package uuu.vgb.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.vgb.entity.Product;
import uuu.vgb.entity.ShoppingCart;
import uuu.vgb.entity.Size;
import uuu.vgb.exception.VGBException;
import uuu.vgb.service.ProductService;

/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/add_to_cart.do")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddToCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> errors = new ArrayList<>();
		HttpSession session = request.getSession();
		// 1.取得request的form data,productId=10&color=黑&spec=M&quantity=2
		
		String productId = request.getParameter("productId");
		String cpuName = request.getParameter("cpu");
		String sizeName = request.getParameter("size");
		String quantity = request.getParameter("quantity");
		
		if(productId!=null) {
			ProductService pservice = new ProductService();
			try {
				Product p=pservice.getProductById(productId);
				if(p!=null) {
					Size theSize =null;
					if( p.getSizeCount() >0) {
						theSize = pservice.getTheSize(productId, cpuName, sizeName);
					}
					if(quantity!=null && quantity.matches("\\d+")) {
						ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
						if(cart == null) {
							cart = new ShoppingCart();
							session.setAttribute("cart",cart);
						}
						cart.addToCart(p, cpuName, theSize, Integer.parseInt(quantity));
					}else {
						errors.add("加入cart失敗，購買數量資料不正確:"+quantity);
					}
				}else {
					errors.add("加入cart失敗，查無["+productId+"]產品");
				}
			} catch (VGBException e) {
				this.log("加入cart失敗",e);
			}
		}else {
			errors.add("加入cart失敗，productId不得為null");
		}
		
		this.log("加入cart發生錯誤:"+errors);
		//3.外部轉址到cart.jsp
		response.sendRedirect("member/cart.jsp");
	}

}
