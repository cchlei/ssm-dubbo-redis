package com.demo.dao;

import com.demo.domain.User;

/** 
 * 功能概要：User的DAO类 
 *  
 * @author chlei 
 * @since 2017年5月5日 
 */  
public interface UserDao {  
    /** 
     *  
     * @author linbingwen 
     * @since 2017年5月05日 
     * @param userId 
     * @return 
     */  
    public User selectUserById(Integer userId);  
  
}  
