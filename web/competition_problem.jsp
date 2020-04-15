<%-- 
    Document   : competition_problem
    Created on : Mar 24, 2018, 10:58:41 PM
    Author     : mahmoud
--%>

<%@page import="com.olc.model.CompetitionTestCaseResult"%>
<%@page import="java.util.List"%>
<%@page import="com.olc.model.CompetitionSolution"%>
<%@page import="com.olc.dao.CompetitionSolutionDao"%>
<%@page import="com.olc.model.Problem"%>
<%@page import="com.olc.dao.ProblemDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
                  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/font-awesome/css/all.css">

         <% 
             //session
           if (session.getAttribute("username")==null)
	{
			response.sendRedirect("login.jsp");
                        return;
                
	}
             
                  
            int problem_id=Integer.parseInt(request.getParameter("problem_id"));
            int competition_id=Integer.parseInt(request.getParameter("competition_id"));
            int team_id = (Integer) session.getAttribute("team_id");

            ProblemDao problem_dao = new ProblemDao();
            Problem problem = problem_dao.getProblemById(problem_id);
            

            CompetitionSolutionDao competitionsolutiondao = new CompetitionSolutionDao();
            CompetitionSolution competitionsolution = competitionsolutiondao.getCompetitionSolutionByTeamIdAndProblemIdAndCompetitionId(team_id,problem_id,competition_id);
            List<CompetitionTestCaseResult> competitiontestcaseresultlist = competitionsolution.getCompetitionTestCaseResultList();
            
             String [] testcasesymbol = {"right","wrong"};
            %>
                <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/submit.css">
            <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/codemirror/lib/codemirror.css">
          <script type="text/javascript" src="${pageContext.request.contextPath}/codemirror/lib/codemirror.js"></script>
            <!--for mode-->
            <script type="text/javascript" src="${pageContext.request.contextPath}/codemirror/mode/clike/clike.js"></script>
          
            <!--for hinting-->
            <script type="text/javascript" src="${pageContext.request.contextPath}/codemirror/addon/hint/show-hint.js"></script>
            <script type="text/javascript" src="${pageContext.request.contextPath}/codemirror/addon/hint/css-hint.js"></script>
            <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/codemirror/addon/hint/show-hint.css">
     <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
          <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
       
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= problem.getTitle()%></title>
    </head>
    <body>
        <div class="container">
         <jsp:include page="navbar.jsp" />
         <hr>

         <h3><%= problem.getTitle()%></h3>  
        
            <p><%= problem.getDescription() %></p>
          
            
             Sample input :
            <p><%= problem.getSampleInput()%></p>
            
                Sample output :
            <p><%= problem.getSampleOutput()%></p>
            
                <div id="result" style="background: #eee;">
                <%
                for(int i =0; i<competitiontestcaseresultlist.size();i++){
                    out.print("test case "+(i+1)+" :");
                    out.print(testcasesymbol[competitiontestcaseresultlist.get(i).getPassed()]+"<br>");
                }
                if(competitionsolution.getStatus() == 2){
                    out.print("compilation error : "+ competitionsolution.getError());
                }
                 %>
            </div>
            
            <form action="competition_submit.jsp" method="POST" id="ajax">
                
                <select name="language" onchange="selectLanguage()" id="select_language">
                       <option title="text/x-csrc" value="1">c</option>
                       <option title="text/x-java" value="2">java</option>
                       <option title="text/x-c++src" value="3">c++</option>

                </select>
                <textarea name="code" rows="20" cols="150" id="codemirror-textarea"><%
                        if(competitionsolution.getCode() != null){
                            out.print(competitionsolution.getCode());
                        }else{
                            out.print(problem.getCCode());

                        }
                        %></textarea>
              <input type="hidden" name="problem_id" value="<%= problem_id%>" />
              <input type="hidden" name="competition_id" value="<%= competition_id%>" />

                <input type="hidden" name="team_id" value="<%= session.getAttribute("team_id")%>" />

            <input type="submit" name="submit" value="submit" />
              </form>
            
              
               
           </div>
    
          <script type="text/javascript">
    
  var editor = CodeMirror.fromTextArea(document.getElementById("codemirror-textarea"), {
    lineNumbers: true,
    styleActiveLine: true,
    matchBrackets: true,
    extraKeys: {"Ctrl-Space": "autocomplete"},
    mode:"text/x-csrc"
  });
   var input = document.getElementById("select_language");


       
     function selectLanguage() {
       var mode = input.options[input.selectedIndex].title;
       var lang = input.options[input.selectedIndex].value;
       var definedLanguage = "<%=competitionsolution.getLanguageId() %>";
       
       if(lang ==definedLanguage ){
            var value = `<%=competitionsolution.getCode() %>`;

       }else{
                    if(lang==1){
                    var value = `<%=problem.getCCode() %>`;
                   }else if(lang==2){
                        var value = `<%=problem.getJavaCode() %>`;

                   }else if(lang ==3){
                         var value = `<%=problem.getCplusCode() %>`;

                   }
            }
   

       editor.setOption("mode", mode);

           editor.setValue(value);
  }
  
             </script>
             
             <script type="text/javascript">
                     
                     $( document ).ready(function() {
                     
        $("#select_language option[value=<%=competitionsolution.getLanguageId()%>]").prop("selected", true)

    
                    });
             </script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ajax/submit.js"></script>
    </body>
</html>
