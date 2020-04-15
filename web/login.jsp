<%-- 
    Document   : login
    Created on : Mar 8, 2018, 11:30:39 PM
    Author     : mahmoud
--%>

<%@page import="com.olc.model.User"%>
<%@page import="com.olc.dao.UserDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
          <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
          <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
        
    </head>
    <body>
        
        <%
            
        if (session.getAttribute("username")!=null )
	{
		 response.sendRedirect("welcome.jsp");
                
	}
          
            if(request.getParameter("submit") != null)
            {
                String username=request.getParameter("username");
		String password =request.getParameter("password");
                
                UserDao dao = new UserDao();
                //user found
              if ( dao.validateLogin(username,password)){
                  //create a session
                    User user= dao.getUserByUsername(username);
                    session.setAttribute("username", user.getUsername());
                    session.setAttribute("user_id", user.getId());
                    session.setAttribute("score",user.getScore());
                    session.setAttribute("team_id",user.getTeamId());
                    session.setAttribute("leader",user.getLeader());
                     session.setAttribute("role",user.getRole());
                     session.setAttribute("rank",dao.getRank(user.getId()));


                    
                   //redirect 
                    response.sendRedirect("welcome.jsp");
                    return;
                  //user not found
              }else{
                  out.print("<p style='color: red'>invalid username or password</p>");
              }
              
            }
        %>
      <div class = "container">
	<div class="wrapper">
            
          <form action="login.jsp" method="POST" class="form-signin" >
                <h3 class="form-signin-heading">Welcome Back! Please Sign In</h3>
              	  <hr class="colorgraph"><br>
           
             <input type="text" class="form-control" name="username" placeholder="Username" required="" autofocus="" />
            <input type="password" class="form-control" name="password" placeholder="Password" required=""/>     		  
			 
			  <button class="btn btn-lg btn-primary btn-block"  name="submit" value="submit" type="Submit">Login</button>  			
	     <a href="register.jsp" class="btn btn-success btn-block text-center ">Register</a>
          </form>
            
          
   
        
       	</div>
        </div>
		  

      
<style>
.wrapper {    
	margin-top: 80px;
	margin-bottom: 20px;
}

.form-signin {
  max-width: 420px;
  padding: 30px 38px 66px;
  margin: 0 auto;
  background-color: #eee;
  border: 3px dotted rgba(0,0,0,0.1);  
  }

.form-signin-heading {
  text-align:center;
  margin-bottom: 30px;
}

.form-control {
  position: relative;
  font-size: 16px;
  height: auto;
  padding: 10px;
}

input[type="text"] {
  margin-bottom: 0px;
  border-bottom-left-radius: 0;
  border-bottom-right-radius: 0;
}

input[type="password"] {
  margin-bottom: 20px;
  border-top-left-radius: 0;
  border-top-right-radius: 0;
}

.colorgraph {
  height: 7px;
  border-top: 0;
  background: #c4e17f;
  border-radius: 5px;
  background-image: -webkit-linear-gradient(left, #c4e17f, #c4e17f 12.5%, #f7fdca 12.5%, #f7fdca 25%, #fecf71 25%, #fecf71 37.5%, #f0776c 37.5%, #f0776c 50%, #db9dbe 50%, #db9dbe 62.5%, #c49cde 62.5%, #c49cde 75%, #669ae1 75%, #669ae1 87.5%, #62c2e4 87.5%, #62c2e4);
  background-image: -moz-linear-gradient(left, #c4e17f, #c4e17f 12.5%, #f7fdca 12.5%, #f7fdca 25%, #fecf71 25%, #fecf71 37.5%, #f0776c 37.5%, #f0776c 50%, #db9dbe 50%, #db9dbe 62.5%, #c49cde 62.5%, #c49cde 75%, #669ae1 75%, #669ae1 87.5%, #62c2e4 87.5%, #62c2e4);
  background-image: -o-linear-gradient(left, #c4e17f, #c4e17f 12.5%, #f7fdca 12.5%, #f7fdca 25%, #fecf71 25%, #fecf71 37.5%, #f0776c 37.5%, #f0776c 50%, #db9dbe 50%, #db9dbe 62.5%, #c49cde 62.5%, #c49cde 75%, #669ae1 75%, #669ae1 87.5%, #62c2e4 87.5%, #62c2e4);
  background-image: linear-gradient(to right, #c4e17f, #c4e17f 12.5%, #f7fdca 12.5%, #f7fdca 25%, #fecf71 25%, #fecf71 37.5%, #f0776c 37.5%, #f0776c 50%, #db9dbe 50%, #db9dbe 62.5%, #c49cde 62.5%, #c49cde 75%, #669ae1 75%, #669ae1 87.5%, #62c2e4 87.5%, #62c2e4);
}
</style>	  

    </body>
</html>
