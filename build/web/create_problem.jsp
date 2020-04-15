<%-- 
    Document   : create_problem
    Created on : Mar 11, 2018, 5:47:04 PM
    Author     : mahmoud
--%>

<%@page import="com.olc.model.TestCase"%>
<%@page import="com.olc.dao.ProblemDao"%>
<%@page import="com.olc.model.Problem"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create a problem</title>
           <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
          <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
                          <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/font-awesome/css/all.css">

    </head>
    <body>
        
        <%
               //session
             if (session.getAttribute("username")==null)
	{
		 response.sendRedirect("login.jsp");
                 return;
	}
      
          if(request.getParameter("submit") != null)
            {
            //get input data
            String title=request.getParameter("title");
            String description=request.getParameter("description");
            String sample_input=request.getParameter("sample_input");
            String sample_output=request.getParameter("sample_output");
            String c_code=request.getParameter("c_code");
            String java_code=request.getParameter("java_code");
            String cplus_code=request.getParameter("cplus_code");

            int validated = 0;
            //get test cases data
            String[] case_input = request.getParameterValues("case_input[]");
            String[] case_output = request.getParameterValues("case_output[]");
            
          
            ProblemDao dao = new ProblemDao();
            
             if(dao.validateProblem(title)){
                out.print("<p style='color: red'>problem title is already taken</p>");
                return;
                //if problem title doesn't exist
                }else{
                   Problem problem = new Problem();
                   problem.setTitle(title);
                   problem.setDescription(description);
                   problem.setSampleInput(sample_input);
                   problem.setSampleOutput(sample_output);
                   problem.setValidated(validated);
                   problem.setCCode(c_code);
                   problem.setJavaCode(java_code);
                   problem.setCplusCode(cplus_code);
                   
                   
                   for(int i=0;i<case_input.length;i++){
                       //set test cases
                       TestCase testcase = new TestCase();
                       testcase.setInput(case_input[i]);
                       testcase.setOutput(case_output[i]);
                       //add them to problem list
                       problem.setTestCaseList(testcase);
                                  
                    }
                   dao.createProblem(problem);
             
                        
                        response.sendRedirect("problems.jsp");
                        return;
                }
                         
                   
            
            }
        %>
        <div class="container">
                            <jsp:include page="navbar.jsp" />

            <h3 class="text-center">create a problem</h3>
        <form action="create_problem.jsp" method="POST">
             <div class="form-group">
          <label>Problem title:</label>
         <input class="form-control input-lg"  type="text" name="title" value="" size="50" required />
             </div>
            
             <div class="form-group">
            <label>Problem description:</label>
         <textarea  class="form-control input-lg" name="description" rows="4" cols="20"  required ></textarea>
             </div>
           
             <div class="form-group">
          <label>sample input:</label>
         <input class="form-control input-lg"  type="text" name="sample_input" value="" size="50" required />
             </div>
             <div class="form-group">
          <label>sample output:</label>
         <input  class="form-control input-lg" type="text" name="sample_output" value="" size="50" required />
             </div>
            
                         <div class="form-group">
          <label>C Code</label>
         <textarea  class="form-control input-lg" name="c_code" rows="4" cols="20"  required ></textarea>
         <label>Java Code</label>
         <textarea  class="form-control input-lg" name="java_code" rows="4" cols="20"  required ></textarea>
          <label>C++ Code</label>
         <textarea  class="form-control input-lg" name="cplus_code" rows="4" cols="20"  required ></textarea>
          
             </div>
            
         test cases:
         
         <div id="test_cases">
         
             <div>
         Test case 1:
              <div class="form-group">
             <label>case input</label>
             <input class="form-control input-lg"  type="text" name="case_input[]" value="" size="50" required />
             </div>
                 
               <div class="form-group">
              <label>case output</label>
              <input  class="form-control input-lg" type="text" name="case_output[]" value="" size="50" required />
               </div>
                  
             </div>  
                 
            </div>
        <input class="btn btn-primary btn-block btn-lg" type="submit" value="submit" name="submit" />
        </form>
        
         <input class="btn btn-success btn-block btn-lg" type="button" value="Add another test case" onClick="addTestCase('test_cases');">

        <script  language="Javascript" type="text/javascript">
       var counter = 1;

function addTestCase(divName){
    
          var newdiv = document.createElement('div');
          newdiv.innerHTML = "Test case " + (counter + 1) + ":  <div class='form-group'> <label>case input</label><input  class='form-control input-lg' type='text' name='case_input[]' size='50'required /></div>"+
                  "<div class='form-group'><label>case output</label>"+
              "<input  class='form-control input-lg'  type='text' name='case_output[]'  size='50' required /></div>";
          document.getElementById(divName).appendChild(newdiv);
          counter++;
     
}
        </script>
  <form method="post" action="logout.jsp"  class="">
                    <button type="submit" value="Logout"  class="btn btn-danger" >logout</button>
                </form>
        </div>  
    </body>
</html>
