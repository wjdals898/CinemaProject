package com.cinema.util;

import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.SimpleTimeZone;

public class DateUtil {

	public static Date getUtilDate(String d) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date result = null;
		try {
			result = sdf.parse(d);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static java.sql.Date getSQLDateTime(String d) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd kk:mm");
		
		java.sql.Date result = null;
		try {
			Date d2 = sdf.parse(d);
			result = new java.sql.Date(d2.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static String getSQLTime(Date d) {
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		String result = sdf.format(d);

		return result;
	}
	
	public static java.sql.Date getSQLDate(String d) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		java.sql.Date result = null;
		try {
			Date d2 = sdf.parse(d);
			result = new java.sql.Date(d2.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static java.sql.Date getSQLDate2(Date d) {
		System.out.println(d);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		String d2 = sdf.format(d);
		java.sql.Date result = getSQLDate(d2);
		return result;
	}
}
