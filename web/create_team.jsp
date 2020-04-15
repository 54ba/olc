<%-- 
    Document   : create_team
    Created on : Mar 9, 2018, 3:44:09 PM
    Author     : mahmoud
--%>

<%@page import="com.olc.model.Team"%>
<%@page import="com.olc.dao.TeamDao"%>
<%@page import="com.olc.util.DbUtil"%>
<%@page import="com.olc.dao.UserDao"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>create a team</title>
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
            
                String name=request.getParameter("name");
		int leader =Integer.parseInt(request.getParameter("leader"));
                
                TeamDao dao = new TeamDao();
                //if team name exist
                if(dao.validateTeam(name)){
                out.print("<p style='color: red'>team name is already taken</p>");
                return;
                //if team name doesn't exist
                }else{
                    
                   String[] submitted_users = request.getParameterValues("submitted_users"); 

                      Team team = new Team();
                      team.setName(name);
                      team.setLeader(leader);
                      dao.createTeam(team);
                      int team_id =team.getId();
                     
                      if(submitted_users!=null){
                    
                         for(int i=0;i<submitted_users.length;i++){
                        dao.createUserTeam(Integer.parseInt(submitted_users[i]),team_id);
                        
                        }
                         //modify session team id 
                         session.setAttribute("team_id",team.getId());
                        response.sendRedirect("teams.jsp");
                        return;
                    }
                }
            }
              
        %>
        
        <% 
            UserDao dao = new UserDao();
            request.setAttribute("users", dao.listUsernameAndId());
            request.setAttribute("session_user_id",session.getAttribute("user_id"));
            
     
      %>
    
 <div class="container">   
                     <jsp:include page="navbar.jsp" />

   <form action="create_team.jsp" method="POST">
 <div class="form-group">
        <label>Team Name:</label>
         <input class="form-control input-lg" type="text" name="name" value="" size="50" required />
         </div>
       
         <input type="hidden" name="leader" value="<%= session.getAttribute("user_id")%>" size="50" required />
         <div class="form-group">
         <label>choose users press CTRL for multiple choise</label>
          
        <select name="submitted_users" multiple="multiple"  size="12" required class="custom-select" >
            <c:forEach items="${users}" var="user">
              <c:if test="${session_user_id != user.getId()}">  

                <option value=<c:out value= "${user.getId()}" />><c:out value= "${user.getUsername()}"/></option>
              
              </c:if>  

            </c:forEach>
        </select>
        </div>
        <input class="btn btn-block btn-lg btn-primary" type="submit" value="submit" name="submit" />

   </form>      
        
         <form method="post" action="logout.jsp"  class="">
                    <button type="submit" value="Logout"  class="btn btn-danger" >logout</button>
                </form>
        
 </div>   
 </body>
    
</html>
