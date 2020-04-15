<%-- 
    Document   : logout
    Created on : Apr 21, 2018, 8:41:37 PM
    Author     : mahmoud
--%>

<%
//    if(request.getParameter("submit").equals("logout")){
        session.invalidate();
        response.sendRedirect("login.jsp");
//    }
%>