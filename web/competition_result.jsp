<%-- 
    Document   : competition_result
    Created on : May 11, 2018, 2:35:34 PM
    Author     : mahmoud
--%>

<%@page import="com.olc.model.TeamCompetition"%>
<%@page import="java.util.List"%>
<%@page import="com.olc.dao.CompetitionDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>

<%
  
             //session
                  if (session.getAttribute("username")==null)
	{
		  response.sendRedirect("login.jsp");
                  return;
                
	}else{
          
               if ((Integer) session.getAttribute("role") != 2&&  (Integer) session.getAttribute("role") != 1 ){
                     response.sendRedirect("welcome.jsp");
                     return;
                }
        }
        
         int user_id =  (Integer)session.getAttribute("user_id");
         int competition_id =  Integer.parseInt(request.getParameter("competition_id"));

        
        CompetitionDao dao = new CompetitionDao();
        // if user not authorized or not created the competition
        int query = dao.queryCreatedCompetitionByUserIdAndCompetitionId(user_id, competition_id);
        if(query == 0 ){
             response.sendRedirect("welcome.jsp");
             return;
        }
        List<TeamCompetition> teams= dao.getCompetitionTeamScoreOrdered(competition_id);
        request.setAttribute("teams",teams);
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>competition <%=competition_id%> result</title>
           <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
          <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
                  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/font-awesome/css/all.css">

    </head>
    <body>
<div class="container">  
                    <jsp:include page="navbar.jsp" />

       <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>team name</th>
                    <th>score</th>
                    <th>rank</th>

                   
                

                </tr>
            </thead>
            <tbody>    
            <c:forEach items="${teams}" var="team"> 
               <tr>
                      
                    <td><c:out value= "${team.getTeamName()}"/></td>
                    <td><c:out value= "${team.getScore()}"/></td>   
                    <td><c:out value= "${team.getRank()}"/></td>    

                 
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
