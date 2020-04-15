<%-- 
    Document   : validate_problem
    Created on : Mar 12, 2018, 5:41:07 PM
    Author     : mahmoud
--%>

<%@page import="com.olc.model.TestCase"%>
<%@page import="com.olc.model.Problem"%>
<%@page import="com.olc.dao.ProblemDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>validate problem</title>
         <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
          <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
                          <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/font-awesome/css/all.css">

    </head>
    <body>

        <%
                  if (session.getAttribute("username")==null)
	{
		
			response.sendRedirect("login.jsp");
               return;
                 
	}
        else{
           if ((Integer) session.getAttribute("role") != 3 &&  (Integer) session.getAttribute("role") != 1 ){
                     response.sendRedirect("welcome.jsp");
                }
                
        }
                  
        int problem_id = Integer.parseInt(request.getParameter("problem_id"));
        ProblemDao dao = new ProblemDao();
        //set problem to be used 
        Problem rawproblem = dao.getProblemById(problem_id);
       request.setAttribute("problem",rawproblem);
       request.setAttribute("testcases",rawproblem.getTestCaseList());

        %>

        <%
              
         if(request.getParameter("submit") != null)
            {
                problem_id = Integer.parseInt(request.getParameter("problem_id"));
                String title = request.getParameter("title");
                
                if(dao.validateValidation(title,problem_id)){
                 out.print("<p style='color: red'>problem title is already taken</p>");
                 return;
                }else{
                String description=request.getParameter("description");
               
                String sample_input=request.getParameter("sample_input");
                String sample_output=request.getParameter("sample_output");
                String complexity=request.getParameter("complexity");
                 String c_code=request.getParameter("c_code");
            String java_code=request.getParameter("java_code");
            String cplus_code=request.getParameter("cplus_code");
                int scope=Integer.parseInt(request.getParameter("scope"));
                
                int points=Integer.parseInt(request.getParameter("points"));
                
                String[] test_case_id = request.getParameterValues("test_case_id");

                
                int validated = 1;
                //get test cases data
                 String[] case_input = request.getParameterValues("case_input[]");
                 String[] case_output = request.getParameterValues("case_output[]");
            
                   Problem problem = new Problem();
                   problem.setId(problem_id);
                   problem.setTitle(title);
                   problem.setDescription(description);
                  
                   problem.setSampleInput(sample_input);
                   problem.setSampleOutput(sample_output);
                   problem.setValidated(validated);
                   problem.setComplexity(complexity);
                    problem.setCCode(c_code);
                   problem.setJavaCode(java_code);
                   problem.setCplusCode(cplus_code);

                   problem.setScope(scope);
                   problem.setPoints(points);
                   for(int i=0;i<case_input.length;i++){
                       //set test cases
                       
                       TestCase testcase = new TestCase();
                       testcase.setId(Integer.parseInt(test_case_id[i]));
                       
                       
                       testcase.setInput(case_input[i]);
                       
                       
                       testcase.setOutput(case_output[i]);
                       
                       
                       testcase.setProblemId(problem_id);
                       
                       //add them to problem list
                       problem.setTestCaseList(testcase);
                                  
                    }
                   
                    dao.updateProblem(problem);
                    
             
                        
                       response.sendRedirect("validate_problems.jsp");
                       return;
                
                }
            
            }    
        
        %>        
        <div class="container">  
                                    <jsp:include page="navbar.jsp" />

            
         <form action="validate_problem.jsp" method="POST">
                <div class="form-group">
          <label>Problem title:</label>
         <input class="form-control input-lg"  type="text" name="title" value="${problem.getTitle()}" size="50" required />
         </div>
            <div class="form-group">
            <label>Problem description:</label>
         <textarea  class="form-control input-lg"  name="description" rows="4" cols="20" required>${problem.getDescription()}</textarea>
            </div>
            
            <div class="form-group">
          <label>sample input:</label>
         <input class="form-control input-lg"  type="text" name="sample_input" value="${problem.getSampleInput()}" size="50" required />
         </div>
            <div class="form-group">
          <label>sample output:</label>
         <input  class="form-control input-lg" type="text" name="sample_output" value="${problem.getSampleOutput()}" size="50" required />
         </div>
         
          <div id="test_cases">
          <c:set var="count" value="1" scope="page" />

          <c:forEach items="${testcases}" var="testcase">
              test case <c:out value="${count}" /> :
                <div class="form-group">
               <label>case input</label>
             <input  class="form-control input-lg" type="text" name="case_input[]" value="${testcase.getInput()}" size="50" required />
             </div>
                    <div class="form-group">
             <input class="form-control input-lg"  type="hidden" name="test_case_id" value="${testcase.getId()}" />
              <label>case output</label>
                    </div>
                 <div class="form-group">
              <input  class="form-control input-lg" type="text" name="case_output[]" value="${testcase.getOutput()}" size="50" required />
              </div>
              <c:set var="count" value="${count + 1}" scope="page"/>
            </c:forEach>
            </div>
          <label>complexity</label>
          <select name="complexity" required class="custom-select">
              <option value="easy">easy</option>
              <option value="medium">medium</option>
              <option value="hard">hard</option>
              
          </select>
             
                         <div class="form-group">
          <label>C Code</label>
         <textarea  class="form-control input-lg" name="c_code" rows="4" cols="20"  required >${problem.getCCode()}</textarea>
         <label>Java Code</label>
         <textarea  class="form-control input-lg" name="java_code" rows="4" cols="20"  required >${problem.getJavaCode()}</textarea>
          <label>C++ Code</label>
         <textarea  class="form-control input-lg" name="cplus_code" rows="4" cols="20"  required >${problem.getCplusCode()}</textarea>
          
             </div>
            
          <select name="scope" required class="custom-select">
              <option value="0">public</option>
              <option value="1">private</option>
              
           </select>
           <div class="form-group">
               <label>points</label>     
          <input  class="form-control input-lg" type="text" name="points" value="" required />
           </div>
          <input type="hidden" name="problem_id" value="<%= problem_id %>" />
                <input class="btn btn-block btn-lg btn-primary" type="submit" value="submit" name="submit" />
        </form>
                
                 <form method="post" action="logout.jsp"  class="">
                    <button type="submit" value="Logout"  class="btn btn-danger" >logout</button>
                </form>
        
        </div>
    </body>
</html>
