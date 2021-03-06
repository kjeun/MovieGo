package com.mvg.entity;

import java.util.Date;

public class User {
	private String userId;
	private String userPwd;
	private String userEmail;
	private Date userBirthday;
	private String userCoupon;
	private int userPoint;

	public User() {
	}

	public User(String userId, String userPwd, String userEmail) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.userEmail = userEmail;
		this.userCoupon = "n";
		this.userPoint = 0;
	}

	public User(String userId, String userPwd, String userEmail,
			Date userBirthday) {
		this(userId, userPwd, userEmail);
		this.userBirthday = userBirthday;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public Date getUserBirthday() {
		return userBirthday;
	}

	public void setUserBirthday(Date userBirthday) {
		this.userBirthday = userBirthday;
	}

	public String getUserCoupon() {
		return userCoupon;
	}

	public void setUserCoupon(String userCoupon) {
		this.userCoupon = userCoupon;
	}

	public int getUserPoint() {
		return userPoint;
	}

	public void setUserPoint(int userPoint) {
		this.userPoint = userPoint;
	}

	@Override
	public String toString() {
		return "User [userId=" + userId + ", userPwd=" + userPwd
				+ ", userEmail=" + userEmail + ", userBirthday=" + userBirthday
				+ ", userCoupon=" + userCoupon + ", userPoint=" + userPoint
				+ "]";
	}

}
