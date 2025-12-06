<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    /* 1. Настройки БД (Разбиты на части, чтобы редактор не ломал) */
    String p1 = "jdbc:mysql://localhost:3306/cafe_market";
    String p2 = "?useUnicode=true&characterEncoding=UTF-8";
    String dbURL = p1 + p2;
    
    String dbUser = "root";
    /* Проверь свой пароль здесь! */
    String dbPass = "mysql123"; 

    /* 2. Получаем данные из формы */
    request.setCharacterEncoding("UTF-8");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (email != null && password != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            String sql = "SELECT id, name, stamps FROM users " 
                       + "WHERE email = ? AND password = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, password);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                /* УСПЕХ */
                session.setAttribute("user_email", email);
                session.setAttribute("user_name", rs.getString("name"));
                session.setAttribute("user_id", rs.getInt("id"));
                
                // ВАЖНО: Сохраняем штампы в сессию!
                int dbStamps = rs.getInt("stamps");
                session.setAttribute("user_stamps", dbStamps);

                response.sendRedirect("products.jsp");
            } else {
                /* ОШИБКА: Неверный логин или пароль */
                response.sendRedirect("login.jsp?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    } else {
        response.sendRedirect("login.jsp?error=empty");
    }
%>