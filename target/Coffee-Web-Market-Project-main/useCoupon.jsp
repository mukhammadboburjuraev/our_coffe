<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // 1. Проверяем, кто вошел
    String userIdObj = String.valueOf(session.getAttribute("user_id"));
    if (userIdObj == null || "null".equals(userIdObj)) {
        response.sendRedirect("login.jsp");
        return;
    }
    int userId = Integer.parseInt(userIdObj);

    // 2. Подключаемся к базе
    String dbURL = "jdbc:mysql://localhost:3306/cafe_market?useUnicode=true&characterEncoding=UTF-8";
    String dbUser = "root";
    String dbPass = "mysql123"; // <--- ПРОВЕРЬ ПАРОЛЬ

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // 3. SQL ЗАПРОС: Отнимаем 10 штампов, НО только если их больше или равно 10
        // Это защита, чтобы не уйти в минус.
        String sql = "UPDATE users SET stamps = stamps - 10 WHERE id = ? AND stamps >= 10";
        
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, userId);
        
        int rowsUpdated = pstmt.executeUpdate();

        if (rowsUpdated > 0) {
            // УСПЕХ: Штампы списались
            
            // Обновляем сессию (отнимаем 10 от того, что в памяти)
            int currentStamps = (Integer) session.getAttribute("user_stamps");
            session.setAttribute("user_stamps", currentStamps - 10);
            
            // Возвращаем на страницу штампов с сообщением об успехе
            response.sendRedirect("stamps.jsp?status=redeemed");
        } else {
            // ОШИБКА: Недостаточно штампов (хакер попытался списать без накопления)
            response.sendRedirect("stamps.jsp?error=not_enough");
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>