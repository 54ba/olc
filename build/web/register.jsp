<%-- 
    Document   : register
    Created on : Mar 9, 2018, 12:55:35 AM
    Author     : mahmoud
--%>

<%@page import="com.olc.model.User"%>
<%@page import="com.olc.dao.UserDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
           <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
          <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
        
    </head>
    <body>
        <%
         if (session.getAttribute("username")!=null)
	{
		  response.sendRedirect("welcome.jsp");
                
	}
       
         if(request.getParameter("submit") != null)
            {
                String username=request.getParameter("username");
		String password =request.getParameter("password");
		String name =request.getParameter("name");
		
                
                
                
                UserDao dao = new UserDao();
                //if username exists
                if(dao.validateRegister(username)){
                out.print("<p style='color: red'>username is already taken</p>");
                
                //if username doesn't exist
                }else{
                   
                
                User user = new User();
                user.setName(name);
                user.setUsername(username);
                user.setPassword(password);
                
                //dao creates user
               dao.createUser(user);
               //redirect
                response.sendRedirect("login.jsp");
                    return;
                }
                 
            }
        %>
       
        
        <div class="container">

<div class="wrapper">
    <div class="form-signup">
		<form  action="register.jsp" method="POST">
			<h2>Please Sign Up </h2>
			<hr class="colorgraph">
			
			<div class="form-group">
				<input type="text" name="name"  class="form-control input-lg" placeholder="Name" tabindex="1" autofocus=""  required>
			</div>
			<div class="form-group">
				<input type="text" name="username" class="form-control input-lg" placeholder="Username" tabindex="2" required>
			</div>
			<div class="form-group">
				<input type="password" name="password"  class="form-control input-lg" placeholder="Password" tabindex="3" required>
			</div>
			
			<hr class="colorgraph">
			<div class="row">
				<input name="submit" type="submit" value="submit" class="btn btn-primary btn-block btn-lg" tabindex="4">
                                <a href="login.jsp" class="btn btn-success btn-block text-center ">Login</a>

			</div>
		</form>
	</div>
</div>
            
            <style>
                .wrapper {    
	margin-top: 80px;
	margin-bottom: 20px;
}

.form-signup {
  max-width: 420px;
  padding: 30px 38px 66px;
  margin: 0 auto;
  background-color: #eee;
  border: 3px dotted rgba(0,0,0,0.1);  
  }

                .colorgraph {
  height: 5px;
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
