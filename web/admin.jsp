<%-- 
    Document   : admin.jsp
    Created on : Mar 22, 2018, 8:05:39 PM
    Author     : mahmoud
--%>
<%@page import="com.olc.dao.UserDao"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin</title>
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
        else{
          
             if ((Integer) session.getAttribute("role") != 1 ){
                     response.sendRedirect("welcome.jsp");
                }
        }
             
            UserDao dao = new UserDao();
            request.setAttribute("users", dao.listUsernameAndId());
            request.setAttribute("session_user_id",session.getAttribute("user_id"));
            
     
      %>
      
               <% 
              if(request.getParameter("submit") != null)
            {
            
                    
                   String[] submitted_users = request.getParameterValues("submitted_users");
                   String role = request.getParameter("role");

                   
                      if(submitted_users!=null){
                    
                         for(int i=0;i<submitted_users.length;i++){
                        dao.editPrivillage(Integer.parseInt(submitted_users[i]),Integer.parseInt(role));
                        
                        }

                        response.sendRedirect("admin.jsp");
                        return;
                }
            }
              
        %>
        
        <div class="container">   
                            <jsp:include page="navbar.jsp" />
                            <hr>  
                            <br>  

        <form action="admin.jsp" method="POST">
            <label>choose users press CTRL for multiple choise</label>
          <br>
        <select name="submitted_users" multiple="multiple"  size="12" required  class="custom-select"  >
            <c:forEach items="${users}" var="user">
              <c:if test="${session_user_id != user.getId()}">  

                <option value=<c:out value= "${user.getId()}" />><c:out value= "${user.getUsername()}"/></option>
              
              </c:if>  

            </c:forEach>
        </select>
        <br>
        <label>choose privillage</label>
        <br>

        <select name="role"  class="custom-select" >
            <option value="0">user</option>
            <option value="1">admin</option>
            <option value="2">competition creator</option>
            <option value="3">problem validator</option>
        </select>
        <input class="btn btn-block btn-lg btn-primary" type="submit" value="submit" name="submit" />
            
        </form>
        
        <form method="post" action="logout.jsp"  class="">
                    <button type="submit" value="Logout"  class="btn btn-danger" >logout</button>
                </form>
        </div> 
    </body>
</html>
