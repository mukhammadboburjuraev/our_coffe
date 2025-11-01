<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = request.getParameter("id");
    String name = "", price = "";
    if ("1".equals(id)) { name = "에스프레소"; price = "200"; }
    else if ("2".equals(id)) { name = "라떼"; price = "300"; }
    else if ("3".equals(id)) { name = "카푸치노"; price = "250"; }
    pageContext.setAttribute("name", name);
    pageContext.setAttribute("price", price);
%>
<html>
<head><title>상품 상세</title></head>
<body>
    <h1>${name}</h1>
    <p>가격: ${price}원</p>
    <form action="addToCard.jsp" method="post">
        <input type="hidden" name="id" value="<%=id%>">
        <input type="hidden" name="name" value="${name}">
        <input type="hidden" name="price" value="${price}">
        <button>장바구니에 담기</button>
    </form>
    <br>
    <a href="products.jsp">돌아가기</a>
</body>
</html>