<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 1. Получаем данные о товаре
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String price = request.getParameter("price");

    if (id != null && name != null) {
        // 2. Получаем корзину из сессии
        List<Map<String,String>> cart = (List<Map<String,String>>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        // 3. Создаем товар и добавляем в список
        Map<String,String> item = new HashMap<>();
        item.put("id", id);
        item.put("name", name);
        item.put("price", price);
        
        cart.add(item);
    }

    // 4. Возвращаемся на главную
    response.sendRedirect("products.jsp");
%>