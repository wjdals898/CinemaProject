package com.cinema.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.dto.UserDTO;
import com.cinema.service.UserService;

@WebServlet("/auth/usercheck")
public class UserCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(request.getParameter("username"));
		String username = request.getParameter("username");
		
		UserService service = new UserService();
		UserDTO user = service.selectByUsername(username);
		String message = "1";
		if(user == null) {
			message = "0";
		} 
		
		response.setCharacterEncoding("utf-8");
		response.getWriter().append(message);
	}

}
