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
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author mahmoud
 */
public class ProblemDao {
     private Connection conn;
        
	public ProblemDao() {
		
		conn= DbUtil.getConnection();//connect to database
	}
        
          public boolean validateProblem(String title)
	{
		boolean found=false;
		
		//Search database for problem name return true if found
		try
		{
			PreparedStatement ps = conn
					.prepareStatement("select * from problem where title=? ");
			ps.setString(1, title);
			
			ResultSet rs = ps.executeQuery();
			found= rs.next(); //true if found else false
                        
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		return found;
	}
          
          public void createProblem(Problem problem){
              
              
		try
		{
                   
                    
			PreparedStatement ps = conn
					.prepareStatement("insert into problem(title,description,sample_input,sample_output,validated,c_code,cplus_code,java_code) values (?,?,?,?,?,?,?,?)",new String[] {"id"});//add problem to database and get id later
			ps.setString(1, problem.getTitle());
                        ps.setString(2, problem.getDescription());
                        ps.setString(3, problem.getSampleInput());
                        ps.setString(4, problem.getSampleOutput());
                        //for validated
                        ps.setInt(5, problem.getValidated());
                        ps.setString(6, problem.getCCode());
                        ps.setString(7, problem.getCplusCode());
                        ps.setString(8, problem.getJavaCode());
			ps.executeUpdate();
                        
                         ResultSet rs = ps.getGeneratedKeys();
                    if (rs.next()) {
                        //gets problem added id
                      problem.setId(rs.getInt(1)) ;
                      //submit test cases
                      
                      TestCaseDao dao = new TestCaseDao();
                      
                      List<TestCase> testcaselist= problem.getTestCaseList();
                      for(int i =0;i<testcaselist.size();i++){
                          
                          TestCase testcase = testcaselist.get(i);
                           testcase.setProblemId(problem.getId());
                          dao.createTestCase(testcase);
                      
                      }
                      
                      
                        }    
                 
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
          }
          
          
          public void updateProblem(Problem problem){
              
              
		try
		{
                   
                    
			PreparedStatement ps = conn
					.prepareStatement("UPDATE problem SET title =?, description =?, sample_input =?,sample_output=?, validated = ?, complexity=?,scope=?,points=?,c_code=?,cplus_code=?,java_code=?  where id = ?");
			ps.setString(1, problem.getTitle());
                        ps.setString(2, problem.getDescription());
                        ps.setString(3, problem.getSampleInput());
                        ps.setString(4, problem.getSampleOutput());
                        //for validated
                        ps.setInt(5, problem.getValidated());
                        ps.setString(6, problem.getComplexity());
                        ps.setInt(7, problem.getScope());
                        ps.setInt(8, problem.getPoints());
                        ps.setString(9, problem.getCCode());
                        ps.setString(10, problem.getCplusCode());
                        ps.setString(11, problem.getJavaCode());
                        ps.setInt(12,problem.getId());
                      
			
                         int executed = ps.executeUpdate();
                         
                    if (executed == 1) {
                      
                      //submit test cases
                      
                      TestCaseDao dao = new TestCaseDao();
                      
                      List<TestCase> testcaselist= problem.getTestCaseList();
                      for(int i =0;i<testcaselist.size();i++){
                          
                           
                          dao.updateTestCase(testcaselist.get(i));
                      
                             }
                      
                      
                    }    
                 
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
              
          }
          
          public List<Problem> listValidatedPublicProblems()
	{
		List<Problem> problemList = new ArrayList<Problem>();
		try
		{
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery("select * from problem where validated = 1 AND scope = 0");
			while (rs.next())
			{
				Problem problem = new Problem();
				problem.setId(rs.getInt("id"));
				problem.setTitle(rs.getString("title"));
                                problem.setDescription(rs.getString("description"));
                                problem.setSampleInput(rs.getString("sample_input"));
                                problem.setSampleOutput(rs.getString("sample_output"));
				problem.setComplexity(rs.getString("complexity"));
                                problem.setValidated(rs.getInt("validated"));
                                problem.setPoints(rs.getInt("points"));
                                problem.setCCode(rs.getString("c_code"));
                                problem.setJavaCode(rs.getString("java_code"));
                                problem.setCplusCode(rs.getString("cplus_code"));

                                problemList.add(problem);
                                
			}
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		return problemList;
	
        }
          public List<Problem> listUnValidatedProblems()
	{
		List<Problem> problemList = new ArrayList<Problem>();
		try
		{
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery("select * from problem where validated = 0");
			while (rs.next())
			{
				Problem problem = new Problem();
				problem.setId(rs.getInt("id"));
				problem.setTitle(rs.getString("title"));
                                problem.setDescription(rs.getString("description"));
                                problem.setSampleInput(rs.getString("sample_input"));
                                problem.setSampleOutput(rs.getString("sample_output"));
                                problem.setComplexity(rs.getString("complexity"));
                                problem.setValidated(rs.getInt("validated"));
                                   
                                problem.setPoints(rs.getInt("points"));
				problem.setCCode(rs.getString("c_code"));
                                problem.setJavaCode(rs.getString("java_code"));
                                problem.setCplusCode(rs.getString("cplus_code"));
                                problemList.add(problem);
                                
			}
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		return problemList;
	
        }
          
          
          public Problem getProblemById(int problem_id){
          
              Problem problem = new Problem();
          
            try{
               PreparedStatement ps = conn
					.prepareStatement("select * from problem where id = ?");
			ps.setInt(1, problem_id);
                        ResultSet rs = ps.executeQuery();

                        while (rs.next())
			{
                            
                            problem.setTitle(rs.getString("title"));
                            problem.setDescription(rs.getString("description"));
                            problem.setSampleInput(rs.getString("sample_input"));
                            problem.setSampleOutput(rs.getString("sample_output"));
                            problem.setSampleOutput(rs.getString("sample_output"));
                            problem.setValidated(rs.getInt("validated"));
                            
                            problem.setComplexity(rs.getString("complexity"));
                            problem.setPoints(rs.getInt("points"));
                            problem.setCCode(rs.getString("c_code"));
                            problem.setJavaCode(rs.getString("java_code"));
                            problem.setCplusCode(rs.getString("cplus_code"));
                            
                            TestCaseDao dao = new TestCaseDao();
                            
                            List<TestCase> testcaselist= dao.listTestCaseByProblemId(problem_id);
                       
                            for(int i =0;i<testcaselist.size();i++){
                          
                           problem.setTestCaseList(testcaselist.get(i));
                           
                            }
                           
                        
                        }
                }
                catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		
            return problem;
          }
          
          
           
           public boolean validateValidation(String title,int id){
           
           
           boolean found=false;
		
		//Search database for team name return true if found
		try
		{
			PreparedStatement ps = conn
					.prepareStatement("select * from problem where title=? And id <> ?");
			ps.setString(1, title);
                        ps.setInt(2, id);
			
			ResultSet rs = ps.executeQuery();
			found= rs.next(); //true if found else false
                        
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		return found;
           
           
           }
}
