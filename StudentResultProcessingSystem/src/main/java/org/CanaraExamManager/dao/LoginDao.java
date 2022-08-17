package org.CanaraExamManager.dao;

import java.sql.Blob;
import java.sql.Connection;

import org.CanaraExamManager.bean.LoginBean;
import org.CanaraExamManager.bean.StudentStaffDataBean;
import org.CanaraExamManager.util.DBConnection;


import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDao {
	
	public String authenticateUser(LoginBean loginBean) {
		
		//Assign user entered values to temporary variables.
		String userNameString = loginBean.getUserName();
		String passwordString = loginBean.getPassword();
		
		Connection con = null;
		Statement statement = null;
		ResultSet resultset = null;
		
		String userNameDBString = "";
		String passwordDBString = "";
		String statusString = "";
		String semesterString = "";
		String nameString = "";
//		Blob userImage = null;
		
		try {
			//Fetch database connection object
			con = DBConnection.createConnection();
			//Statement is used to write queries.
			statement = con.createStatement();
			
			resultset = statement.executeQuery(""
			+ "select A.reg_no,A.class_id,A.password,A.status,A.semester,A.first_name,A.last_name,A.programme_id,B.programme_id,B.programme_name,C.class_id,C.class_name FROM ((student A "
			+ "INNER JOIN programme B ON A.programme_id = B.programme_id) "
			+ "INNER JOIN class C ON A.class_id = C.class_id) "
			+ "WHERE A.reg_no = "+userNameString+"");
			
			while(resultset.next()) {
				
				userNameDBString = resultset.getString("reg_no");
				passwordDBString = resultset.getString("password");
				statusString = resultset.getString("status");
				semesterString = resultset.getString("semester");
//				userImage = resultset.getBlob("profile_image");
				
				String firstNameeString = resultset.getString("first_name");
				String secondNameString = resultset.getString("last_name");
				String programmeName = resultset.getString("programme_name");
				
				nameString = firstNameeString +" "+ secondNameString;
				
				loginBean.setSemester(semesterString);
				loginBean.setName(nameString);
				loginBean.setProgramme(programmeName);
				
//				loginBean.setUserImage(userImage);
				
				statusString.toLowerCase();
				
				if(userNameString.equals(userNameDBString) && passwordString.equals(passwordDBString) && statusString.equals("true") ) {
					
					return "SUCCESS";//Return SUCCESS if the user credentials match the user credentials in the database
				}else if(statusString.equals("false")) {
					
					return "Permission Denied!";
				}
				
			}
			
			
		}catch (SQLException e) {
			e.printStackTrace();
		}
		
		return "Invalid User Credentials";
	}

	public String authenticateStaff(LoginBean loginBean) {
		
		//Assign user entered values to temporary variables.
		String userNameString = loginBean.getUserName();
		String passwordString = loginBean.getPassword();
		
		Connection con = null;
		Statement statement = null;
		ResultSet resultset = null;
		
		String userNameDBString = "";
		String passwordDBString = "";
		String staffStatusString = "";
		
		try {
			//Fetch database connection object
			con = DBConnection.createConnection();
			//Statement is used to write queries.
			statement = con.createStatement();
			
			resultset = statement.executeQuery("select staff_id,password,staff_status from staff");
			
			while(resultset.next()) {
				
				userNameDBString = resultset.getString("staff_id");
				passwordDBString = resultset.getString("password");
				staffStatusString = resultset.getString("staff_status");
				staffStatusString.toLowerCase();
				
				if(userNameString.equals(userNameDBString) && passwordString.equals(passwordDBString) && staffStatusString.equals("true")) {
					
					return "SUCCESS";//Return SUCCESS if the user credentials match the user credentials in the database
				}else if(staffStatusString.equals("false")) {
					
					return "Permission Denied!";
				}
				
			}
			
			
		}catch (SQLException e) {
			e.printStackTrace();
		}
		
		return "Invalid User Credentials";
	}
	
	public String authenticateAdmin(LoginBean loginBean) {
		
		//Assign user entered values to temporary variables.
		String userNameString = loginBean.getUserName();
		String passwordString = loginBean.getPassword();
		
		
		Connection con = null;
		Statement statement = null;
		ResultSet resultset = null;
		
		String userNameDBString = "";
		String passwordDBString = "";
		
		try {
			//Fetch database connection object
			con = DBConnection.createConnection();
			//Statement is used to write queries.
			statement = con.createStatement();
			
			resultset = statement.executeQuery("select admin_id,first_name,last_name,phone,email,password from admin");
			
			
			while(resultset.next()) {
				
				userNameDBString = resultset.getString("admin_id");
				passwordDBString = resultset.getString("password");
				
				if(userNameString.equals(userNameDBString) && passwordString.equals(passwordDBString) ) {
					
					loginBean.setName(resultset.getString("first_name")+" "+resultset.getString("last_name"));
					loginBean.setPhone(resultset.getString("phone"));
					loginBean.setEmail(resultset.getString("email"));
					loginBean.setPassword(resultset.getString("password"));
					return "SUCCESS";//Return SUCCESS if the user credentials match the user credentials in the database
				}
				
			}
			
			
		}catch (SQLException e) {
			e.printStackTrace();
		}
		
		return "Invalid User Credentials";
	}
}
