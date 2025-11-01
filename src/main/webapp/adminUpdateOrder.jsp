<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    if (session.getAttribute("isAdmin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
    
    int orderId = Integer.parseInt(request.getParameter("orderId"));
    
    @SuppressWarnings("unchecked")
    List<Map<String, Object>> orders = (List<Map<String, Object>>) session.getAttribute("orders");
    if (orders != null) {
        for (Map<String, Object> order : orders) {
            if (orderId == (Integer) order.get("id")) {
                order.put("status", "delivered");
                break;
            }
        }
    }
    
    response.sendRedirect("adminDashboard.jsp");
%>