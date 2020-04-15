<%-- 
    Document   : competition_results
    Created on : May 11, 2018, 2:19:21 PM
    Author     : mahmoud
--%>

<%@page import="com.olc.model.Competition"%>
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
                
	}
        else{
          
               if ((Integer) session.getAttribute("role") != 2&&  (Integer) session.getAttribute("role") != 1 ){
                     response.sendRedirect("welcome.jsp");
                }
        }
                  
        int user_id =  (Integer)session.getAttribute("user_id");
        
        CompetitionDao dao = new CompetitionDao();
        List<Competition> competitions = dao.getCreatedCompetitionsByUserId(user_id);
        request.setAttribute("competitions",competitions);

%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>competition results</title>
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
                    <th>competition name</th>
                    <th>start</th>
                    <th>end</th>
                    <th>result</th>

                </tr>
            </thead>
            <tbody>    
            <c:forEach items="${competitions}" var="competition"> 
               <tr>
                    <td><c:out value= "${competition.getName()}"/></td>        
                    <td><c:out value= "${competition.getStartDate()}"/></td>
                    <td><c:out value= "${competition.getEndDate()}"/></td>
                    
                    <td> 
                        <form action="competition_result.jsp" method="post">
                        <input type="hidden" name="competition_id" value=<c:out value= "${competition.getId()}"/>>    
                        <input class="btn btn-primary" type="submit" name="submit" value="result"/>
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
