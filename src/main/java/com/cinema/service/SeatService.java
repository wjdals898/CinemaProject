package com.cinema.service;

import java.util.ArrayList;
import java.util.List;

import com.cinema.dto.SeatDTO;
import com.cinema.model.SeatDAO;

public class SeatService {

	SeatDAO seatDao = new SeatDAO();
	
	public List<SeatDTO> showAll(int theaterId) {
		return seatDao.showAll(theaterId);
	}

	public List<SeatDTO> showSeatsInfo(String[] seatNumList, int theaterId) {
		return seatDao.showBySeatNum(seatNumList, theaterId);
	}

}
