<%-- 
    Document   : navbar
    Created on : Jun 22, 2018, 3:23:11 PM
    Author     : mahmoud
--%>
 <a href="teams.jsp">teams <i class="fas fa-users"></i></a>
 
 | <a href="competitions.jsp">competitions <i class="fas fa-trophy"></i></a>
                | <a href="problems.jsp"> problems <i class="fas fa-tasks"></i></a>
                <% if ((Integer) session.getAttribute("role") == 1  ){%>
                |<a href="admin.jsp"> admin page <i class="fas fa-user-secret"></i></a>
                <%}%>
                <% if ((Integer) session.getAttribute("role") == 1 ||(Integer) session.getAttribute("role") == 3 ){%>
                |<a href="validate_problems.jsp"> validate problems <i class="fas fa-check"></i></a>
                <%}%>
                <% if ((Integer) session.getAttribute("role") == 1 ||(Integer) session.getAttribute("role") == 2 ){%>
                |<a href="create_competition.jsp"> create competition <i class="fas fa-plus"></i></a>
                <%}%>
                 <% if ((Integer) session.getAttribute("role") == 1 ||(Integer) session.getAttribute("role") == 2 ){%>
                |<a href="competition_results.jsp"> competition results <i class="far fa-list-alt"></i></a>
                <%}%>
             