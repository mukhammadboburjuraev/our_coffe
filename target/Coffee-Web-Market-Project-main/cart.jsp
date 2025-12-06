<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    @SuppressWarnings("unchecked")
    List<Map<String,String>> cart = (List<Map<String,String>>) session.getAttribute("cart");
    if (cart == null) { cart = new ArrayList<>(); }

    int total = 0;
    for (Map<String,String> it : cart) {
        try { total += Integer.parseInt(it.get("price")); } catch(Exception ignore){}
    }
    
%>
<!doctype html>
<html lang="ko" data-theme="light">
<head>
  <meta charset="utf-8">
  <title>장바구니 (Cart)</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="assets/css/app.css">
  <style>
    /* ---- Cart page additions ---- */
    .cart-hero{ max-width:1100px; margin:0 auto; padding:42px 16px 18px; text-align:center; }
    .cart-hero__title{ font-size:40px; font-weight:800; margin:0; }

    .cart-wrap{ max-width:1100px; margin:0 auto; padding:0 16px 64px; }
    .cart-card{
      background:var(--paper); border-radius:22px; box-shadow:var(--card-shadow);
      border:1px solid color-mix(in oklab, var(--ink) 8%, transparent);
      overflow:hidden;
    }
    .cart-table{ width:100%; border-collapse:separate; border-spacing:0; }
    .cart-table thead th{
      text-align:left; font-weight:800; padding:16px 20px;
      border-bottom:1px solid color-mix(in oklab, var(--ink) 12%, transparent);
      color:var(--muted);
    }
    .cart-table tbody td{ padding:14px 20px; vertical-align:middle; }
    .cart-row{ border-bottom:1px solid color-mix(in oklab, var(--ink) 10%, transparent); }
    .cart-thumb{
      width:72px; height:72px; object-fit:cover; border-radius:12px;
      background:#f3ebe3; display:block;
      box-shadow:0 2px 8px var(--ring);
    }
    .cart-name{ font-weight:800; }
    .cart-price{ font-weight:900; font-size:22px; letter-spacing:.2px; }
    .cart-total{
      font-weight:900; font-size:24px; padding:18px 20px;
      text-align:right; color:var(--ink);
    }
    .cart-actions{
      display:flex; align-items:center; justify-content:center; gap:12px;
      padding:22px 20px 26px;
      border-top:1px solid color-mix(in oklab, var(--ink) 12%, transparent);
      background: color-mix(in oklab, var(--paper) 94%, var(--bg));
    }
    .btn--xl{ font-size:18px; padding:14px 24px; border-radius:14px; }
    .link-muted{ color:var(--muted); text-decoration:none; }
    .link-muted:hover{ text-decoration:underline; }

    /* Удаление (×) button */
    .icon-btn{
      display:inline-flex; align-items:center; justify-content:center;
      width:32px; height:32px; border-radius:8px; cursor:pointer;
      border:1px solid color-mix(in oklab, var(--ink) 18%, transparent);
      background:transparent; font-size:18px; line-height:1; padding:0;
    }
    .icon-btn:hover{
      background: color-mix(in oklab, var(--ink) 8%, transparent);
    }
    .icon-btn--danger{
      color:#b30000; border-color: color-mix(in oklab, #b30000 50%, transparent);
    }
    .icon-btn--danger:hover{
      background: color-mix(in oklab, #b30000 10%, transparent);
    }
    .td-center { text-align:center; }
  </style>
</head>
<body>

  <!-- ИСПРАВЛЕННАЯ СТРОКА: правильный путь к файлу -->
  <jsp:include page="WEB-INF/hotbar.jsp" />

  <section class="cart-hero">
    <h1 class="cart-hero__title">Shopping Cart</h1>
  </section>

  <div class="cart-wrap">
    <% if (cart.size() == 0) { %>
        <!-- Если корзина пуста -->
        <div style="text-align:center; padding: 40px;">
            <h3>Your cart is empty 🛒</h3>
            <p><a href="products.jsp" class="btn btn--primary" style="margin-top:20px;">Go Shopping</a></p>
        </div>
    <% } else { %>
    
    <div class="cart-card">
      <table class="cart-table">
        <thead>
          <tr>
            <th style="width:110px;">Product</th>
            <th>Name</th>
            <th style="width:140px;">Price</th>
            <th style="width:72px; text-align:center;">Action</th> 
          </tr>
        </thead>
        <tbody>
        <%
          for (int i = 0; i < cart.size(); i++) {
              Map<String,String> item = cart.get(i);
              String id    = item.get("id");
              String name  = item.get("name");
              String price = item.get("price");

              String img = "Espresso.png"; // Картинка по умолчанию
              if (name.contains("Latte")) img = "Latte.png";
              else if (name.contains("Cappuccino")) img = "Cappuccino.png";
        %>
          <tr class="cart-row">
            <td>
              <img class="cart-thumb" src="assets/img/<%= img %>" alt="<%= name %>">
            </td>
            <td class="cart-name"><%= name %></td>
            <td class="cart-price"><%= price %> ₩</td>

            <!-- Кнопка удаления -->
            <td class="td-center">
              <form action="removeFromCart.jsp" method="post" style="display:inline;">
                <input type="hidden" name="index" value="<%= i %>">
                <button class="icon-btn icon-btn--danger" type="submit" aria-label="Remove">×</button>
              </form>
            </td>
          </tr>
        <%
          } // for
        %>
        </tbody>
      </table>

      <div class="cart-total">
        Total: <%= total %> ₩
      </div>

      <div class="cart-actions">
        <a class="link-muted" href="products.jsp">Continue Shopping</a>
        <form action="orderConfirm.jsp" method="post">
          <button type="submit" class="btn btn--primary btn--xl">Checkout</button>
        </form>
      </div>
    </div>
    
    <% } // else %>
  </div>

  <script src="assets/js/app.js"></script>
</body>
</html>