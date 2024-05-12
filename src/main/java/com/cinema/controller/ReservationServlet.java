package com.cinema.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cinema.dto.ReservationDTO;
import com.cinema.dto.SeatDTO;
import com.cinema.dto.UserDTO;
import com.cinema.service.ReservationService;
import com.cinema.service.SeatService;

/**
 * Servlet implementation class ReservationServlet
 */
@WebServlet("/reservation/complete.do")
public class ReservationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int reservationId = Integer.parseInt(request.getParameter("reservationId"));
		System.out.println("예약번호 = "+reservationId);
		
		ReservationService rService = new ReservationService();
		ReservationDTO reservation = rService.showById(reservationId);
		
		request.setAttribute("reservation", reservation);
		request.getRequestDispatcher("completeReservation.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
