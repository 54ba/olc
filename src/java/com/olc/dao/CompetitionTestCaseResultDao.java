/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.olc.dao;

import com.olc.model.CompetitionTestCaseResult;
import com.olc.model.TestCaseResult;
import com.olc.util.DbUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author mahmoud
 */
public class CompetitionTestCaseResultDao {
     private Connection conn;
        
	public CompetitionTestCaseResultDao() {
		
		conn= DbUtil.getConnection();//connect to database
	}
        
            
        public  List<CompetitionTestCaseResult> listCompetitionTestCaseResultByCompetitionSolutionId(int competition_solution_id){
            
            List<CompetitionTestCaseResult> competitiontestcaseresultlist = new ArrayList<CompetitionTestCaseResult>();

            try{
               PreparedStatement ps = conn
					.prepareStatement("select * from competition_test_case_result where competition_solution_id  = ?");
			ps.setInt(1, competition_solution_id);
                        ResultSet rs = ps.executeQuery();

                        while (rs.next())
			{
                            
                        CompetitionTestCaseResult competitiontestcaseresult = new CompetitionTestCaseResult();                
                            competitiontestcaseresult.setId(rs.getInt("id"));
                            competitiontestcaseresult.setMemoryUsage(rs.getString("memory_usage"));
                            competitiontestcaseresult.setRunningTime(rs.getString("running_time"));
                            competitiontestcaseresult.setCompetitionSolutionId(rs.getInt("competition_solution_id"));
                            competitiontestcaseresult.setTestCaseId(rs.getInt("test_case_id"));
                            competitiontestcaseresult.setPassed(rs.getInt("test_case_passed_look_up_id"));
                        competitiontestcaseresultlist.add(competitiontestcaseresult);
                        }
                }
          catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		
            return competitiontestcaseresultlist;

        
        }
}
