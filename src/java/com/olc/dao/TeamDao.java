/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.olc.dao;

import com.olc.model.Team;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.olc.model.User;
import com.olc.util.DbUtil;

import java.util.ArrayList;
import java.util.List;


/**
 *
 * @author mahmoud
 */
public class TeamDao {
 
    private Connection conn;
        
	public TeamDao() {
		
		conn= DbUtil.getConnection();//connect to database
	}
        
         public void createTeam(Team team)
	{
             
		try
		{
                   
                    
			PreparedStatement ps = conn
					.prepareStatement("insert into team(name) values (?)",new String[] {"id"});//add team to database and get id later
			ps.setString(1, team.getName());
			
			ps.executeUpdate();
                        
                         ResultSet rs = ps.getGeneratedKeys();
                    if (rs.next()) {
                        //gets team added id
                      team.setId(rs.getInt(1)) ;
                      ps = conn
					.prepareStatement("UPDATE `user` SET `team_id` = ? ,`leader`= ? WHERE `user`.`id` = ? ");
                      
                      ps.setInt(1, team.getId());
                      ps.setInt(2, 1);
                      ps.setInt(3, team.getLeader());
                      ps.executeUpdate();
                        }
                    
               
                      
                 
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
                                 
	}
         
          public boolean validateTeam(String name)
	{
		boolean found=false;
		
		//Search database for team name return true if found
		try
		{
			PreparedStatement ps = conn
					.prepareStatement("select * from team where name=? ");
			ps.setString(1, name);
			
			ResultSet rs = ps.executeQuery();
			found= rs.next(); //true if found else false
                        
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		return found;
	}
        
          public void createUserTeam(int user_id, int team_id){
          try{
          
           PreparedStatement   ps =conn
					.prepareStatement("INSERT INTO user_has_team (user_id, team_id) VALUES (?,?)");
                        
           ps.setInt(1, user_id);
           ps.setInt(2, team_id);
           
           ps.executeUpdate();
                    
            }catch(SQLException e)
		{
			e.printStackTrace();
		}
          
          
          }
          
             public List<Team> getUserTeam(int user_id)
	{
           List<Team> teamList = new ArrayList<Team>();
          
		try
		{
			PreparedStatement ps = conn
					.prepareStatement("SELECT * FROM user_has_team where user_id=?");
			ps.setInt(1, user_id);
			ResultSet rs = ps.executeQuery();
			while (rs.next())
			{
				Team team = new Team();
				team.setId(rs.getInt("team_id"));
                                teamList.add(team);
			}
                        
                        for(int i=0;i<teamList.size();i++){
                        ps = conn
					.prepareStatement("SELECT * FROM `team` WHERE id = ? ");
                       
                            ps.setInt(1, teamList.get(i).getId());
                            rs = ps.executeQuery();
                            //set teams name
                            while (rs.next())
                            {
				
                                teamList.get(i).setName(rs.getString("name"));
                                
                            }
                            
                             ps = conn
					.prepareStatement("SELECT * FROM user WHERE team_id = ? ");
                       
                            ps.setInt(1, teamList.get(i).getId());
                            rs = ps.executeQuery();
                            
                             while (rs.next())
                            {
				User user = new User();
                                user.setUsername(rs.getString("username"));
                                user.setName(rs.getString("name"));
                                teamList.get(i).setUserList(user);
                             
                            }
                            
                        }
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		return teamList;
	}
             

         
          public void acceptTeam(int user_id, int team_id){
          try{
          
           PreparedStatement   ps =conn
					.prepareStatement("UPDATE `user` SET `team_id` = ? WHERE `user`.`id` = ?");
                        
           ps.setInt(1, team_id);
           ps.setInt(2, user_id);
          
           ps.executeUpdate();
                    
            }catch(SQLException e)
		{
			e.printStackTrace();
		}
          
          
          }
          public int getTeamScore(int team_id,int competition_id){
             int score = 0;
              try{
              
                          PreparedStatement   ps = conn
					.prepareStatement("SELECT score FROM team_has_competition WHERE team_id =? AND competition_id= ? ");
                       
                            ps.setInt(1, team_id);
                            ps.setInt(2, competition_id);

                            
                           ResultSet rs = ps.executeQuery();
                            
                             while (rs.next())
                            {
                              score=rs.getInt("score");  
                            }
              
              }catch(SQLException e){
			e.printStackTrace();
		}
              return score;
          }
          
          public String getTeamNameById(int team_id){
          String name = "error";
          
           try{
              
                          PreparedStatement   ps = conn
					.prepareStatement("SELECT * FROM `team` WHERE id = ?");
                            ps.setInt(1, team_id);
                            

                            
                           ResultSet rs = ps.executeQuery();
                            
                             while (rs.next())
                            {
                              name=rs.getString("name");  
                            }
              
              }catch(SQLException e){
			e.printStackTrace();
		}
              return name;
          }
}
