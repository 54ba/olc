/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.olc.dao;

import com.olc.model.Competition;
import com.olc.model.Problem;
import com.olc.model.TeamCompetition;
import com.olc.model.TestCase;
import com.olc.util.DbUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author mahmoud
 */
public class CompetitionDao {
    private Connection conn;
        
	public CompetitionDao() {
		
		conn= DbUtil.getConnection();//connect to database
	}
        
        public static Date convertUtilDateToSqlDate(java.util.Date date){
        if(date != null) {
            Date sqlDate = new Date(date.getTime());
            return sqlDate;
        }
        return null;
    }
        
        public boolean validateCompetition(String name)
	{
		boolean found=false;
		
		//Search database for team name return true if found
		try
		{
			PreparedStatement ps = conn
					.prepareStatement("select * from competition where name=? ");
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
        
        
        public void createCompetition(Competition competition,String[] submitted_problems){
             
		try
		{
                   
                    
			PreparedStatement ps = conn
					.prepareStatement("insert into competition(name,start,end,creator) values (?,?,?,?)",new String[] {"id"});
			ps.setString(1, competition.getName());
                        ps.setDate(2,convertUtilDateToSqlDate(competition.getStartDate()));
                        ps.setDate(3,convertUtilDateToSqlDate(competition.getEndDate()));
                        ps.setInt(4, competition.getCreator());
			ps.executeUpdate();
                        
                         ResultSet rs = ps.getGeneratedKeys();
                    if (rs.next()) {
                        //insert into problem_has_competiton
                        ps = conn
					.prepareStatement("insert into problem_has_competition(problem_id,competition_id) values(?,?)");
                        for(int i = 0;i<submitted_problems.length;i++){
                        ps.setInt(1,Integer.parseInt(submitted_problems[i]));
                        ps.setInt(2,rs.getInt(1));
                        ps.executeUpdate();
                        
                        }
                    }
                      
                      
                 
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
                
          }
       
        public List<Competition> listUpcomingCompetitions() {
            
            List<Competition> competitionList = new ArrayList<Competition>();
            try
		{
			PreparedStatement ps = conn
					.prepareStatement("SELECT * FROM `competition` WHERE start > CURDATE()");
			
			ResultSet rs = ps.executeQuery();
			while (rs.next())
			{
				Competition competition = new Competition();
				competition.setId(rs.getInt("id"));
				competition.setName(rs.getString("name"));
				competition.setStartDate(rs.getDate("start"));
                                competition.setEndDate(rs.getDate("end"));
                                competition.setCreator(rs.getInt("creator"));
                                competitionList.add(competition);
			}
                       
                       
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		 return competitionList;

            
        }
          
         public void acceptCompetition(int team_id,int competition_id){
          try{
          
           PreparedStatement   ps =conn
					.prepareStatement("INSERT INTO `team_has_competition` (`team_id`, `competition_id`) VALUES (?, ?)");
                        
           ps.setInt(1, team_id);
           ps.setInt(2, competition_id);
          
           ps.executeUpdate();
                    
            }catch(SQLException e)
		{
			e.printStackTrace();
		}
          
          
          }
         public int getTeamScore(int team_id,int competition_id){
             int score = 0;

             try{
             PreparedStatement ps = conn
					.prepareStatement("SELECT * FROM `team_has_competition` WHERE `team_id`=? AND `competition_id` = ?");
			
                ps.setInt(1, team_id);
                ps.setInt(2, competition_id);
          
			ResultSet rs = ps.executeQuery();
			while (rs.next())
			{
                            score = rs.getInt("score");
			}
             }catch(SQLException e){
                e.printStackTrace();

             }
             return score;
         }
         
         public void updateScore(int new_score,int team_id,int competition_id){
         
             try
		{
                   
			PreparedStatement ps = conn
					.prepareStatement("UPDATE `team_has_competition` SET `score` = ? WHERE `team_has_competition`.`team_id` = ? AND `team_has_competition`.`competition_id`=? ");
                      ps.setInt(1, new_score);
                      ps.setInt(2, team_id);
                      ps.setInt(3, competition_id);

                     ps.executeUpdate();
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
         
         }
         
         public ArrayList<Integer> getCompetitionIdByTeamId(int team_id){
        
             
             ArrayList<Integer> competitionId = new ArrayList<Integer>();
             
             try{
          
           PreparedStatement   ps =conn
					.prepareStatement("SELECT * FROM `team_has_competition` WHERE team_id =?");
                        
           ps.setInt(1, team_id);
           
          
           ResultSet rs =ps.executeQuery();
           
           while (rs.next())
			{
				competitionId.add(rs.getInt(4));
			}
                       
           
            }catch(SQLException e)
		{
			e.printStackTrace();
		}
             return competitionId;
          
         
         }
         
         public List<Competition> listRunningCompetitions(int team_id){
             

                      
            List<Competition> competitionList = new ArrayList<Competition>();
            try
		{
			PreparedStatement ps = conn
					.prepareStatement("SELECT * FROM `competition` ,`team_has_competition` WHERE `team_has_competition`.`competition_id` = `competition`.`id` AND competition.start < CURDATE() AND competition.end > CURDATE()"+
                                                "AND team_has_competition.team_id = ?");
			
                        ps.setInt(1,team_id);
                        
			ResultSet rs = ps.executeQuery();
			while (rs.next())
			{
				Competition competition = new Competition();
				competition.setId(rs.getInt("id"));
				competition.setName(rs.getString("name"));
				competition.setStartDate(rs.getDate("start"));
                                competition.setEndDate(rs.getDate("end"));
                                competition.setCreator(rs.getInt("creator"));
                                competitionList.add(competition);
			}
                       
                       
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		 return competitionList;

                     
             
         }
         
         public int getCompetitionTeamsNum(int competition_id){
             int rowcount = 0; 
             try
		{
			PreparedStatement ps = conn
					.prepareStatement("SELECT * FROM `team_has_competition` WHERE competition_id = ?");
			
                        ps.setInt(1,competition_id);
                        
			ResultSet rs = ps.executeQuery();
			
				
                        if (rs.last()) {
                            rowcount = rs.getRow();
                            rs.beforeFirst(); 
                            
                        }
                       
                       
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		 return rowcount;
         
         }
         
         public List<Problem> listCompetitionProblems(int competition_id){
                     List<Problem> problemList = new ArrayList<Problem>();

         try
		{
                       
                       PreparedStatement ps = conn
					.prepareStatement("SELECT * FROM problem,`problem_has_competition` WHERE`problem_has_competition`.`problem_id`=problem.id AND competition_id = ?");
			
                        ps.setInt(1,competition_id);
              
			ResultSet rs = ps.executeQuery();
			while (rs.next())
			{
                              Problem problem = new Problem();

                                
				problem.setId(rs.getInt("id"));

				problem.setTitle(rs.getString("title"));
                               
                                
				problem.setComplexity(rs.getString("complexity"));
                                problem.setPoints(rs.getInt("points"));
                                problemList.add(problem);
				
                        }
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		 return problemList;

                 
         
         }
         
         public List<Competition> getCreatedCompetitionsByUserId(int user_id){
                         List<Competition> competitionList = new ArrayList<Competition>();
                          try
		{
			PreparedStatement ps = conn
					.prepareStatement("SELECT * FROM `competition` WHERE creator = ?");
			
                        ps.setInt(1,user_id);
                        
			ResultSet rs = ps.executeQuery();
			while (rs.next())
			{
				Competition competition = new Competition();
				competition.setId(rs.getInt("id"));
				competition.setName(rs.getString("name"));
				competition.setStartDate(rs.getDate("start"));
                                competition.setEndDate(rs.getDate("end"));
                                competition.setCreator(rs.getInt("creator"));
                                competitionList.add(competition);
			}
                       
                       
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		 return competitionList;

         }
         
         public int queryCreatedCompetitionByUserIdAndCompetitionId(int user_id,int competition_id){
             int result=0;
                      try
		{
			PreparedStatement ps = conn
					.prepareStatement("SELECT * FROM `competition` WHERE creator = ? And id = ?");
			
                        ps.setInt(1,user_id);
                        ps.setInt(2,competition_id);

                        
			ResultSet rs = ps.executeQuery();
			while (rs.next())
			{
				result=1;
			}
                       
                       
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		 return result;

             
         }
         
         public  List<TeamCompetition> getCompetitionTeamScoreOrdered(int competition_id){
          List<TeamCompetition> teamcompetitionlist = new ArrayList<TeamCompetition>();
                      try
		{
			PreparedStatement ps = conn
					.prepareStatement("SELECT *, FIND_IN_SET( score, ( SELECT GROUP_CONCAT( score ORDER BY score DESC ) FROM( SELECT * FROM `team_has_competition` WHERE competition_id=? ORDER BY score DESC) as dsaaas ) ) AS rank FROM ( SELECT * FROM `team_has_competition` WHERE competition_id=? ORDER BY score DESC) as tb");
			
                        ps.setInt(1,competition_id);
                        ps.setInt(2,competition_id);

                        
			ResultSet rs = ps.executeQuery();
                        TeamDao teamdao = new TeamDao();
			while (rs.next())
			{
                            TeamCompetition team_competition = new TeamCompetition();
                            team_competition.setCompetitionId(competition_id);
                            team_competition.setId(rs.getInt("id"));
                            team_competition.setScore(rs.getInt("score"));
                            team_competition.setTeamId(rs.getInt("team_id"));
                            String teamname= teamdao.getTeamNameById(rs.getInt("team_id"));
                            team_competition.setTeamName(teamname);
                            team_competition.setRank(rs.getInt("rank"));
                            teamcompetitionlist.add(team_competition);
			}
                       
                       
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		 return teamcompetitionlist;

             
         
         
         }
}
