package com.cinema.model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import com.cinema.dto.ReservationDTO;
import com.cinema.dto.SeatDTO;
import com.cinema.util.DBUtil;
import com.cinema.util.DateUtil;


public class ReservationDAO {

	Connection conn;
	CallableStatement cstmt;
	PreparedStatement pst;
	ResultSet rs;
	
	public ReservationDTO showById(int reservationId) {
		conn = DBUtil.dbConnection();
		String sql = "select reservations.id, "
				+ "reservations.reservation_date reservation_date, "
				+ "movies.title, movies.running_time, "
				+ "theaters.screening_datetime screening_datetime, seats.seat_num "
				+ "from (reservations join theaters on(reservations.theater_id = theaters.id)), "
				+ "movies, seats join seats_reservations on(seats.id = seats_reservations.seat_id) "
				+ "where reservations.id = ?" 
				+ "    and theaters.movie_id = movies.id "
				+ "    and reservations.id = seats_reservations.reservation_id "
				+ "order by 1, seats.seat_num";
		ReservationDTO reservation = null;
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, reservationId);
			rs = pst.executeQuery();
			List<String> seatList = new ArrayList<String>();
			int index = 0;
			while (rs.next()) {
				if (index == 0) {
					reservation = makeReservation(rs);
				}
				seatList.add(rs.getString("seat_num"));
				index++;
			}
			reservation.setSeats(seatList.toString());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBUtil.dbDisconnect(conn, pst, rs);
		}
		
		return reservation;
	}

	public int createReservation(int theaterId, List<SeatDTO> seatInfo, int user_id) {
		conn = DBUtil.dbConnection();
		String insertSql = "{call sp_create_reservation(?,?,?)}";
		String procedureSql = "{call sp_seat_reservation(?,?)}";
		List<Integer> resultList = new ArrayList<Integer>();
		int reservation_id = -1;

		try {
			conn.setAutoCommit(false);
			cstmt = conn.prepareCall(insertSql);
			cstmt.setInt(1, user_id);
			cstmt.setInt(2, theaterId);
			cstmt.registerOutParameter(3, Types.INTEGER);
			int result = cstmt.executeUpdate();
			reservation_id = cstmt.getInt(3);

			if (result == 1) { // insert 성공
				for (SeatDTO seat : seatInfo) {
					cstmt = conn.prepareCall(procedureSql);
					cstmt.setInt(1, reservation_id);
					cstmt.setInt(2, seat.getId());
					resultList.add(cstmt.executeUpdate());
				}
				if (resultList.size() == seatInfo.size()) { // 좌석이 모두 예매가능한 경우
					conn.commit();
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.dbDisconnect(conn, cstmt, rs);
		}
		return reservation_id;
	}

	public List<ReservationDTO> showAll(int user_id) {
		List<ReservationDTO> reservationList = new ArrayList<ReservationDTO>();
		conn = DBUtil.dbConnection();
		String sql = "select reservations.id, "
				+ "reservations.reservation_date reservation_date, "
				+ "movies.title, movies.running_time, "
				+ "to_char(theaters.screening_datetime, 'yyyy-mm-dd hh24:mi:ss') screening_datetime, seats.seat_num "
				+ "from (reservations join theaters on(reservations.theater_id = theaters.id)), "
				+ "movies, seats join seats_reservations on(seats.id = seats_reservations.seat_id) "
				+ "where reservations.user_id = ?" 
				+ "    and theaters.movie_id = movies.id "
				+ "    and reservations.id = seats_reservations.reservation_id "
				+ "order by 1, seats.seat_num";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, user_id);
			rs = pst.executeQuery();
			int id = -1;
			List<String> seatList = new ArrayList<String>();
			while (rs.next()) {
				if (id != rs.getInt("id")) {
					seatList.clear();
					reservationList.add(makeReservation(rs));
				}
				seatList.add(rs.getString("seat_num"));
				reservationList.get(reservationList.size()-1).setSeats(seatList.toString());
				id = rs.getInt("id");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.dbDisconnect(conn, cstmt, rs);
		}

		return reservationList;
	}

	public int cancelReservation(ReservationDTO cancelReservation) {
		int result = 0;
		conn = DBUtil.dbConnection();
		String deleteSql = "{call sp_delete_reservation(?)}";
		try {
			conn.setAutoCommit(false);
			cstmt = conn.prepareCall(deleteSql);
			cstmt.setInt(1, cancelReservation.getId());
			result = cstmt.executeUpdate();
			if(result == 1) {
				conn.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.dbDisconnect(conn, cstmt, rs);
		}
		return result;
	}

	private ReservationDTO makeReservation(ResultSet rs) throws SQLException {
		ReservationDTO reservation = new ReservationDTO();
		reservation.setId(rs.getInt("id"));
		reservation.setMovieTitle(rs.getString("title"));
		String runningTime = rs.getString("running_time");
		reservation.setRunningTime(runningTime);
		reservation.setReservationDate(rs.getString("reservation_date"));
		reservation.setScreeningDate(rs.getDate("screening_datetime"));
		reservation.setStartTime(rs.getTime("screening_datetime").toString().substring(0, 5));
		reservation.setEndTime(calcEndTime(rs.getTime("screening_datetime"), runningTime));
		reservation.setSeats("");

		return reservation;
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
}
