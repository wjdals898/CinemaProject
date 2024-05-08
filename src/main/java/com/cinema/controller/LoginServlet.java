package com.cinema.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cinema.dto.UserDTO;
import com.cinema.filter.LoginListener;
import com.cinema.service.UserService;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/auth/login.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 사용자가 입력한 ID, pass검사
		UserService service = new UserService();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		UserDTO user = service.login(username, password);
		if(user == null || user.getId() == -1) {
			// 존재하지 않는 아이디
			request.setAttribute("message", "존재하지 않는 아이디");
		}else if(user.getId() == -2) {
			// 비밀번호 오류
			request.setAttribute("message", "비밀번호 오류");
		} else {
			// 로그인 성공
			HttpSession session = request.getSession();
			ServletContext app = getServletContext();
			
			session.setAttribute("loginUser", user);
			
			String lastAddress = (String)session.getAttribute("lastRequest");
			if(lastAddress == null || lastAddress.length() == 0) {
				lastAddress = getServletContext().getContextPath();
			}
			response.sendRedirect(lastAddress);
			return;
		}
		RequestDispatcher rd;
		rd = request.getRequestDispatcher("login.jsp");
		rd.forward(request, response);
	}

}
