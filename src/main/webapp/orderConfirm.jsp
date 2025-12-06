<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
    // 1. ПРОВЕРКА АВТОРИЗАЦИИ
    String userIdObj = String.valueOf(session.getAttribute("user_id"));
    if (userIdObj == null || "null".equals(userIdObj)) {
        response.sendRedirect("login.jsp");
        return;
    }
    int userId = Integer.parseInt(userIdObj);

    // 2. ЧИТАЕМ КОРЗИНУ
    @SuppressWarnings("unchecked")
    List<Map<String,String>> cart = (List<Map<String,String>>) session.getAttribute("cart");
    if (cart == null) cart = new ArrayList<>();

    boolean isEmpty = cart.isEmpty();
    int total = 0;
    int newStamps = 0;

    // 3. ЕСЛИ ЕСТЬ ТОВАРЫ -> ОБРАБАТЫВАЕМ ЗАКАЗ
    if (!isEmpty) {
        // Считаем сумму
        for (Map<String,String> it : cart) {
            try { total += Integer.parseInt(it.get("price")); } catch (Exception ignore) {}
        }
        
        // 1 товар = 1 штамп
        newStamps = cart.size(); 

        // --- ЛОГИКА БАЗЫ ДАННЫХ (STAMPS) ---
        String dbURL = "jdbc:mysql://localhost:3306/cafe_market?useUnicode=true&characterEncoding=UTF-8";
        String dbUser = "root";
        String dbPass = "mysql123"; // <--- ТВОЙ ПАРОЛЬ

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            // Добавляем штампы в БД
            String sql = "UPDATE users SET stamps = stamps + ? WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, newStamps);
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();

            // Обновляем штампы в сессии
            int currentSessionStamps = 0;
            if (session.getAttribute("user_stamps") != null) {
                currentSessionStamps = (Integer) session.getAttribute("user_stamps");
            }
            session.setAttribute("user_stamps", currentSessionStamps + newStamps);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }

        // --- ЛОГИКА ДЛЯ АДМИНКИ ---
        String orderNo = String.valueOf(System.currentTimeMillis() % 1000000);
        
        synchronized(application) {
            @SuppressWarnings("unchecked")
            List<Map<String, Object>> orders = (List<Map<String, Object>>) application.getAttribute("orders");
            if (orders == null) orders = new ArrayList<>();

            Map<String, Object> rec = new HashMap<>();
            rec.put("orderNo", orderNo);
            rec.put("total", total);
            rec.put("createdAt", System.currentTimeMillis());
            rec.put("items", new ArrayList<>(cart)); 
            rec.put("userId", userId);

            orders.add(0, rec);
            application.setAttribute("orders", orders);
        }

        // Очищаем корзину
        session.removeAttribute("cart");
    }
%>

<!doctype html>
<html lang="ko" data-theme="light">
<head>
  <meta charset="utf-8">
  <title><%= isEmpty ? "Empty Cart" : "Order Confirmed" %> - Cafe Web Market</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="assets/css/app.css">
  <style>
    .confirm-wrap{max-width:1100px;margin:0 auto;padding:32px 16px 80px;}
    .confirm-card{
      background:var(--paper);border:1px solid color-mix(in oklab,var(--ink) 8%,transparent);
      border-radius:22px;box-shadow:var(--card-shadow);padding:22px;text-align:center;
    }
    .confirm-title{font-size:32px;font-weight:900;margin:0 0 8px;}
    .confirm-text{color:var(--muted);margin:4px 0 14px;}
    .confirm-actions{display:flex;gap:12px;align-items:center;flex-wrap:wrap;margin-top:12px;justify-content:center;}
    .btn--lg{padding:12px 18px;border-radius:14px;font-weight:700;}
    .xbox{
      width:88px;height:88px;border-radius:18px;
      border:1px solid color-mix(in oklab, var(--ink) 18%, transparent);
      display:grid;place-items:center;font-size:48px;font-weight:900;
      color:#b30000;background: color-mix(in oklab, #b30000 10%, var(--paper));
      box-shadow:var(--card-shadow);margin:0 auto 12px;
    }
    .stamp-badge {
        background-color: #fdf0e9; color: #8c6b5d; padding: 10px 20px; border-radius: 20px; font-weight: bold; margin-bottom: 20px; display: inline-block;
    }
  </style>
</head>
<body>

  <!-- Подключаем шапку -->
  <jsp:include page="WEB-INF/hotbar.jsp" />

  <section class="hero hero--compact">
    <div class="hero__inner">
      <h1 class="hero__title"><%= isEmpty ? "Cart is Empty" : "Order Confirmed!" %></h1>
    </div>
  </section>

  <main class="confirm-wrap">
    <div class="confirm-card">
      <% if (isEmpty) { %>
        <div class="xbox">×</div>
        <h2 class="confirm-title">Cart is empty</h2>
        <p class="confirm-text">Please add items to cart.</p>
        <div class="confirm-actions">
          <a href="products.jsp" class="btn btn--primary btn--lg">Go to Menu</a>
        </div>
      <% } else { %>
        <h2 class="confirm-title" style="color: #2e7d32;">Success!</h2>
        
        <div class="stamp-badge">
            +<%= newStamps %> Stamps Earned! 🎫
        </div>

        <p class="confirm-text">Your order has been received. Thank you!</p>
        <p class="confirm-text">Total paid: <strong><%= total %> ₩</strong></p>

        <div class="confirm-actions">
          <a href="products.jsp" class="btn btn--lg">Order More</a>
          <a href="stamps.jsp" class="btn btn--ghost btn--lg">View My Stamps</a>
        </div>
      <% } %>
    </div>
  </main>

  <script src="assets/js/app.js"></script>
</body>
</html>