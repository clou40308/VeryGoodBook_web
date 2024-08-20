package uuu.vgb.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import uuu.vgb.entity.Customer;
import uuu.vgb.exception.LoginFailedException;
import uuu.vgb.exception.VGBException;
import uuu.vgb.service.CustomerService;

/**
 * Servlet implementation class LoginServler
 */
@WebServlet("/login.do") // http://localhost:8080/vgb/login.do
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
		}

		// 2.呼叫商業邏輯: CustomerService.login
		if (errors.isEmpty()) {
			CustomerService service = new CustomerService();
			Customer c;
			try {
				c = service.login(id, password);

				// 3.1顯示成功html
				response.setContentType("text/html");
				response.setCharacterEncoding("utf-8");
				try (PrintWriter out = response.getWriter();) {
					out.println("<!DOCTYPE html>");
					out.println("<html>");
					out.println("<head>");
					out.println("<title>登入成功</title>");
					out.println("</head>");
					out.println("<body>");
					out.println("  <h2>" + c.getName() + "，你好</h2>");
					out.println("</body>");
					out.println("</html>");
				}
				return;
			}catch(LoginFailedException e){
				errors.add(e.getMessage());
			} catch (VGBException e) {
				this.log(e.getMessage(), e);
				errors.add(e.getMessage());
			}
		}

		// 3.2顯示失敗html
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		try (PrintWriter out = response.getWriter();) {
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head>");
			out.println("<title>登入失敗</title>");
			out.println("</head>");
			out.println("<body>");
			out.println("  <h2>+" + errors + " </h2>");
			out.println("</body>");
			out.println("</html>");
		}

	}

}
