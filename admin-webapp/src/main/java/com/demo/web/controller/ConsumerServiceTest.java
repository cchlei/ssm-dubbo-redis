package com.demo.web.controller;

import java.io.IOException;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.demo.service.UserService;

public class ConsumerServiceTest {

    public static void main(String[] args) {
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(
                new String[] { "conf/spring-dubbo-server.xml" });
        context.start();
       UserService testService = (UserService) context.getBean("userService");
        System.out.println(testService.selectUserById(10)+"+++");
        try {
            System.in.read();
        } catch (IOException e) {       
            e.printStackTrace();
        }  

    }

}
