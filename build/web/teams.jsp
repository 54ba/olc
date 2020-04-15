<%-- 
    Document   : teams
    Created on : Mar 9, 2018, 3:43:15 PM
    Author     : mahmoud
--%>

<%@page import="com.olc.dao.TeamDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Teams</title>
            <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
          <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
                          <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/font-awesome/css/all.css">

    </head>
    <body>
        <div class="container">
                            <jsp:include page="navbar.jsp" />
                            <hr>
                            <br>

        <%
             if (session.getAttribute("username")==null)
	{
		
			response.sendRedirect("login.jsp");     
                        return;
	}
      
            // team id != 1
            
         if( (Integer) session.getAttribute("team_id") != 1){
             out.print("your are in a team ");
        %>
             <a  href = "competitions.jsp" >head to competitions  </a>
             <% return;
         }    
        
        %>
        
        <% //print create team if not in a team
            if( (Integer) session.getAttribute("team_id") == 1){ %>
        <a href="create_team.jsp">Create a team </a><%}%>          

        <% 
            TeamDao dao = new TeamDao();
            int user_id = (Integer) session.getAttribute("user_id");
            request.setAttribute("teams",dao.getUserTeam(user_id));
            
        %>
        
        <% 
              if(request.getParameter("submit") != null){
                 int team_id = Integer.parseInt(request.getParameter("team_id"));
                 dao.acceptTeam(user_id,team_id);
                 //modify session after accepting team
                 session.setAttribute("team_id", team_id);
                 
                  response.sendRedirect("teams.jsp");
                    return;
                        
              }
        %>
      
        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>team name</th>
                    <th>users</th>

                </tr>
            </thead>
            <tbody>
                
            <c:forEach items="${teams}" var="team"> 
               <tr>
                    <td><c:out value= "${team.getName()}"/></td>        
                    <td>
                        <ol type="1">
                        <c:forEach items="${team.getUserList()}" var="user">   
                            
                                <li><c:out value= "${user.getName()}"/></li>
                           

                        </c:forEach>
                        </ol>
                    </td>

                    <td> 
                        <form action="teams.jsp" method="post">
                        <input type="hidden" name="team_id" value= <c:out value= "${team.getId()}"/>>    
                        <input type="submit" name="submit" class="btn btn-primary" value="accept">
                        </form>
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
