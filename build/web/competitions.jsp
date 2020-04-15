<%-- 
    Document   : competitons
    Created on : Mar 11, 2018, 10:07:23 PM
    Author     : mahmoud
--%>

<%@page import="com.olc.model.Competition"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.olc.dao.CompetitionDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>competitions</title>
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
                  
              //TODO:: if leader == 1 display join

            CompetitionDao dao = new CompetitionDao();
           
            // list all upcoming competitions
            List<Competition> competitions = dao.listUpcomingCompetitions();
            
            int team_id = (Integer) session.getAttribute("team_id");
            // get all joined competitions by team id
            List<Integer> competition_ids = dao.getCompetitionIdByTeamId(team_id);
            // modify for unjoind list of competition
            ArrayList<Competition> registerd_competitions = new ArrayList<Competition>();
            
            for(int i=0;i<competitions.size();i++){
                for(int j =0;j<competition_ids.size();j++){
                    if(competitions.get(i).getId() == competition_ids.get(j)  ){
                        registerd_competitions.add( competitions.get(i));
                        
                       competitions.remove(i);
                       //break loop cause if it's the only remaining competition
                       //and it's removed outOfBound Exception will fire
                       break;
                    }
                
                }
            }
            
           
            request.setAttribute("competitions",competitions);
            request.setAttribute("registerd_competitions",registerd_competitions);

            //running compets
            request.setAttribute("running_competitions",dao.listRunningCompetitions(team_id));
        %>
        <% 
              if(request.getParameter("submit") != null){
                  
                  if(request.getParameter("submit").equals("join")){
                  out.print(request.getParameter("submit"));
                 int competition_id = Integer.parseInt(request.getParameter("competition_id"));
                 dao.acceptCompetition(team_id,competition_id);
                  response.sendRedirect("competitions.jsp");
                    return;
                  }
                        
              }

        %>
        
      
      

        <div class="container">
                            <jsp:include page="navbar.jsp" />
                            <hr>
                            <br>

        <% if((Integer) session.getAttribute("role") == 2 || (Integer) session.getAttribute("role") == 1) {%>
      
        <a href="create_competition.jsp">create a competition <i class="fas fa-plus"></i></a>
        <% } %>
        <table class="table table-striped table-hover" >
            <thead>
                <tr>
                    <th>competition name</th>
                    <th>start</th>
                    <th>end</th>

                </tr>
            </thead>
            <tbody>
            <% if((Integer)session.getAttribute("leader") == 1){%>     
            <c:forEach items="${competitions}" var="competition"> 
               <tr>
                    <td><c:out value= "${competition.getName()}"/></td>        
                    <td><c:out value= "${competition.getStartDate()}"/></td>
                    <td><c:out value= "${competition.getEndDate()}"/></td>
                    
                    <td> 
                        <form action="competitions.jsp" method="post">
                        <input type="hidden" name="competition_id" value=<c:out value= "${competition.getId()}"/>>    
                        <input type="submit" name="submit" class="btn btn-primary" value="join"/>
                        </form>
                    </td>
                 
                 
                </tr>
            </c:forEach>
                <%}%>
             <c:forEach items="${registerd_competitions}" var="competition"> 
               <tr>
                    <td><c:out value= "${competition.getName()}"/></td>        
                    <td><c:out value= "${competition.getStartDate()}"/></td>
                    <td><c:out value= "${competition.getEndDate()}"/></td>
                    
                    <td> 
                        joind
                    </td>
                 
                 
                </tr>
            </c:forEach>    
              <c:forEach items="${running_competitions}" var="competition"> 
               <tr>
                    <td><c:out value= "${competition.getName()}"/></td>        
                    <td><c:out value= "${competition.getStartDate()}"/></td>
                    <td><c:out value= "${competition.getEndDate()}"/></td>
                    
                    <td> 
                        <a href="competition.jsp?competition_id=${competition.getId()}">solve</a>
                    </td>
                 
                 
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
