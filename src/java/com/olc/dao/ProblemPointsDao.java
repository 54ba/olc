/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.olc.dao;

import com.olc.model.ProblemPoints;
import com.olc.util.DbUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author mahmoud
 */
public class ProblemPointsDao {
      private Connection conn;
        
	public ProblemPointsDao() {
		
		conn= DbUtil.getConnection();//connect to database
	}
        
        public boolean gotpoints(ProblemPoints problem_points){
            boolean found=false; 

            try
		{
			PreparedStatement ps = conn
					.prepareStatement("select * from problem_points where problem_id=? AND user_id=? ");
			ps.setInt(1, problem_points.getProblemId());
			ps.setInt(2, problem_points.getUserId());

			
			ResultSet rs = ps.executeQuery();
			while (rs.next())
			{
                            problem_points.setId(rs.getInt("id"));
                             found=true; 
                        }
                        
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
            return found;
        }
        
         public void givePoints(ProblemPoints problem_points){
            try
		{
			PreparedStatement ps = conn
					.prepareStatement("INSERT INTO `problem_points` ( `problem_id`, `user_id`) VALUES ( ?, ?)");

                        ps.setInt(1, problem_points.getProblemId());
			ps.setInt(2, problem_points.getUserId());

			
                     ps.executeUpdate();
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
        }
}
