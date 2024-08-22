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
import uuu.vgb.exception.VGBDataInvalidException;
import uuu.vgb.exception.VGBException;
import uuu.vgb.service.CustomerService;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/register.do")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterServlet() {
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
		request.setCharacterEncoding("utf-8");
		// TODO: 1.讀取request的form data:
		// id,email,phone,password,name,birthday,gender,captcha
		// address,subscribed
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String birthday = request.getParameter("birthday");
		String gender = request.getParameter("gender");
		String captcha = request.getParameter("captcha");

		String address = request.getParameter("address");
		String subscribed = request.getParameter("subscribed");
		// TODO: 並檢查之
		if (id == null || (id = id.trim()).length() == 0) {
			errors.add("必須輸入id");
		}
		if (email == null || (email = email.trim()).length() == 0) {
			errors.add("必須輸入email");
		}
		if (phone == null || (phone = phone.trim()).length() == 0) {
			errors.add("必須輸入phone");
		}
		if (password == null || password.length() == 0) {
			errors.add("必須輸入密碼");
		}
		if (name == null || name.length() == 0) {
			errors.add("必須輸入姓名");
		}
		if (birthday == null || birthday.length() == 0) {
			errors.add("必須輸入生日");
		}
		if (gender == null || gender.length() != 1) {
			errors.add("必須選擇性別");
		}

		if (captcha == null || (captcha = captcha.trim()).length() == 0) {
			errors.add("必須輸入驗證碼");
		}

		// TODO: 2.若無誤，呼叫商業邏輯
		if (errors.isEmpty()) {
			Customer c = new Customer();
			try {
				c.setId(id);
				c.setEmail(email);
				c.setPhone(phone);
				c.setPassword(password);
				c.setName(name);
				c.setBirthday(birthday);
				c.setGender(gender.charAt(0));
				
				c.setAddress(address);
				c.setSubscribed(subscribed != null);
				
				CustomerService service = new CustomerService();
				service.register(c);
				// 3.1顯示成功html
				response.setContentType("text/html");
				response.setCharacterEncoding("utf-8");
				try (PrintWriter out = response.getWriter();) {
					out.println("<!DOCTYPE html>");
					out.println("<html>");
					out.println("<head>");
					out.println("<title>註冊成功</title>");
					out.println("</head>");
					out.println("<body>");
					out.printf("  <h2>註冊成功，%s您好!</h2>\n",c.getName());
					out.println("</body>");
					out.println("</html>");
				}

				return;
			} catch (VGBDataInvalidException e) {
				errors.add(e.getMessage());
			} catch (VGBException e) {
				this.log(e.getMessage(), e);// for admoin
				errors.add(e.getMessage() + ",請聯絡Admin"); // for users
			} catch (Exception e) { // RuntimeException
				errors.add("系統發生錯誤:" + e.getMessage() + ",請聯絡Admin"); // for users
				this.log("會員登入時，系統發生錯誤", e); // for admin
			}
		}

		// 3.2顯示失敗html
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		try (PrintWriter out = response.getWriter();) {
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head>");
			out.println("<title>註冊失敗</title>");
			out.println("</head>");
			out.println("<body>");
			out.printf("  <h2>%s</h2>\n", errors);
			out.println("</body>");
			out.println("</html>");
		}
	}

}
