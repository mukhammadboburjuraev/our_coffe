<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    // Ürün listesi
    List<Map<String, String>> products = new ArrayList<>();
    products.add(Map.of("id","1","name","에스프레소","price","1800","img","Espresso.png"));
    products.add(Map.of("id","2","name","라떼","price","3000","img","Latte.png"));
    products.add(Map.of("id","3","name","카푸치노","price","4200","img","Cappuccino.png"));

    // Sepet sayısı (badge)
    @SuppressWarnings("unchecked")
    List<Map<String,String>> cart = (List<Map<String,String>>) session.getAttribute("cart");
    int cartCount = (cart == null) ? 0 : cart.size();
%>
<!doctype html>
<html lang="ko" data-theme="light">
<head>
  <meta charset="utf-8">
  <title>커피숍 - 메뉴</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Global CSS -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/app.css">

  <!-- Sayfa-içi kritik stiller (override için yüksek özgüllük + !important) -->
  <style>
    /* Çerçeve (border) ve arka planlı kapsayıcı */
    main.container .products-frame{
      background: var(--paper);
      border: 1px solid color-mix(in oklab, var(--ink) 12%, transparent);
      border-radius: 22px;
      box-shadow: var(--card-shadow);
      padding: 20px !important;
    }

    /* Grid: 3 sütun tek satır */
    main.container .products-grid{
      display: grid !important;
      grid-template-columns: repeat(3, 1fr) !important;
      gap: 22px !important;
      align-items: start;
    }

    /* Kart gövdesi */
    main.container .products-grid .card{
      display: flex;
      flex-direction: column;
      overflow: hidden;
      border-radius: 18px;
      border: 1px solid color-mix(in oklab, var(--ink) 8%, transparent);
      background: var(--paper);
      box-shadow: var(--card-shadow);
    }

    /* Kart medyası: sabit yüksekliğe sığdır */
    main.container .products-grid .card__media{
      width: 100%;
      height: 240px !important;   /* görsel yüksekliği */
      overflow: hidden;
      background: #f3ebe3;
    }
    main.container .products-grid .card__img{
      width: 100%;
      height: 100%;
      object-fit: cover;           /* taşmadan doldur */
      display: block;
      transform: translateZ(0);    /* render tutarlılığı */
    }

    /* Kart içeriği */
    main.container .products-grid .card__body{ padding: 14px 16px 18px; }
    main.container .products-grid .card__title{ margin: 0 0 6px; font-weight: 800; }
    main.container .products-grid .card__price{ margin: 0 0 10px; color: var(--muted); font-weight: 700; }
    main.container .products-grid .card__actions{
      display: flex; gap: 10px; flex-wrap: wrap;
    }

    /* Responsive (tablet ve aşağısı) */
    @media (max-width: 1024px){
      main.container .products-grid{ grid-template-columns: repeat(2, 1fr) !important; }
    }
    @media (max-width: 640px){
      main.container .products-grid{ grid-template-columns: 1fr !important; }
      main.container .products-grid .card__media{ height: 200px !important; }
    }
  </style>
</head>
<body>

  <%@ include file="/WEB-INF/hotbar.jsp" %>

  <!-- Hero -->
  <section class="hero">
    <div class="hero__inner">
      <h1 class="hero__title">온라인 커피 판매 사이트</h1>
    </div>
  </section>

  <!-- Products -->
  <main class="container">
    <div class="products-frame">
      <div class="products-grid">
        <%
          for (Map<String,String> p : products){
            String id    = p.get("id");
            String name  = p.get("name");
            String price = p.get("price");
            String img   = p.get("img");
        %>
          <article class="card">
            <div class="card__media">
              <img
                src="<%= request.getContextPath() %>/assets/img/<%= img %>"
                alt="<%= name %>"
                class="card__img">
            </div>
            <div class="card__body">
              <h3 class="card__title"><%= name %></h3>
              <p class="card__price"><%= price %>원</p>
              <div class="card__actions">
                <a class="btn btn--ghost" href="product.jsp?id=<%= id %>">상세보기</a>
                <form action="addToCard.jsp" method="post">
                  <input type="hidden" name="id" value="<%= id %>">
                  <input type="hidden" name="name" value="<%= name %>">
                  <input type="hidden" name="price" value="<%= price %>">
                  <button type="submit" class="btn btn--primary">장바구니에 담기</button>
                </form>
              </div>
            </div>
          </article>
        <% } %>
      </div>
    </div>
  </main>

  <!-- Floating Cart -->
  <a class="fab" href="cart.jsp" aria-label="장바구니">
    <svg width="26" height="26" viewBox="0 0 24 24" fill="none" aria-hidden="true">
      <path d="M6 6h15l-1.5 8.5a2 2 0 0 1-2 1.7H9.2a2 2 0 0 1-2-1.6L5 3H2" stroke="white" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
      <circle cx="10" cy="21" r="1.5" fill="white"/>
      <circle cx="18" cy="21" r="1.5" fill="white"/>
    </svg>
    <% if (cartCount > 0) { %>
      <span class="fab__badge"><%= cartCount %></span>
    <% } %>
  </a>

  <script src="<%=request.getContextPath()%>/assets/js/app.js"></script>
</body>
</html>
