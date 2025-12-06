<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!doctype html>
<html lang="ko" data-theme="light">
<head>
  <meta charset="utf-8">
  <title>주문 불가</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="assets/css/app.css">
  <style>
    .ec-hero{ max-width:1100px; margin:0 auto; padding:42px 16px 18px; text-align:center; }
    .ec-hero__title{ font-size:40px; font-weight:800; margin:0; }

    .ec-wrap{ max-width:1100px; margin:0 auto; padding:0 16px 80px; }
    .ec-card{
      background:var(--paper);
      border:1px solid color-mix(in oklab, var(--ink) 8%, transparent);
      border-radius:22px;
      box-shadow:var(--card-shadow);
      padding:34px 24px 28px;
    }
    .ec-empty__head{
      display:flex; flex-direction:column; align-items:center; justify-content:center;
      gap:14px; margin-bottom:16px;
    }
    .ec-empty__icon{
      width:56px; height:56px; display:grid; place-items:center;
      border-radius:14px;
      background: color-mix(in oklab, #ff4d4f 18%, var(--paper));
      box-shadow: 0 10px 22px color-mix(in oklab, #ff4d4f 24%, transparent);
      border:1px solid color-mix(in oklab, #ff4d4f 40%, transparent);
    }
    .ec-empty__icon svg{ width:26px; height:26px; }
    .ec-title{ margin:0; font-size:28px; font-weight:900; text-align:center; }
    .ec-desc{ margin:6px 0 0; color:var(--muted); text-align:center; }

    .ec-actions{ display:flex; align-items:center; justify-content:center; gap:12px; margin-top:18px; flex-wrap:wrap; }
    .btn{ display:inline-flex; align-items:center; justify-content:center; padding:10px 14px; border-radius:12px; border:1px solid transparent; cursor:pointer; }
    .btn--ghost{ background:transparent; border:1px solid color-mix(in oklab, var(--ink) 18%, transparent); color:var(--ink); }
    .btn--ghost:hover{ background: color-mix(in oklab, var(--ink) 8%, transparent); }
    .btn--primary{ background:var(--btn-dark); color:var(--btn-dark-text); }
  </style>
</head>
<body>

  <%@ include file="/WEB-INF/hotbar.jsp" %>

  <section class="ec-hero">
    <h1 class="ec-hero__title">주문 불가</h1>
  </section>

  <div class="ec-wrap">
    <div class="ec-card">
      <div class="ec-empty__head">
        <!-- Kırmızı X ikon (merkezde) -->
        <div class="ec-empty__icon" aria-hidden="true">
          <svg viewBox="0 0 24 24" fill="none">
            <path d="M6 6l12 12M18 6L6 18" stroke="#ff4d4f" stroke-width="2.6" stroke-linecap="round"/>
          </svg>
        </div>

        <h2 class="ec-title">장바구니가 비어 있습니다</h2>
        <p class="ec-desc">상품이 없으면 주문할 수 없습니다.</p>
      </div>

      <div class="ec-actions">
        <a class="btn btn--ghost" href="products.jsp">메뉴로 이동</a>
        <a class="btn btn--primary" href="cart.jsp">장바구니 보기</a>
      </div>
    </div>
  </div>

  <script src="assets/js/app.js"></script>
</body>
</html>
