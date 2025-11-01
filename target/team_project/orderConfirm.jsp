<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    // Очищаем корзину
    session.removeAttribute("cart");
    
    // Получаем корзину перед очисткой (для заказа)
    @SuppressWarnings("unchecked")
    List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("oldCart"); // Сохраним заранее в addToCart
    if (cart == null) cart = new ArrayList<>();
    
    // Сохраняем заказ в "БД" (ArrayList в сессии)
    @SuppressWarnings("unchecked")
    List<Map<String, Object>> orders = (List<Map<String, Object>>) session.getAttribute("orders");
    if (orders == null) {
        orders = new ArrayList<>();
        session.setAttribute("orders", orders);
    }
    
    Map<String, Object> newOrder = new HashMap<>();
    newOrder.put("id", orders.size() + 1); // ID заказа
    newOrder.put("items", cart); // Товары
    newOrder.put("date", new java.util.Date()); // Дата
    newOrder.put("status", "pending"); // Статус
    newOrder.put("total", 0); // Подсчитаем
    int total = 0;
    for (Map<String, String> item : cart) {
        total += Integer.parseInt(item.get("price"));
    }
    newOrder.put("total", total);
    orders.add(newOrder);
    
    // Сохраним старую корзину для дебага (удали потом)
    session.setAttribute("oldCart", null);
%>
<html>
<head><title>주문 완료</title></head>
<body>
    <h1 style="color:green;">주문이 완료되었습니다! ☕</h1>
    <p>Заказ №<%= newOrder.get("id") %> на сумму <%= total %>원</p>
    <br>
    <a href="products.jsp">새 주문하기</a> | <a href="adminLogin.jsp">Админ панель</a>
</body>
</html>