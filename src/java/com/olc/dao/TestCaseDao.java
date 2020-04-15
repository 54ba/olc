/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.olc.dao;

import com.olc.model.Problem;
import com.olc.model.TestCase;
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
public class TestCaseDao {
      private Connection conn;
        
	public TestCaseDao() {
		
		conn= DbUtil.getConnection();//connect to database
	}
        
        public void createTestCase(TestCase testcase){
            
		try
		{
                   
                   PreparedStatement ps = conn
					.prepareStatement("insert into test_case(input,output,problem_id) values (?,?,?)");
			ps.setString(1, testcase.getInput());
			ps.setString(2, testcase.getOutput());
                        ps.setInt(3, testcase.getProblemId());

			ps.executeUpdate();
                }catch(SQLException e)
		{
			e.printStackTrace();
		}
        }
        
        public void updateTestCase(TestCase testcase){
            
		try
		{
                   
                   PreparedStatement ps = conn
					.prepareStatement("UPDATE test_case SET input = ?,output=? WHERE id = ? AND problem_id = ?");
			ps.setString(1, testcase.getInput());
			ps.setString(2, testcase.getOutput());
                        ps.setInt(3, testcase.getId());
                        ps.setInt(4, testcase.getProblemId());

			ps.executeUpdate();
                }catch(SQLException e)
		{
			e.printStackTrace();
		}
        }
        
        public  List<TestCase> listTestCaseByProblemId(int problem_id){
            
            List<TestCase> testcaselist = new ArrayList<TestCase>();

            try{
               PreparedStatement ps = conn
					.prepareStatement("select * from test_case where problem_id  = ?");
			ps.setInt(1, problem_id);
                        ResultSet rs = ps.executeQuery();

                        while (rs.next())
			{
                            
                        TestCase testcase = new TestCase();                
                            testcase.setId(rs.getInt("id"));
                            testcase.setInput(rs.getString("input"));
                            testcase.setOutput(rs.getString("output"));
                            testcase.setProblemId(rs.getInt("problem_id"));
                   
                        testcaselist.add(testcase);
                        }
                }
          catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		
            return testcaselist;

        
        }
}
