package com.cinema.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.cinema.dto.UserDTO;
import com.cinema.util.DBUtil;

public class UserDAO {
	
	Connection conn;
	PreparedStatement pst;
	ResultSet rs;
	
	public UserDTO selectByUsername(String username) {
		conn = DBUtil.dbConnection();
		String sql = "select * from users where username=?";
		UserDTO user = null;
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, username);
			rs = pst.executeQuery();
			if (rs.next()) {
				user = makeUser(rs);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBUtil.dbDisconnect(conn, pst, rs);
		}
		
		return user;
	}

	public UserDTO login(String username, String password) {
		conn = DBUtil.dbConnection();
		String sql = "select * from users where username=?";
		UserDTO user = null;
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, username);
			rs = pst.executeQuery();
			if(rs.next()) {
				if(rs.getString("password").equals(password)) {
					user = makeUser(rs);
				} else {
					user = new UserDTO();
					user.setId(-2);	// 비밀번호 오류
				}
			} else {
				user = new UserDTO();
				user.setId(-1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.dbDisconnect(conn, pst, rs);
		}
		
		return user;
	}

	private UserDTO makeUser(ResultSet rs) throws SQLException {
		UserDTO user = new UserDTO();
		user.setId(rs.getInt("id"));
		user.setUsername(rs.getString("username"));
		user.setNickname(rs.getString("nickname"));
		user.setManager(rs.getInt("is_manager")==1?true:false);
		
		return user;
	}

	public int signup(UserDTO user) {
		conn = DBUtil.dbConnection();
		String sql = "insert into users(id, username, password, nickname, phone, gender, is_manager)"
				+ " values(users_seq.nextval, ?, ?, ?, ?, ?, 0)";
		int result = 0;
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, user.getUsername());
			pst.setString(2, user.getPassword());
			pst.setString(3, user.getNickname());
			pst.setString(4, user.getPhone());
			pst.setInt(5, user.getGender());
			result = pst.executeUpdate();
			System.out.println(result);
		} catch (SQLException e) {
			
		} finally {
			DBUtil.dbDisconnect(conn, pst, rs);
		}
		
		return result;
	}

}






