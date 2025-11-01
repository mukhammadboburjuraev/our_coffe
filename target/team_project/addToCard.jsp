<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String price = request.getParameter("price");

    @SuppressWarnings("unchecked")
    List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<>();
        session.setAttribute("cart", cart);
    }

    // ✅ 1. ДОБАВЛЯЕМ ТОВАР В КОРЗИНУ
    cart.add(Map.of("id", id, "name", name, "price", price));
    
    // ✅ 2. ТЕПЕРЬ КОПИРУЕМ КОРЗИНУ (она уже с товаром!)
    session.setAttribute("oldCart", new ArrayList<>(cart));
    
    // ✅ 3. Редирект
    response.sendRedirect("cart.jsp");
%>