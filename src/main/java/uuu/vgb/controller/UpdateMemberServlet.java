package uuu.vgb.controller;

import java.io.IOException;
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
import uuu.vgb.exception.VGBDataInvalidException;
import uuu.vgb.exception.VGBException;
import uuu.vgb.service.CustomerService;

/**
 * Servlet implementation class UpdateMemberServlet
 */
@WebServlet("/member/update.do") //http://localhost:8080/vgb/member/update.do
public class UpdateMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateMemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> errors = new ArrayList<>();
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		// 1.讀取request的form data:
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
		} else {
			String captchaString = (String) session.getAttribute("captchaString");
			if (!captcha.equalsIgnoreCase(captchaString)) {
				errors.add("驗證碼不正確");
			}
		}
		session.removeAttribute("captchaString");

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
				service.update(c);
				// 3.1 內部轉交(forward)成功 register_ok.jsp
				request.setAttribute("member", c);
				RequestDispatcher dispatcher = request.getRequestDispatcher("update_ok.jsp");
				dispatcher.forward(request, response);
				return;
			} catch (VGBDataInvalidException e) {
				errors.add(e.getMessage());
			} catch (VGBException e) {
				this.log(e.getMessage(), e);// for admoin
				errors.add(e.getMessage() + ",請聯絡Admin"); // for users
			} catch (Exception e) { // RuntimeException
				errors.add("系統發生錯誤:" + e.getMessage() + ",請聯絡Admin"); // for users
				this.log("會員修改，系統發生錯誤", e); // for admin
			}
		}

		// 3.2內部轉交(forward)失敗的register_ok.jsp
		request.setAttribute("errors", errors);
		RequestDispatcher dispatcher = request.getRequestDispatcher("update.jsp");
		dispatcher.forward(request, response);
		return;
	}

}
