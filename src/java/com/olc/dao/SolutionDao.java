/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.olc.dao;

import com.olc.model.Solution;
import com.olc.model.TestCaseResult;
import com.olc.util.DbUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author mahmoud
 */
public class SolutionDao {
      private Connection conn;
        
	public SolutionDao() {
		
		conn= DbUtil.getConnection();//connect to database
	}
        public void submitSolution(Solution solution){
        try
		{
                   
                    
			PreparedStatement ps = conn
					.prepareStatement("insert into solution(solution_code,date,user_id,problem_id,language_id) values (?,now(),?,?,?)",new String[] {"id"});//add solution to database and get id later
			ps.setString(1, solution.getCode());
                        ps.setInt(2, solution.getUserId());
                        ps.setInt(3, solution.getProblemId());
                        ps.setInt(4, solution.getLanguageId());
                       
                      
			ps.executeUpdate();
                        
                         ResultSet rs = ps.getGeneratedKeys();
                    if (rs.next()) {
                        //gets solution added id
                      solution.setId(rs.getInt(1)) ;
                      
                        }    
                 
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
        }
        
        public Solution getSolutionByUserAndProblemId(int user_id,int problem_id){
             Solution solution = new Solution();
            try
		{
                  
			PreparedStatement ps  = conn
					.prepareStatement("SELECT * FROM `solution` WHERE user_id = ? AND problem_id = ? ORDER BY date DESC LIMIT 1");
			ps.setInt(1, user_id);
    			ps.setInt(2, problem_id);

                        ResultSet rs = ps.executeQuery();
			
                        while (rs.next())
			{
				
				solution.setId(rs.getInt("id"));
                                solution.setCode(rs.getString("solution_code"));
                                solution.setLanguageId(rs.getInt("language_id"));
                                solution.setStatus(rs.getInt("compilation_look_up_id"));
                                solution.setError(rs.getString("error"));
                                
                                TestCaseResultDao dao = new TestCaseResultDao();
                                List<TestCaseResult> testcaseresultlist= dao.listTestCaseResultBysolutionId(solution.getId());
                                
                                  for(int i =0;i<testcaseresultlist.size();i++){
                          
                                      solution.setTestCaseResultList(testcaseresultlist.get(i));
                           
                            }
			}
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
            return solution;
        }
        
        
}
