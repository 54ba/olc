<%-- 
    Document   : competition
    Created on : Mar 17, 2018, 8:55:04 PM
    Author     : mahmoud
--%>

<%@page import="com.olc.dao.TeamDao"%>
<%@page import="com.olc.dao.CompetitionDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>competition</title>
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
        
             
        int competition_id = Integer.parseInt(request.getParameter("competition_id"));
        int team_id = (Integer) session.getAttribute("team_id");

        CompetitionDao dao = new CompetitionDao();
        int subscribed_teams =dao.getCompetitionTeamsNum(competition_id);
        
        if(subscribed_teams > 2) {
            out.print("sorry competition has only 1 team,try joining another one");
            return;    
        }
        request.setAttribute("problems",dao.listCompetitionProblems(competition_id));
        TeamDao team_dao = new TeamDao();
       
        int team_score = team_dao.getTeamScore(team_id, competition_id);
    %>
    
   <div class="container">
    <div>team score: <%=team_score%></div>
    <br>
                    <jsp:include page="navbar.jsp" />

        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>problem title</th>
                    <th>complexity</th>
                    <th>points</th>
                    
                </tr>
            </thead>
            <tbody>
                
            <c:forEach items="${problems}" var="problem"> 
               <tr>
                   <td><a href="competition_problem.jsp?problem_id=${problem.getId()}&competition_id=<%=competition_id%>"><c:out value= "${problem.getTitle()}"/></a></td>  
                   <td><c:out value= "${problem.getComplexity()}"/></td>        
                   <td><c:out value= "${problem.getPoints()}"/></td>        

                </tr>
            </c:forEach>
               
            </tbody>
        </table>
         <form method="post" action="logout.jsp"  class="">
                    <button type="submit" value="Logout"  class="btn btn-danger" >logout</button>
                </form>
        </div>      
    </body>
</html>
