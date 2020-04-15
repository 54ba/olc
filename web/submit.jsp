<%-- 
    Document   : submit
    Created on : Apr 8, 2018, 8:03:27 PM
    Author     : mahmoud
--%>


<%@page import="com.olc.dao.UserDao"%>
<%@page import="com.olc.dao.ProblemDao"%>
<%@page import="com.olc.dao.ProblemPointsDao"%>
<%@page import="com.olc.model.ProblemPoints"%>
<%@page import="com.olc.model.TestCase"%>
<%@page import="com.olc.dao.TestCaseDao"%>
<%@page import="com.olc.model.TestCaseResult"%>
<%@page import="java.util.List"%>
<%@page import="com.olc.dao.TestCaseResultDao"%>
<%@page import="com.olc.dao.SolutionDao"%>
<%@page import="com.olc.model.Solution"%>
<%
    if(request.getParameter("submit") != null)
            {
                String code=request.getParameter("code");
		int problem_id =Integer.parseInt(request.getParameter("problem_id"));
		int user_id =Integer.parseInt(request.getParameter("user_id"));
               	int language_id =Integer.parseInt(request.getParameter("language"));
                
                Solution solution = new Solution();
                solution.setLanguageId(language_id);
                solution.setProblemId(problem_id);
                solution.setUserId(user_id);
                solution.setCode(code);
                
                SolutionDao dao = new SolutionDao();
                dao.submitSolution(solution);
                
                   //submit test case results
                      
                      TestCaseResultDao testcaseresultdao = new TestCaseResultDao();
                      List<TestCaseResult> testcaseresultlist= testcaseresultdao.listTestCaseResultBysolutionId(solution.getId());

                      TestCaseDao testcasedao = new TestCaseDao();
                      List<TestCase> testcaselist= testcasedao.listTestCaseByProblemId(problem_id);

                      while(testcaseresultlist.size() < testcaselist.size()){
                         

                          Thread.sleep(3000);
                          testcaseresultlist= testcaseresultdao.listTestCaseResultBysolutionId(solution.getId());
                      };
                      
                       String [] testcasesymbol = {"right","wrong"};
                      for(int i =0;i<testcaseresultlist.size();i++){
                          int j =i+1;
                            out.print("test case "+j+" :"+testcasesymbol[testcaseresultlist.get(i).getPassed()]+"<br>");
                               

                      }
                      
                     solution =  dao.getSolutionByUserAndProblemId(user_id, problem_id);
                     if (solution.getStatus() == 2){
                     out.print("Compilation error :" + solution.getError());
                     }else if(solution.getStatus() == 0){
                         out.print("Not compiled" );
                     }
                     //for scoring points 
                     //getting the model first
                     ProblemPoints problem_points = new ProblemPoints();
                     problem_points.setUserId(user_id);
                     problem_points.setProblemId(problem_id);
                     
                     boolean test_case_passed = true;
                     for(int i =0;i<testcaseresultlist.size();i++){
                         if(testcaseresultlist.get(i).getPassed() == 1){
                         test_case_passed = false;
                       }        
                     }
                     // if test case tests passed and points wasn't given 
                     ProblemPointsDao problem_points_dao = new ProblemPointsDao();
                     if(test_case_passed && !problem_points_dao.gotpoints(problem_points)){
                         problem_points_dao.givePoints(problem_points);
                         //give points
                         ProblemDao problem_dao = new ProblemDao();
                         int points = problem_dao.getProblemById(problem_id).getPoints();
                         UserDao user_dao = new UserDao();
                         int score = user_dao.getUserById(user_id).getScore();
                         int new_score = score+points;
                         user_dao.updateScore(new_score,user_id);
                         //update session score
                         session.setAttribute("score",new_score);
                     }
                  
            }
    %>