<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session.removeAttribute("isAdmin");
    response.sendRedirect("products.jsp");
%>