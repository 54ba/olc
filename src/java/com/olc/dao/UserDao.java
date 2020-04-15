/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.olc.dao;

/**
 *
 * @author mahmoud
 */

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.olc.model.User;
import com.olc.util.DbUtil;

import java.util.ArrayList;
import java.util.List;

public class UserDao {
    
    
	private Connection conn;
        
	public UserDao() {
		
		conn= DbUtil.getConnection();//connect to database
	}

        //Validates login with user input
	public boolean validateLogin(String username,String password)
	{
		boolean found=false;
		
		//Search database for email and password and return true if found
		try
		{
			PreparedStatement ps = conn
					.prepareStatement("select * from user where username=? and password=?");
			ps.setString(1, username);
			ps.setString(2, password);
			
			ResultSet rs = ps.executeQuery();
			found= rs.next(); //true if found else false
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		return found;
	}
        public boolean validateRegister(String username)
	{
		boolean found=false;
		
		//Search database for email and password and return true if found
		try
		{
			PreparedStatement ps = conn
					.prepareStatement("select * from user where username=? ");
			ps.setString(1, username);
			
			ResultSet rs = ps.executeQuery();
			found= rs.next(); //true if found else false
                        
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		return found;
	}
        
        
        public void createUser(User user)
	{
            
		try
		{
			PreparedStatement ps = conn
					.prepareStatement("insert into user(username,password,name,role,team_id) values (?,?,?,?,1)");//add user to database and get id later
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getName());
                        //default 0 for user privillage
                        ps.setInt(4,0);
			ps.executeUpdate();
                        
                 
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
                               
	}
        
            public User getUserByUsername(String username)
	{
		User user=new User(); //create new user object
		try
		{
			PreparedStatement ps = conn
					.prepareStatement("select * from user where username= ?");
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			
			if(rs.next())
			{
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
                                user.setName(rs.getString("name"));
                                user.setTeamId(rs.getInt("team_id"));
                                user.setScore(rs.getInt("score"));
                                user.setLeader(rs.getInt("leader"));
                                user.setRole(rs.getInt("role"));

			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return user;
	}
            
            public User getUserById(int id)
	{
		User user=new User(); //create new user object
		try
		{
			PreparedStatement ps = conn
					.prepareStatement("select * from user where id= ?");
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			
			if(rs.next())
			{
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
                                user.setName(rs.getString("name"));
                                user.setTeamId(rs.getInt("team_id"));
                                user.setScore(rs.getInt("score"));
                                user.setLeader(rs.getInt("leader"));
                                user.setRole(rs.getInt("role"));

			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return user;
	}
	
	
          public List<User> listUsers()
	{
		List<User> userList = new ArrayList<User>();
		try
		{
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery("select * from user");
			while (rs.next())
			{
				User user = new User();
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("username"));
                                user.setPassword(rs.getString("password"));
				user.setName(rs.getString("name"));
                                user.setTeamId(rs.getInt("team_id"));
                                user.setScore(rs.getInt("score"));
                                user.setLeader(rs.getInt("leader"));
				userList.add(user);
                                
			}
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		return userList;
	
        }
         public List<User> listUsernameAndId()
	{
		List<User> userList = new ArrayList<User>();
		try
		{
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery("select id,username from user");
			while (rs.next())
			{
				User user = new User();
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("username"));
				userList.add(user);
			}
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		return userList;
	
                
        }
         
         public void editPrivillage(int user_id,int role){
             
             try
		{
                   
			PreparedStatement ps = conn
					.prepareStatement("UPDATE `user` SET `role` = ? WHERE `user`.`id` = ? ");
                      ps.setInt(1, role);
                      ps.setInt(2, user_id);
                    
                     ps.executeUpdate();
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
         }
         
         public void updateScore(int new_score,int user_id){
         
         
          try
		{
                   
			PreparedStatement ps = conn
					.prepareStatement("UPDATE `user` SET `score` = ? WHERE `user`.`id` = ? ");
                      ps.setInt(1, new_score);
                      ps.setInt(2, user_id);
                    
                     ps.executeUpdate();
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
         
         }
        
         public int getRank(int user_id){
           int rank = 0;
             try
		{
			PreparedStatement ps = conn.prepareStatement("SELECT id, score, FIND_IN_SET( score, ( SELECT GROUP_CONCAT( score ORDER BY score DESC ) FROM user ) ) AS rank FROM user WHERE id = ?");
			ps.setInt(1, user_id);

                        ResultSet rs = ps.executeQuery();
                        while (rs.next())
			{
                            rank = rs.getInt("rank");
			}
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
             return rank;
         }

}
