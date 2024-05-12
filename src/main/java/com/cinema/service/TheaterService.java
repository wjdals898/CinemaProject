package com.cinema.service;

import java.sql.Date;
import java.util.List;

import com.cinema.dto.MovieDTO;
import com.cinema.dto.TheaterDTO;
import com.cinema.model.TheaterDAO;

public class TheaterService {

	TheaterDAO theaterDao = new TheaterDAO();

	public List<TheaterDTO> showAll(int movieId, String runningTime) {
		return theaterDao.showAll(movieId, runningTime);
	}

	public List<TheaterDTO> showByDate(int movieId, String runningTime, Date selectDate) {
		return theaterDao.showByDate(movieId, runningTime, selectDate);
	}
	
	public TheaterDTO showById(int theaterId, String runningTime) {
		return theaterDao.showById(theaterId, runningTime);
	}

	public int addTheater(TheaterDTO newTheater, int movieId) {
		return theaterDao.addTheater(newTheater, movieId);
	}
}
