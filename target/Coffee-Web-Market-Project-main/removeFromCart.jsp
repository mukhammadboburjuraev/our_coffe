<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String indexStr = request.getParameter("index");
    
    if (indexStr != null) {
        List<Map<String,String>> cart = (List<Map<String,String>>) session.getAttribute("cart");
        if (cart != null) {
            try {
                int index = Integer.parseInt(indexStr);
                if (index >= 0 && index < cart.size()) {
                    cart.remove(index);
                }
            } catch (Exception e) {
                // Игнорируем ошибки
            }
        }
    }
    
    // Возвращаемся в корзину
    response.sendRedirect("cart.jsp");
%>