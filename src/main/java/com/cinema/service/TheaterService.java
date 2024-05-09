package com.cinema.service;

import java.sql.Date;
import java.util.List;

import com.cinema.dto.MovieDTO;
import com.cinema.dto.TheaterDTO;
import com.cinema.model.TheaterDAO;

public class TheaterService {

	TheaterDAO theaterDao = new TheaterDAO();

	public List<TheaterDTO> showAll(int movieId) {
		return theaterDao.showAll(movieId);
	}

	public List<TheaterDTO> showByDate(int movieId, Date selectDate) {
		return theaterDao.showByDate(movieId, selectDate);
	}

	public int addTheater(TheaterDTO newTheater, int movieId) {
		return theaterDao.addTheater(newTheater, movieId);
	}
	
	
}
