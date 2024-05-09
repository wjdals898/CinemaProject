package com.cinema.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cinema.dto.MovieDTO;
import com.cinema.dto.TheaterDTO;
import com.cinema.service.MovieService;
import com.cinema.service.TheaterService;

/**
 * Servlet implementation class SelectTheaterServlet
 */
@WebServlet("/reservation/theater")
public class SelectTheaterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int movieId = Integer.parseInt(request.getParameter("movieId"));
		TheaterService service = new TheaterService();
		MovieService mService = new MovieService();
		MovieDTO movie = mService.selectById(movieId);
		List<TheaterDTO> theaterlist = service.showAll(movieId);
		request.setAttribute("theaterlist", theaterlist);
		request.setAttribute("selectMovie", movie);
		request.getRequestDispatcher("selectTheater.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
