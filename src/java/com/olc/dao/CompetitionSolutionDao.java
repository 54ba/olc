/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.olc.dao;

import com.olc.model.CompetitionSolution;
import com.olc.model.CompetitionTestCaseResult;
import com.olc.util.DbUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author mahmoud
 */
public class CompetitionSolutionDao {
     private Connection conn;
        
	public CompetitionSolutionDao() {
		
		conn= DbUtil.getConnection();//connect to database
	}
        public void submitCompetitionSolution(CompetitionSolution competitionsolution){
        try
		{
                   
                    
			PreparedStatement ps = conn
					.prepareStatement("insert into competition_solution(solution_code,date,team_id,problem_id,language_id,competition_id) values (?,now(),?,?,?,?)",new String[] {"id"});//add solution to database and get id later
			ps.setString(1, competitionsolution.getCode());
                        ps.setInt(2, competitionsolution.getTeamId());
                        ps.setInt(3, competitionsolution.getProblemId());
                        ps.setInt(4, competitionsolution.getLanguageId());
                        ps.setInt(5, competitionsolution.getCompetitionId());

                       
                      
			ps.executeUpdate();
                        
                         ResultSet rs = ps.getGeneratedKeys();
                    if (rs.next()) {
                        //gets solution added id
                      competitionsolution.setId(rs.getInt(1)) ;
                      
                        }    
                 
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
        }
        
        public CompetitionSolution getCompetitionSolutionByTeamIdAndProblemIdAndCompetitionId(int team_id,int problem_id,int competition_id){
             CompetitionSolution competitionsolution = new CompetitionSolution();
            try
		{
                  
			PreparedStatement ps  = conn
					.prepareStatement("SELECT * FROM `competition_solution` WHERE team_id = ? AND problem_id = ? And competition_id = ? ORDER BY date DESC LIMIT 1");
			ps.setInt(1, team_id);
    			ps.setInt(2, problem_id);
     			ps.setInt(3, competition_id);


                        ResultSet rs = ps.executeQuery();
			
                        while (rs.next())
			{
				
				competitionsolution.setId(rs.getInt("id"));
                                competitionsolution.setCode(rs.getString("solution_code"));
                                competitionsolution.setLanguageId(rs.getInt("language_id"));
                                competitionsolution.setStatus(rs.getInt("compilation_look_up_id"));
                                competitionsolution.setError(rs.getString("error"));


                                
                                CompetitionTestCaseResultDao dao = new CompetitionTestCaseResultDao();
                                List<CompetitionTestCaseResult> competitiontestcaseresultlist= dao.listCompetitionTestCaseResultByCompetitionSolutionId(competitionsolution.getId());
                                
                                  for(int i =0;i<competitiontestcaseresultlist.size();i++){
                          
                                      competitionsolution.setCompetitionTestCaseResultList(competitiontestcaseresultlist.get(i));
                           
                            }
			}
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
            return competitionsolution;
        }
        
}
