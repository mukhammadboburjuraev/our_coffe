<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    // Basit şifre kontrolü (ihtiyacınıza göre değiştirin / güvenli hale getirin)
    final String ADMIN_PWD = "admin123";  // <-- mevcut şifrenizi buraya uyarlayın
    String msg = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String pwd = request.getParameter("pwd");
        if (pwd != null && pwd.equals(ADMIN_PWD)) {
            session.setAttribute("isAdmin", true);
            response.sendRedirect("adminDashboard.jsp");  // mevcut panel sayfanız
            return;
        } else {
            msg = "비밀번호가 올바르지 않습니다.";
        }
    }
%>
<!doctype html>
<html lang="ko" data-theme="light">
<head>
  <meta charset="utf-8">
  <title>관리자 로그인</title>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <link rel="stylesheet" href="assets/css/app.css">
</head>
<body class="auth-page">

  <%@ include file="/WEB-INF/hotbar.jsp" %>

  <!-- Hero -->
  <section class="hero hero--compact">
    <div class="hero__inner">
      <h1 class="hero__title">관리자 로그인</h1>
    </div>
  </section>

  <!-- Login Card -->
  <main class="container">
    <div class="auth-card">
      <form method="post" action="adminLogin.jsp" class="auth-form" autocomplete="off">
        <div class="form-row">
          <label for="pwd">비밀번호</label>
          <input id="pwd" name="pwd" type="password" placeholder="••••••••" required>
        </div>

        <% if (msg != null) { %>
          <p class="form-error"><%= msg %></p>
        <% } %>

        <div class="form-actions">
          <a href="products.jsp" class="btn btn--ghost">돌아가기</a>
          <button type="submit" class="btn btn--primary btn--full">로그인</button>
        </div>
      </form>

      <p class="auth-hint">
        관리자만 접근할 수 있습니다. 보안을 위해 비밀번호를 안전하게 보관하세요.
      </p>
    </div>
  </main>

  <!-- Kayan sepet balonunuz varsa (fab) diğer sayfalarla tutarlı kalsın -->
  <a class="fab" href="cart.jsp" aria-label="장바구니">
    <svg width="26" height="26" viewBox="0 0 24 24" fill="none" aria-hidden="true">
      <path d="M6 6h15l-1.5 8.5a2 2 0 0 1-2 1.7H9.2a2 2 0 0 1-2-1.6L5 3H2"
            stroke="white" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
      <circle cx="10" cy="21" r="1.5" fill="white"/>
      <circle cx="18" cy="21" r="1.5" fill="white"/>
    </svg>
  </a>

  <script src="assets/js/app.js"></script>
</body>
</html>
