package com.cinema.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter@Setter
public class MovieDTO {
	private int id;
	private String title;
	private String director;
	private String content;
	private String runningTime;
	private int theaters_count;
	private String poster;
}
