<%-- 
    Document   : welcome
    Created on : Mar 9, 2018, 3:27:58 PM
    Author     : mahmoud
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome</title>
            <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
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
      
            %>
            
            <div class="container">   
                <i class="far fa-list-alt"></i> points : <%= session.getAttribute("score") %> |
                <i class="fas fa-level-up-alt"></i> rank :   <%= session.getAttribute("rank") %>
                <br>
                <jsp:include page="navbar.jsp" />
                <hr>
        <div style="background-color: #f5f4f4;
    border-radius: 5px 5px;
    box-shadow: 2px 2px 5px inset #e3e3e3;">
               <h1 class="display-1 text-center">Welcome</h1>
               <div class="text-center col-md-6 " style="float: none;
    padding: 20px 20px;
    box-shadow: 2px 2px 50px 5px #e3e3e3;
    margin: 0 auto;
    background-color: white;
    border-radius: 5px 5px;">
                    <h4 >Make a team and start competing </h4>  
                    <hr>
                    <img style="width:inherit" src="${pageContext.request.contextPath}/images/teams-1.jpg" />
                </div>

                <form method="post" action="logout.jsp" >
                    <button type="submit" value="Logout"  class="btn btn-danger" >logout</button>
                </form>
             </div>
        </div>        

    </body>
</html>
