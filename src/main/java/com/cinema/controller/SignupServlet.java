package com.cinema.controller;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.dto.UserDTO;
import com.cinema.service.UserService;

@WebServlet("/auth/signup")
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("signup.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		UserDTO user = makeUser(request);
		System.out.println("1 : "+user);
		UserService service = new UserService();
		int result = service.signup(user);
		
		request.setAttribute("result", result);
		request.getRequestDispatcher("signupComplete.jsp").forward(request, response);
	}

	private UserDTO makeUser(HttpServletRequest request) {
		UserDTO user = new UserDTO();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String nickname = request.getParameter("nickname");
		String phone = request.getParameter("phone");
		int gender = Integer.parseInt(request.getParameter("selectedGender"));
		
		user.setUsername(username);
		user.setPassword(password);
		user.setNickname(nickname);
		user.setPhone(phone);
		user.setGender(gender);
		
		return user;
	}

}
