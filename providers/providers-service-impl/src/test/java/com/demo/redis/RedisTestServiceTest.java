package com.demo.redis;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.demo.baseTest.SpringTestCase;
import com.demo.service.UserService;

public class RedisTestServiceTest extends SpringTestCase {

	 @Autowired  
	 private UserService userService;  

    @Test  
    public void getTimestampTest() throws InterruptedException{  
        System.out.println("第一次调用：" + userService.selectUserById(10));
        Thread.sleep(2000);
        System.out.println("2秒之后调用：" + userService.selectUserById(10));
        Thread.sleep(11000);
        System.out.println("再过11秒之后调用：" + userService.selectUserById(10));
    } 
}
