/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.olc.dao;

import com.olc.model.CompetitionPoints;
import com.olc.util.DbUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author mahmoud
 */
public class CompetitonPointsDao {
    
     private Connection conn;
        
	public CompetitonPointsDao() {
		
		conn= DbUtil.getConnection();//connect to database
	}
        
          public boolean gotpoints(CompetitionPoints competition_points){
            boolean found=false; 

            try
		{
			PreparedStatement ps = conn
					.prepareStatement("select * from competition_points where problem_id=? AND team_id=? competition_id =? ");
			ps.setInt(1, competition_points.getProblemId());
			ps.setInt(2, competition_points.getTeamId());
                        ps.setInt(3, competition_points.getCompetitionId());


			
			ResultSet rs = ps.executeQuery();
			while (rs.next())
			{
                            competition_points.setId(rs.getInt("id"));
                             found=true; 
                        }
                        
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
            return found;
        }
        
          public void givePoints(CompetitionPoints competition_points){
            try
		{
			PreparedStatement ps = conn
					.prepareStatement("INSERT INTO `competiiton_points` (`competition_id`, `team_id`, `problem_id`) VALUES (?, ?, ?)");
                      
                        ps.setInt(1, competition_points.getCompetitionId());
                        ps.setInt(2, competition_points.getTeamId());
                        ps.setInt(3, competition_points.getProblemId());


			
                     ps.executeUpdate();
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
        }
}
