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
 * Servlet implementation class SearchMovieServlet
 */
@WebServlet("/movie/search")
public class SearchMovieServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MovieService service = new MovieService();
		String searchWord = request.getParameter("searchWord");
		List<MovieDTO> movielist = service.searchByTitle(searchWord);
		System.out.println(movielist.size());
		request.setAttribute("searchlist", movielist);
		request.setAttribute("searchWord", searchWord);
		request.getRequestDispatcher("searchMovie.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
