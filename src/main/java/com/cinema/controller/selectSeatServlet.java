package com.cinema.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cinema.dto.MovieDTO;
import com.cinema.dto.SeatDTO;
import com.cinema.dto.TheaterDTO;
import com.cinema.dto.UserDTO;
import com.cinema.model.TheaterDAO;
import com.cinema.service.MovieService;
import com.cinema.service.ReservationService;
import com.cinema.service.SeatService;
import com.cinema.service.TheaterService;

/**
 * Servlet implementation class selectSeatServlet
 */
@WebServlet("/reservation/seat")
public class selectSeatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int theaterId = Integer.parseInt(request.getParameter("theaterId"));
		int movieId = Integer.parseInt(request.getParameter("movieId"));
		System.out.println("theaterId = "+theaterId);
		System.out.println("movieId = "+movieId);
		SeatService sService = new SeatService();
		TheaterService tService = new TheaterService();
		MovieService mService = new MovieService();
		MovieDTO movie = mService.selectById(movieId);
		TheaterDTO theater = tService.showById(theaterId, movie.getRunningTime());
		List<SeatDTO> seatlist = sService.showAll(theaterId);
		request.setAttribute("seatlist", seatlist);
		request.setAttribute("movie", movie);
		request.setAttribute("theater", theater);
				
		request.getRequestDispatcher("selectSeat.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("----------------------------------------------");
		HttpSession session = request.getSession();
		UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
		//int movieId = Integer.parseInt(request.getParameter("movieId"));
		int theaterId = Integer.parseInt(request.getParameter("theaterId"));
		String[] seatList = request.getParameterValues("seatlist[]");
		
		SeatService sService = new SeatService();
		List<SeatDTO> seatInfoList = sService.showSeatsInfo(seatList, theaterId);
		
		ReservationService service = new ReservationService();
		int reservationId = service.createReservation(theaterId, seatInfoList, loginUser.getId());
		
		/*
		 * String sendResult = null; for(int result: resultlist) { if(result == 0) {
		 * sendResult = "0"; break; } }
		 */
		response.getWriter().append(reservationId+"");
	}

}
