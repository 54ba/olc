/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.olc.dao;

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
public class TestCaseResultDao {
     private Connection conn;
        
	public TestCaseResultDao() {
		
		conn= DbUtil.getConnection();//connect to database
	}
        
            
        public  List<TestCaseResult> listTestCaseResultBysolutionId(int solution_id){
            
            List<TestCaseResult> testcaseresultlist = new ArrayList<TestCaseResult>();

            try{
               PreparedStatement ps = conn
					.prepareStatement("select * from test_case_result where solution_id  = ?");
			ps.setInt(1, solution_id);
                        ResultSet rs = ps.executeQuery();

                        while (rs.next())
			{
                            
                        TestCaseResult testcaseresult = new TestCaseResult();                
                            testcaseresult.setId(rs.getInt("id"));
                            testcaseresult.setMemoryUsage(rs.getString("memory_usage"));
                            testcaseresult.setRunningTime(rs.getString("running_time"));
                            testcaseresult.setSolutionId(rs.getInt("solution_id"));
                            testcaseresult.setTestCaseId(rs.getInt("test_case_id"));
                            testcaseresult.setPassed(rs.getInt("test_case_passed_look_up_id"));
                        testcaseresultlist.add(testcaseresult);
                        }
                }
          catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		
            return testcaseresultlist;

        
        }
}
