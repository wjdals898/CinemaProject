package com.cinema.dto;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter@Setter
public class TheaterDTO {
	private int id;
	private Date screeningDate;
	private String startTime;
	private String endTime;
	private int remainingSeatsCount;
}
