<%-- 
    Document   : create_competition
    Created on : Mar 11, 2018, 10:08:40 PM
    Author     : mahmoud
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.olc.dao.ProblemDao"%>
<%@page import="com.olc.model.Competition"%>
<%@page import="com.olc.dao.CompetitionDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>create a competition</title>
          <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
          <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
          <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
          <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap-datepicker3.css">
           <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datepicker.min.js"></script>
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
          
               if ((Integer) session.getAttribute("role") != 2&&  (Integer) session.getAttribute("role") != 1 ){
                     response.sendRedirect("welcome.jsp");
                }
        }
                  
            if(request.getParameter("submit") != null)
            {
             
            //get input data
            String name=request.getParameter("name");
            String start_date=request.getParameter("start_date");
            
            String end_date=request.getParameter("end_date");
            int creator=Integer.parseInt(request.getParameter("creator"));
             String[] submitted_problems = request.getParameterValues("submitted_problems"); 
            
             CompetitionDao dao = new CompetitionDao();
             
             if(dao.validateCompetition(name) ){
              out.print("<p style='color: red'>problem title is already taken</p>");
                return;
             }else{
                 SimpleDateFormat format = new SimpleDateFormat("dd/mm/yyyy");
                 Date sdate = format.parse(start_date);
                 Date edate = format.parse(end_date);

               Competition competition = new Competition();
               competition.setName(name);
               competition.setStartDate(sdate);
               competition.setEndDate(edate);
               competition.setCreator(creator);
               
               
               dao.createCompetition(competition,submitted_problems);
               
               response.sendRedirect("competitions.jsp");
               return;
             }
            
            }
        %>
        
        <% 
        request.setAttribute("problems", new ProblemDao().listValidatedPublicProblems());
            
        %>
   <div class="container">   
                       <jsp:include page="navbar.jsp" />
                       <hr>
       <h3 class="text-center">create a competition</h3>
       
    <form action="create_competition.jsp" method="POST">
        <div class="form-group">
        <label>competition name  </label>
        <input class="form-control input-lg" type="text" name="name" value="" required />
        </div>
        
         <div class="form-group">
        <label>start date </label>
        <input class="form-control input-lg" type="text" name="start_date" value="dd/mm/yyyy" required id="date"/>
         </div>
        
        <div class="form-group">
        <label>end date </label>
        <input class="form-control input-lg" type="text" name="end_date" value="dd/mm/yyyy" required id="date"/>
        </div>
        <input type="hidden" name="creator" value="<%= session.getAttribute("user_id")%>" />
        <br> 
        <small>choose problems press CTRL for multiple choise</small>
          <br>
        <select class="custom-select" name="submitted_problems" multiple="multiple"  size="12" required >
            <c:forEach items="${problems}" var="problem">
              
                <option value=<c:out value= "${problem.getId()}" />><c:out value= "${problem.getTitle()}"/></option>
              
            </c:forEach>
        </select>
        <input type="submit" class="btn btn-primary btn-block btn-lg" value="sumbit" name="submit" />
        
    </form>
                 
   <form method="post" action="logout.jsp"  class="">
                    <button type="submit" value="Logout"  class="btn btn-danger" >logout</button>
   </form>
</div>              
        
        <script>
    $(document).ready(function(){
        var date_input=$('input[id="date"]'); //our date input has the name "date"
        var container=$('.bootstrap-iso form').length>0 ? $('.bootstrap-iso form').parent() : "body";
        date_input.datepicker({
            format: 'mm/dd/yyyy',
            container: container,
            todayHighlight: true,
            autoclose: true,
        })
    })
</script>
    </body>
</html>
