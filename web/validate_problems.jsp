<%-- 
    Document   : validate_problem
    Created on : Mar 12, 2018, 5:26:21 PM
    Author     : mahmoud
--%>

<%@page import="com.olc.dao.ProblemDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>validate a problem</title>
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
                  
            ProblemDao dao = new ProblemDao();
            request.setAttribute("problems",dao.listUnValidatedProblems());
            
        %>
<div class="container">
                    <jsp:include page="navbar.jsp" />

         <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>problem title</th>
                    
                </tr>
            </thead>
            <tbody>
                
            <c:forEach items="${problems}" var="problem"> 
               <tr>
                   <td><a href="validate_problem.jsp?problem_id=${problem.getId()}"><c:out value= "${problem.getTitle()}"/></a></td>        
 
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
