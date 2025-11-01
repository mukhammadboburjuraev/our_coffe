<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    // Безопасно получаем корзину
    @SuppressWarnings("unchecked")
    List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");
    
    if (cart == null) {
        cart = new ArrayList<>();
        session.setAttribute("cart", cart);
    }
    
    int total = 0;
    for (Map<String, String> item : cart) {
        total += Integer.parseInt(item.get("price"));
    }
%>
<html>
<head><title>장바구니</title></head>
<body>
    <h1>장바구니</h1>
    <% if (cart.isEmpty()) { %>
        <p>장바구니가 비어있습니다.</p>
    <% } else { %>
        <table border="1" style="width:500px;">
            <tr><th>상품</th><th>가격</th></tr>
            <%
                for (Map<String, String> item : cart) {
            %>
            <tr>
                <td><%= item.get("name") %></td>
                <td><%= item.get("price") %>원</td>
            </tr>
            <%
                }
            %>
            <tr>
                <td><strong>합계</strong></td>
                <td><strong><%= total %>원</strong></td>
            </tr>
        </table>
        <br>
        <form action="orderConfirm.jsp" method="post">
            <button style="background:green;color:white;padding:10px;font-size:16px;">주문 확정</button>
        </form>
    <% } %>
    <br>
    <a href="products.jsp">계속 쇼핑</a>
</body>
</html>