<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ru">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sign Up</title>
    <link rel="stylesheet" href="assets/css/app.css" />
  </head>
  <body class="auth-page">
    <!-- Шапка сайта (как на Login page) -->
    <header class="hotbar">
      <div class="hotbar__inner">
        <a href="products.jsp" class="brand">
          <span class="brand__logo">☕</span>
          <span class="brand__text">Cafe Web Market</span>
        </a>
      </div>
    </header>

    <div class="container">
      <div class="auth-card">
        <!-- Заголовок с правильным классом вместо h1 style="..." -->
        <h2 class="pd-card__title">Sign Up</h2>

        <form action="signUpProcess.jsp" method="post" class="auth-form">
          <!-- Поле Name -->
          <div class="form-row">
            <label for="name">Name</label>
            <input
              type="text"
              id="name"
              name="name"
              placeholder="Name"
              required
            />
          </div>

          <!-- Поле Email -->
          <div class="form-row">
            <label for="email">Email</label>
            <input
              type="email"
              id="email"
              name="email"
              placeholder="email@example.com"
              required
            />
          </div>

          <!-- Поле Password -->
          <div class="form-row">
            <label for="password">Password</label>
            <input
              type="password"
              id="password"
              name="password"
              placeholder="••••••••"
              required
              minlength="6"
            />
          </div>

          <!-- Кнопка с классами (btn--full растягивает её на 100%) -->
          <div class="form-actions">
            <button type="submit" class="btn btn--primary btn--lg btn--full">
              Create Account
            </button>
          </div>

          <!-- Ссылка на вход -->
          <p class="auth-hint">
            Already have an account?
            <a href="login.jsp">Login</a>
          </p>
        </form>
      </div>
    </div>
  </body>
</html>
