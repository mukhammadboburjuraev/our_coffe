<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // 1. Очищаем сессию (удаляем имя, email и все данные о входе)
    session.invalidate();

    // 2. Перенаправляем пользователя на страницу входа
    response.sendRedirect("login.jsp");
%>