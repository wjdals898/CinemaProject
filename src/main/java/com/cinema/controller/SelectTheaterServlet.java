package com.cinema.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
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
import com.cinema.util.DateUtil;

/**
 * Servlet implementation class SelectTheaterServlet
 */
@WebServlet("/reservation/theater")
public class SelectTheaterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static TheaterService service = new TheaterService();
	private static MovieService mService = new MovieService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int movieId = Integer.parseInt(request.getParameter("movieId"));
		
		MovieDTO movie = mService.selectById(movieId);
		Date today = DateUtil.getSQLDate2(new java.util.Date());
		//List<TheaterDTO> theaterlist = service.showByDate(movieId, movie.getRunningTime(), today);
		List<TheaterDTO> theaterlist = service.showAll(movieId, movie.getRunningTime());
		System.out.println(theaterlist.size());
		request.setAttribute("theaterlist", theaterlist);
		
		List<Integer> datelist = new ArrayList<Integer>(); 
		List<String> dayofweeklist = new ArrayList<String>();
		String[] strlist = {"일", "월", "화", "수", "목", "금", "토"};
		Calendar cal = Calendar.getInstance();
		for(int i=0; i<7; i++) {
			int currentDay = cal.get(cal.DATE)+i;
			int currentDayofWeek = (cal.get(cal.DAY_OF_WEEK)+i-1)%7;
			datelist.add(currentDay);
			
			if(i==0) {
				dayofweeklist.add("오늘");
			} else if(i==1) {
				dayofweeklist.add("내일");
			} else {
				dayofweeklist.add(strlist[currentDayofWeek]);
			}
		}
		request.setAttribute("datelist", datelist);
		request.setAttribute("dayofweeklist", dayofweeklist);
		
		request.setAttribute("selectMovie", movie);
		request.getRequestDispatcher("selectTheater.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int selectIndex = Integer.parseInt(request.getParameter("selectDateIdx"));
		int movieId = Integer.parseInt(request.getParameter("movieId"));
		MovieDTO movie = mService.selectById(movieId);
		java.util.Date today = new java.util.Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(today);
		cal.add(cal.DATE, selectIndex);
		Date selectDate = DateUtil.getSQLDate2(cal.getTime());
		List<TheaterDTO> theaterlist = service.showByDate(movieId, movie.getRunningTime(), selectDate);
		System.out.println(theaterlist);
		request.setAttribute("theaterlist", theaterlist);
		
	}

}
