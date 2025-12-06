<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.*" %>
<%
    // Sadece admin erişimi
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    // Tüm siparişleri sil (POST)
    if ("POST".equalsIgnoreCase(request.getMethod()) && "clear".equals(request.getParameter("action"))) {
        synchronized(application) {
            application.setAttribute("orders", new ArrayList<Map<String,Object>>());
        }
    }

    // Siparişleri oku
    @SuppressWarnings("unchecked")
    List<Map<String, Object>> orders =
        (List<Map<String, Object>>) application.getAttribute("orders");
    if (orders == null) orders = new ArrayList<>();

    int orderCount = orders.size();
    SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<!doctype html>
<html lang="ko" data-theme="light">
<head>
  <meta charset="utf-8" />
  <title>Admin Dashboard - Cafe Web Market</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link rel="stylesheet" href="assets/css/app.css" />

  <style>
    .adm-wrap { max-width:1100px; margin:0 auto; padding:0 16px 80px; }
    .adm-card {
      background:var(--paper);
      border:1px solid color-mix(in oklab, var(--ink) 8%, transparent);
      border-radius:22px;
      box-shadow: var(--card-shadow);
      overflow:hidden;
    }
    .adm-actions {
      display:flex; gap:10px; align-items:center; flex-wrap:wrap;
      padding:16px; border-top:1px solid color-mix(in oklab, var(--ink) 12%, transparent);
      background: color-mix(in oklab, var(--paper) 94%, var(--bg));
      justify-content:space-between;
    }
    .adm-table { width:100%; border-collapse:separate; border-spacing:0; }
    .adm-table th, .adm-table td { padding:14px 18px; text-align:left; }
    .adm-table thead th {
      font-weight:800; color:var(--muted);
      border-bottom:1px solid color-mix(in oklab, var(--ink) 12%, transparent);
    }
    .adm-table tbody tr { border-bottom:1px solid color-mix(in oklab, var(--ink) 10%, transparent); }
    .adm-table tbody tr:last-child { border-bottom:none; }
    .adm-empty { text-align:center; color:var(--muted); padding:42px 16px; }
    .badge {
      display:inline-flex; align-items:center; justify-content:center;
      min-width:22px; height:22px; padding:0 8px; border-radius:999px;
      background: color-mix(in oklab, var(--accent) 92%, var(--paper));
      color:#fff; font-size:12px; font-weight:800;
    }
    .btn--lg { padding:12px 18px; border-radius:14px; font-weight:700; }
  </style>
</head>
<body>

  <!-- Hotbar -->
  <header class="hotbar">
    <div class="hotbar__inner">
      <a href="products.jsp" class="brand" aria-label="Cafe Web Market 홈">
        <span class="brand__logo">☕</span>
        <span class="brand__text">Cafe Web Market</span>
      </a>

      <nav class="nav">
        <a class="nav__link" href="products.jsp">Products</a>
        <a class="nav__link" href="adminDashboard.jsp" aria-current="page">Admin Panel</a>
        <a class="nav__link" href="adminLogout.jsp">Logout</a>
        <button id="themeToggle" class="toggle" type="button" aria-label="Toggle theme">
          <span class="toggle__icon" id="themeIcon">🌙</span>
        </button>
      </nav>
    </div>
  </header>

  <!-- Hero -->
  <section class="hero hero--compact">
    <div class="hero__inner" style="text-align:center;">
      <h1 class="hero__title">관리자 대시보드</h1>
      <p class="muted" style="margin:6px 0 0;">
        총 주문 <span class="badge"><%= orderCount %></span>
      </p>
    </div>
  </section>

  <!-- Content -->
  <main class="adm-wrap">
    <div class="adm-card">
      <table class="adm-table">
        <thead>
          <tr>
            <th style="width:150px;">주문번호</th>
            <th style="width:140px;">시간</th>
            <th>항목 수</th>
            <th style="width:160px;">합계</th>
          </tr>
        </thead>
        <tbody>
        <%
          if (orders.isEmpty()) {
        %>
          <tr>
            <td colspan="4" class="adm-empty">등록된 주문이 없습니다.</td>
          </tr>
        <%
          } else {
            for (Map<String, Object> o : orders) {
              String no = String.valueOf(o.getOrDefault("orderNo", "-"));
              int totalVal = 0;
              Object t = o.get("total");
              if (t != null) {
                try { totalVal = (t instanceof Number) ? ((Number)t).intValue() : Integer.parseInt(String.valueOf(t)); } catch(Exception ignore){}
              }
              @SuppressWarnings("unchecked")
              List<Map<String, String>> items = (List<Map<String, String>>) o.get("items");
              int count = (items == null) ? 0 : items.size();

              long ts = 0L;
              Object created = o.get("createdAt");
              if (created != null) {
                try { ts = (created instanceof Number) ? ((Number)created).longValue() : Long.parseLong(String.valueOf(created)); } catch(Exception ignore){}
              }
              String when = (ts > 0) ? fmt.format(new Date(ts)) : "-";
        %>
          <tr>
            <td>#<%= no %></td>
            <td><%= when %></td>
            <td><%= count %>개</td>
            <td><strong><%= totalVal %></strong>원</td>
          </tr>
        <%
            }
          }
        %>
        </tbody>
      </table>

      <div class="adm-actions">
        <div style="display:flex; gap:10px; align-items:center;">
          <a href="products.jsp" class="btn btn--lg">홈으로</a>
          <a href="adminLogout.jsp" class="btn btn--ghost btn--lg">로그아웃</a>
        </div>

        <!-- Tüm siparişleri sil -->
        <form method="post" onsubmit="return confirm('모든 주문을 삭제할까요? 이 작업은 되돌릴 수 없습니다.');">
          <input type="hidden" name="action" value="clear"/>
          <button type="submit" class="btn btn--primary btn--lg">전체 주문 삭제</button>
        </form>
      </div>
    </div>
  </main>

  <script src="assets/js/app.js"></script>
</body>
</html>
