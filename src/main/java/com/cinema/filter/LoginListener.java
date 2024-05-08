package com.cinema.filter;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import lombok.Getter;
import lombok.Setter;

/**
 * Application Lifecycle Listener implementation class MySessionListener
 *
 */
@Getter@Setter
@WebListener
public class LoginListener implements HttpSessionListener {

	String user_id;
    String user_pw;
    
    public LoginListener() {
    }
    
   
	public LoginListener(String user_id, String user_pw) {
		this.user_id = user_id;
		this.user_pw = user_pw;
	}

	
}
