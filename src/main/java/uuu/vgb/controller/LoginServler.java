package uuu.vgb.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.vgb.entity.Customer;
import uuu.vgb.exception.LoginFailedException;
import uuu.vgb.exception.VGBException;
import uuu.vgb.service.CustomerService;

/**
 * Servlet implementation class LoginServler
 */
@WebServlet(urlPatterns="/login.do",loadOnStartup=1) // http://localhost:8080/vgb/login.do
public class LoginServler extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServler() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<String> errors = new ArrayList<>();
		// 1.讀取request中的form data :id,password,captcha
		HttpSession session =request.getSession();
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String captcha = request.getParameter("captcha");

		// 檢查必要欄位是否輸入
		if (id == null || (id = id.trim()).length() == 0) {
			errors.add("必須輸入id/email/手機...");
		}
		if (password == null || password.length() == 0) {
			errors.add("必須輸入password");
		}
		if (captcha == null || (captcha = captcha.trim()).length() == 0) {
			errors.add("必須輸入驗證碼");
		}else {
			String captchaString = (String)session.getAttribute("captchaString");
			if(!captcha.equalsIgnoreCase(captchaString)) {
				errors.add("驗證碼不正確");
			}
		}
		session.removeAttribute("captchaString");

		// 2.檢查無誤，呼叫商業邏輯: CustomerService.login
		if (errors.isEmpty()) {
			CustomerService service = new CustomerService();
			Customer c;
			try {
				c = service.login(id, password);

				// 3.1 內部轉交(forward)成功 login_ok.jsp
				session.setAttribute("member", c);
				RequestDispatcher dispatcher = request.getRequestDispatcher("login_ok.jsp");
				dispatcher.forward(request, response);
				return;

			} catch (LoginFailedException e) {
				errors.add(e.getMessage());
			} catch (VGBException e) {
				this.log(e.getMessage(), e);// for admoin
				errors.add(e.getMessage() + ",請聯絡Admin"); // for users
			} catch (Exception e) { // RuntimeException
				this.log("會員登入時，系統發生錯誤", e); // for admin
			}
		}

		// 3.2內部轉交(forward)失敗的login.jsp
		request.setAttribute("errors", errors);
		RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
		dispatcher.forward(request, response);
		return;

	}

}
