package com.cinema.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.cinema.dto.MovieDTO;
import com.cinema.dto.TheaterDTO;
import com.cinema.util.DBUtil;
import com.cinema.util.DateUtil;


public class TheaterDAO {
	
	Connection conn;
	PreparedStatement pst;
	ResultSet rs;

	public List<TheaterDTO> showAll(int movieId, String runningTime) {
		List<TheaterDTO> theaterList = new ArrayList<TheaterDTO>();
		conn = DBUtil.dbConnection();
		
		String sql = "select * from theaters where movie_id = ? "
				+ "and to_char(screening_datetime, 'yyyy-mm-dd HH24:MI') >= to_char(sysdate, 'yyyy-mm-dd HH24:MI')";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, movieId);
			rs = pst.executeQuery();
			while(rs.next()) {
				theaterList.add(makeTheater(rs, runningTime));
			}
		} catch (SQLException e) {
		} finally {
			DBUtil.dbDisconnect(conn, pst, rs);
		}
		
		
		return theaterList;
	}

	public List<TheaterDTO> showByDate(int movieId, String runningTime, Date selectDate) {
		List<TheaterDTO> theaterList = new ArrayList<TheaterDTO>();
		conn = DBUtil.dbConnection();
		String sql = "select * from theaters "
				+ "where movie_id = ? and to_char(screening_datetime, 'yyyy-mm-dd') = to_char(?,'yyyy-mm-dd')";
		
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, movieId);
			pst.setDate(2, selectDate);
			rs = pst.executeQuery();
			while(rs.next()) {
				theaterList.add(makeTheater(rs, runningTime));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.dbDisconnect(conn, pst, rs);
		}
		
		return theaterList;
	}
	
	public TheaterDTO showById(int theaterId, String runningTime) {
		TheaterDTO theater = null;
		conn = DBUtil.dbConnection();
		String sql = "select * from theaters "
				+ "where id = ?";
		
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, theaterId);
			rs = pst.executeQuery();
			while(rs.next()) {
				theater = makeTheater(rs, runningTime);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.dbDisconnect(conn, pst, rs);
		}
		
		return theater;
	}

	private TheaterDTO makeTheater(ResultSet rs, String runningTime) throws SQLException {
		TheaterDTO theater = new TheaterDTO();
		theater.setId(rs.getInt("id"));
		theater.setScreeningDate(rs.getDate("screening_datetime"));
		theater.setStartTime(rs.getTime("screening_datetime").toString().substring(0, 5));
		theater.setEndTime(calcEndTime(rs.getTime("screening_datetime"), runningTime));
		theater.setRemainingSeatsCount(rs.getInt("remaining_seats_count"));
		
		return theater;
	}

	private String calcEndTime(Time startTime, String runningTime) {
		String regExp = "([0-9]+)시간([0-9]+)분";
		Pattern pattern = Pattern.compile(regExp);
		Matcher matcher = pattern.matcher(runningTime);
		int hour = 0;
		int minute = 0;
		if(matcher.find()) {
			hour = Integer.parseInt(matcher.group(1));
			minute = Integer.parseInt(matcher.group(2)); 
			
		}
		Calendar cal = Calendar.getInstance();
		cal.setTime(startTime);
		cal.add(cal.HOUR_OF_DAY, hour);
		cal.add(cal.MINUTE, minute);
		System.out.println(cal.getTime().toString());
		String endTime = DateUtil.getSQLTime(cal.getTime());
		System.out.println("endTime = "+endTime);
		return endTime;
	}

	public int addTheater(TheaterDTO newTheater, int movieId) {
		int result = 0;
		conn = DBUtil.dbConnection();
		String sql = "insert into theaters values(theaters_seq.nextval, ?, ?, ?)";
		try {
			Date datetime = DateUtil.getSQLDateTime(newTheater.getScreeningDate()+" "+newTheater.getStartTime());
			pst = conn.prepareStatement(sql);
			pst.setInt(1,movieId);
			pst.setDate(2, datetime);
			pst.setInt(3, newTheater.getRemainingSeatsCount());
			result = pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.dbDisconnect(conn, pst, rs);
		}
		return result;
	}

}
