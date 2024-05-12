package com.cinema.service;

import java.util.List;

import com.cinema.dto.ReservationDTO;
import com.cinema.dto.SeatDTO;
import com.cinema.model.ReservationDAO;


public class ReservationService {

	ReservationDAO reservationDao = new ReservationDAO();
	
	public int createReservation(int theaterId, List<SeatDTO> seatInfo, int user_id) {
		return reservationDao.createReservation(theaterId, seatInfo, user_id);
	}

	public List<ReservationDTO> showAll(int user_id) {
		return reservationDao.showAll(user_id);
	}
	
	public ReservationDTO showById(int reservationId) {
		return reservationDao.showById(reservationId);
	}

	public int cancelReservation(ReservationDTO cancelReservation) {
		return reservationDao.cancelReservation(cancelReservation);
	}

}
