<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String error = request.getParameter("error");
%>
<html>
<head><title>Админ вход</title></head>
<body>
    <h1>Вход для админа</h1>
    <% if ("true".equals(error)) { %>
        <p style="color:red;">Неверный пароль!</p>
    <% } %>
    <form action="adminLogin.jsp" method="post">
        <label>Пароль: <input type="password" name="password"></label><br><br>
        <button type="submit">Войти</button>
    </form>
    <br>
    <a href="products.jsp">На главную</a>
<%
    if ("POST".equals(request.getMethod())) {
        String pass = request.getParameter("password");
        if ("admin123".equals(pass)) {
            session.setAttribute("isAdmin", true);
            response.sendRedirect("adminDashboard.jsp");
            return;
        } else {
            response.sendRedirect("adminLogin.jsp?error=true");
            return;
        }
    }
%>
</body>
</html>