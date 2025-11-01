<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    // Список продуктов (хардкод)
    List<Map<String, String>> products = new ArrayList<>();
    products.add(Map.of("id", "1", "name", "에스프레소", "price", "200"));
    products.add(Map.of("id", "2", "name", "라떼", "price", "300"));
    products.add(Map.of("id", "3", "name", "카푸치노", "price", "250"));
    pageContext.setAttribute("products", products);
%>
<html>
<head>
    <title>커피숍 - 메뉴</title>
    <style>
        table { border-collapse: collapse; width: 600px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        button { background: #8B4513; color: white; border: none; padding: 6px 10px; cursor: pointer; }
    </style>
</head>
<body>
    <h1>커피 메뉴 ☕</h1>
    <table>
        <tr><th>이름</th><th>가격</th><th>액션</th></tr>
        <%
            for (Map<String, String> p : products) {
        %>
        <tr>
            <td><%= p.get("name") %></td>
            <td><%= p.get("price") %>원</td>
            <td>
                <a href="product.jsp?id=<%= p.get("id") %>">상세보기</a>
                <form action="addToCard.jsp" method="post" style="display:inline;margin-left:10px;">
                    <input type="hidden" name="id" value="<%= p.get("id") %>">
                    <input type="hidden" name="name" value="<%= p.get("name") %>">
                    <input type="hidden" name="price" value="<%= p.get("price") %>">
                    <button type="submit">담기</button>
                </form>
            </td>
        </tr>
        <%
            }
        %>
    </table>
    <br>
    <a href="cart.jsp">장바구니 보기</a>
</body>
</html>