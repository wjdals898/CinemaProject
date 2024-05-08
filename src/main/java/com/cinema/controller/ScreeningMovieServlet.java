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
 * Servlet implementation class ScreeningMovieServlet
 */
@WebServlet("/movie/screening")
public class ScreeningMovieServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MovieService service = new MovieService();
		List<MovieDTO> movielist = service.showByScreening();
		System.out.println(movielist.size());
		request.setAttribute("movielist", movielist);
		request.getRequestDispatcher("screeningMovie.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
