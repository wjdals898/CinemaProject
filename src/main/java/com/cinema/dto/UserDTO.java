package com.cinema.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter@Setter
@NoArgsConstructor
public class UserDTO {
	private int id;
	private String username;
	private String password;
	private String nickname;
	private String phone;
	private int gender;
	private boolean isManager;
	
	public UserDTO(String nickname) {
		this.nickname = nickname;
	}
}
