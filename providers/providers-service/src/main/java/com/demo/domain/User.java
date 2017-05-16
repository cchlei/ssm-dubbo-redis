package com.demo.domain;

import java.io.Serializable;

/** 
 * User映射类 
 *  
 * @author chlei
 * @time 2017.5.5 
 */  
public class User implements Serializable{  
	
	private static final long serialVersionUID = -669848699227427952L;
	private Integer userId;  
    private String userName;  
    private String userPassword;  
    private String userEmail;  
  
    public Integer getUserId() {  
        return userId;  
    }  
  
    public void setUserId(Integer userId) {  
        this.userId = userId;  
    }  
  
    public String getUserName() {  
        return userName;  
    }  
  
    public void setUserName(String userName) {  
        this.userName = userName;  
    }  
  
    public String getUserPassword() {  
        return userPassword;  
    }  
  
    public void setUserPassword(String userPassword) {  
        this.userPassword = userPassword;  
    }  
  
    public String getUserEmail() {  
        return userEmail;  
    }  
  
    public void setUserEmail(String userEmail) {  
        this.userEmail = userEmail;  
    }  
  
    @Override  
    public String toString() {  
        return "User [userId=" + userId + ", userName=" + userName  
                + ", userPassword=" + userPassword + ", userEmail=" + userEmail  
                + "]";  
    }  
      
}  
