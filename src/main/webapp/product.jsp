<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<% 
    // Basit ürün verisi (hardcoded)
    String id = request.getParameter("id");
    if (id == null) id = "2"; // default latte

    String name, price, desc;
    
    switch (id) {
        case "1": // Espresso
            name = "에스프레소";
            price = "2000";
            desc = "진하게 추출한 에스프레소의 강렬한 바디와 향. " + 
                   "짧지만 깊은 풍미와 깔끔한 피니시가 특징으로, 단독으로도 블렌딩 베이스로도 훌륭합니다.";
            break;
        case "3": // Cappuccino
            name = "카푸치노";
            price = "2500";
            desc = "에스프레소에 부드러운 스팀 밀크와 풍성한 우유 거품을 더한 클래식 카푸치노. " + 
                   "은은한 단맛과 크리미한 텍스처가 잘 어우러지며, 시나몬 또는 코코아 파우더와도 잘 어울립니다.";
            break;
        default: // "2" Latte
            name = "라떼";
            price = "3000";
            desc = "부드러운 스팀 밀크와 에스프레소가 조화로운 클래식 라떼입니다. " + 
                   "고소한 우유 풍미와 온화한 커피 향이 부담 없이 즐기기 좋아요.";
    } 
%>
<!DOCTYPE html>
<html lang="ko" data-theme="light">
  <head>
    <meta charset="utf-8" />
    <title><%= name %> - 상품 상세</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="assets/css/app.css" />
  </head>
  <body>
  
    <%-- 
       ИСПРАВЛЕНИЕ:
       Строка ниже вызывала ошибку 500, так как сервер не мог найти файл в папке /WEB-INF/.
       Я временно закомментировал её. 
       
       Если у вас есть файл hotbar.jspf в текущей папке, используйте:
       <%@ include file="hotbar.jspf" %> 
    --%>
    
    <%@ include file="/WEB-INF/hotbar.jsp" %>

    <!-- Временная навигация (пока hotbar.jspf отключен) -->

    <main class="container product-detail">
      <h1 class="hero__title" style="margin: 10px 0 22px; text-align: center">
        상품 상세
      </h1>

      <!-- Yalnızca yazılar + fiyat + butonlar (kart görünümü) -->
      <section class="pd-card">
        <h2 class="pd-card__title"><%= name %></h2>
        <p class="pd-card__desc"><%= desc %></p>

        <div class="pd-card__bottom">
          <div class="pd-card__left">
            <a href="products.jsp" class="btn btn--ghost">계속 쇼핑</a>
            <a href="cart.jsp" class="btn btn--ghost">장바구니 보기</a>
          </div>

          <div class="pd-card__right">
            <strong class="pd-card__price"><%= price %>원</strong>
            <form action="addToCard.jsp" method="post">
              <input type="hidden" name="id" value="<%= id %>" />
              <input type="hidden" name="name" value="<%= name %>" />
              <input type="hidden" name="price" value="<%= price %>" />
              <button type="submit" class="btn btn--primary btn--lg">
                장바구니에 담기
              </button>
            </form>
          </div>
        </div>
      </section>
    </main>

    <!-- Sağ altta yüzen sepet -->
    <a class="fab" href="cart.jsp" aria-label="장바구니">
      <svg
        width="26"
        height="26"
        viewBox="0 0 24 24"
        fill="none"
        aria-hidden="true"
      >
        <path
          d="M6 6h15l-1.5 8.5a2 2 0 0 1-2 1.7H9.2a2 2 0 0 1-2-1.6L5 3H2"
          stroke="white"
          stroke-width="1.8"
          stroke-linecap="round"
          stroke-linejoin="round"
        />
        <circle cx="10" cy="21" r="1.5" fill="white" />
        <circle cx="18" cy="21" r="1.5" fill="white" />
      </svg>
    </a>

    <script src="assets/js/app.js"></script>
  </body>
</html>