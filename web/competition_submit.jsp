<%-- 
    Document   : competition_submit
    Created on : Apr 20, 2018, 2:29:49 AM
    Author     : mahmoud
--%>

<%@page import="com.olc.dao.CompetitionDao"%>
<%@page import="com.olc.dao.ProblemDao"%>
<%@page import="com.olc.dao.CompetitonPointsDao"%>
<%@page import="com.olc.model.CompetitionPoints"%>
<%@page import="com.olc.model.TestCase"%>
<%@page import="com.olc.dao.TestCaseDao"%>
<%@page import="com.olc.model.CompetitionTestCaseResult"%>
<%@page import="java.util.List"%>
<%@page import="com.olc.dao.CompetitionTestCaseResultDao"%>
<%@page import="com.olc.dao.CompetitionSolutionDao"%>
<%@page import="com.olc.model.CompetitionSolution"%>
<%
    if(request.getParameter("submit") != null)
            {
                
                String code=request.getParameter("code");
		int problem_id =Integer.parseInt(request.getParameter("problem_id"));
		int team_id =Integer.parseInt(request.getParameter("team_id"));
                int competition_id =Integer.parseInt(request.getParameter("competition_id"));
               	int language_id =Integer.parseInt(request.getParameter("language"));
                
                CompetitionSolution competitionsolution = new CompetitionSolution();
                competitionsolution.setLanguageId(language_id);
                competitionsolution.setProblemId(problem_id);
                competitionsolution.setCompetitionId(competition_id);
                competitionsolution.setTeamId(team_id);

                competitionsolution.setCode(code);
                
                CompetitionSolutionDao dao = new CompetitionSolutionDao();
                dao.submitCompetitionSolution(competitionsolution);
                
                   //submit test case results
                      
                      CompetitionTestCaseResultDao competitiontestcaseresultdao = new CompetitionTestCaseResultDao();
                      List<CompetitionTestCaseResult> competitiontestcaseresultlist= competitiontestcaseresultdao.listCompetitionTestCaseResultByCompetitionSolutionId(competitionsolution.getId());

                      TestCaseDao testcasedao = new TestCaseDao();
                      List<TestCase> testcaselist= testcasedao.listTestCaseByProblemId(problem_id);

                      while(competitiontestcaseresultlist.size() < testcaselist.size()){
                          Thread.sleep(3000);
                          competitiontestcaseresultlist= competitiontestcaseresultdao.listCompetitionTestCaseResultByCompetitionSolutionId(competitionsolution.getId());
                      };
                      
                       String [] testcasesymbol = {"right","wrong"};
                      for(int i =0;i<competitiontestcaseresultlist.size();i++){
                          int j =i+1;
                            out.print("test case "+j+" :"+testcasesymbol[competitiontestcaseresultlist.get(i).getPassed()]+"<br>");
                               

                      }
                      
                        competitionsolution =  dao.getCompetitionSolutionByTeamIdAndProblemIdAndCompetitionId(team_id, problem_id, competition_id);
                     if (competitionsolution.getStatus() == 2){
                     out.print("Compilation error :" + competitionsolution.getError());
                     }else if(competitionsolution.getStatus() == 0){
                         out.print("Not compiled");
                     }
                      
                     
                     
                   //for scoring points 
                     //getting the model first
                      CompetitionPoints competition_points = new CompetitionPoints();
                     competition_points.setTeamId(team_id);
                     competition_points.setProblemId(problem_id);
                     competition_points.setCompetitionId(competition_id);
                     
                      boolean test_case_passed = true;
                     for(int i =0;i<competitiontestcaseresultlist.size();i++){
                         if(competitiontestcaseresultlist.get(i).getPassed() == 1){
                         test_case_passed = false;
                       }        
                     }
                     
                     // if test case tests passed and points wasn't given 
                     CompetitonPointsDao competition_points_dao = new CompetitonPointsDao();

                      if(test_case_passed && !competition_points_dao.gotpoints(competition_points)){
                         competition_points_dao.givePoints(competition_points);
                         //give points
                         ProblemDao problem_dao = new ProblemDao();
                         int points = problem_dao.getProblemById(problem_id).getPoints();
                         
                         CompetitionDao competition_dao = new CompetitionDao();
                         int score = competition_dao.getTeamScore(team_id, competition_id);
                         int new_score = score+points;
                         competition_dao.updateScore(new_score,team_id,competition_id);
                         out.print("new score: "+new_score+" | "+"score: "+score+" | "+"points : "+points);
                     }
		
            }
    %>