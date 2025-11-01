<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    // Проверка админа
    if (session.getAttribute("isAdmin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
    
    @SuppressWarnings("unchecked")
    List<Map<String, Object>> orders = (List<Map<String, Object>>) session.getAttribute("orders");
    if (orders == null) orders = new ArrayList<>();
%>
<html>
<head><title>Admin: Orders</title></head>
<body>
    <h1>Admin Dashboard — All orders</h1>
    <a href="adminLogout.jsp">Logout</a>
    
    <% if (orders.isEmpty()) { %>
        <p>We dont have orders.</p>
    <% } else { %>
        <table border="1" style="width:800px;">
            <tr><th>ID</th><th>Date</th><th>Products</th><th>Over</th><th>status</th><th>btns</th></tr>
            <%
                for (Map<String, Object> order : orders) {
                    @SuppressWarnings("unchecked")
                    List<Map<String, String>> items = (List<Map<String, String>>) order.get("items");
                    int total = (Integer) order.get("total");
                    String status = (String) order.get("status");
            %>
            <tr>
                <td><%= order.get("id") %></td>
                <td><%= order.get("date") %></td>
                <td>
                    <ul>
                        <% for (Map<String, String> item : items) { %>
                            <li><%= item.get("name") %> — <%= item.get("price") %>원</li>
                        <% } %>
                    </ul>
                </td>
                <td><%= total %>원</td>
                <td><%= status %></td>
                <td>
                    <% if ("pending".equals(status)) { %>
                        <form action="adminUpdateOrder.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="orderId" value="<%= order.get("id") %>">
                            <button type="submit">Delivered</button>
                        </form>
                    <% } else { %>
                        <span style="color:green;">Delivered</span>
                    <% } %>
                </td>
            </tr>
            <%
                }
            %>
        </table>
    <% } %>
    <br>
    <a href="products.jsp">Home</a>
</body>
</html>