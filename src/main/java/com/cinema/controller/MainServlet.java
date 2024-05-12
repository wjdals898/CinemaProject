package com.cinema.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.dto.MovieDTO;
import com.cinema.service.MovieService;

/**
 * Servlet implementation class MainServlet
 */
@WebServlet("")
public class MainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MovieService service = new MovieService();
		List<MovieDTO> movielist = service.showAll().subList(0, 6);
		List<MovieDTO> screeninglist = service.showByScreening();
		if(screeninglist.size()>6) {
			screeninglist = screeninglist.subList(0, 6);
		}
		System.out.println(movielist.size());
		request.setAttribute("movielist", movielist);
		request.setAttribute("screeninglist", screeninglist);
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
