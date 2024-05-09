package com.cinema.service;

import java.util.List;

import com.cinema.dto.MovieDTO;
import com.cinema.model.MovieDAO;


public class MovieService {

	MovieDAO movieDao = new MovieDAO();
	
	public List<MovieDTO> showAll() {
		return movieDao.showAll();
	}

	public List<MovieDTO> showByScreening() {
		return movieDao.showByScreening();
	}

	public List<MovieDTO> searchByTitle(String title) {
		return movieDao.searchByTitle(title);
	}
	
	public MovieDTO selectById(int id) {
		return movieDao.selectById(id);
	}

	public int addMovie(MovieDTO newMovie) {
		return movieDao.addMovie(newMovie);
	}

}
