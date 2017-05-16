package com.demo.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.dao.UserDao;
import com.demo.domain.User;
import com.demo.service.UserService;

/** 
 * 功能概要：UserService实现类 
 *  
 * @author cheli 
 * @since  2017年05月09日  
 */  
@Service  
public class UserServiceImpl implements UserService{  
    @Autowired  
    private UserDao userDao;  
  
    public User selectUserById(Integer userId) {
    	Long timestamp =System.currentTimeMillis();
    	System.out.println("timestamp :"+timestamp.toString());
        return userDao.selectUserById(userId);  
          
    }  
  
}  
