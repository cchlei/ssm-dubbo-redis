package com.demo.service;

import com.demo.domain.User;

/** 
 * 功能概要：UserService接口类 
 *  
 * @author chlei 
 * @since  2017年5月05日  
 */  
public interface UserService {
	
    User selectUserById(Integer userId);  
  
}  
