package com.cinema.dto;

import java.sql.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter@Setter
public class ReservationDTO {
	private int id;
	private String movieTitle;
	private String runningTime;
	private Date screeningDate;
	private String startTime;
	private String endTime;
	private String seats;
	private String reservationDate;
	
}
