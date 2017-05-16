package com.demo.web.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.demo.domain.User;
import com.demo.service.UserService;

@Controller
@RequestMapping("/user")
public class UserServiceController {
	
	 	@Autowired  
	    private UserService userService;  
	    Logger logger = Logger.getLogger(UserServiceController.class);  
	      
	    @RequestMapping(value = { "select", "" }, method = {RequestMethod.GET,RequestMethod.POST})  
	    public String selectUserById() throws InterruptedException{ 
	        User user = userService.selectUserById(10);
	        System.out.println("第一次调用：" + userService.selectUserById(10));
	    	Thread.sleep(2000);
	    	System.out.println("2秒之后调用：" + userService.selectUserById(10));
	    	Thread.sleep(11000);
	    	System.out.println("再过11秒之后调用：" + userService.selectUserById(10));
//	        logger.debug("查找结果" + user);
	        return "index";
	    }
}
