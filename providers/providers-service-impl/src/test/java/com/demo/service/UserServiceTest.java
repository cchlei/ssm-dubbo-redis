package com.demo.service;

import org.apache.log4j.Logger;  
import org.junit.Test;  
import org.springframework.beans.factory.annotation.Autowired;  
  
import com.demo.baseTest.SpringTestCase;  
import com.demo.domain.User;  
  
/** 
 * 功能概要：UserService单元测试 
 *  
 * @author chlei
 * @since  2017年05月05日  
 */  
public class UserServiceTest {  //extends SpringTestCase s
    @Autowired  
    private UserService userService;  
    Logger logger = Logger.getLogger(UserServiceTest.class);  
      
    @Test  
    public void selectUserByIdTest(){  
        User user = userService.selectUserById(10);  
        logger.debug("查找结果" + user);  
    }
    
    @Test  
    public void getTimestampTest() throws InterruptedException{  
    	System.out.println("第一次调用：" + userService.selectUserById(10));
    	Thread.sleep(2000);
    	System.out.println("2秒之后调用：" + userService.selectUserById(10));
    	Thread.sleep(11000);
    	System.out.println("再过11秒之后调用：" + userService.selectUserById(10));
    }	 
      
  
}  
