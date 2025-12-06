<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Собираем ссылку из двух частей, чтобы редактор не ломал строку
    String dbURL = "jdbc:mysql://localhost:3306/cafe_market" + 
                   "?useUnicode=true&characterEncoding=UTF-8";
    String dbUser = "root";
    String dbPass = "mysql123"; // Проверь свой пароль!

    request.setCharacterEncoding("UTF-8");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (name != null && email != null && password != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            
            String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, password);
            
            int rowCount = pstmt.executeUpdate();
            
            if (rowCount > 0) {
                response.sendRedirect("login.jsp");
            } else {
                out.println("Error: Registration failed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Database Error: " + e.getMessage());
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    } else {
        out.println("Error: Missing data.");
    }
%>