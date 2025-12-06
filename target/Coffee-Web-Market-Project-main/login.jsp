<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Login</title>
    <link rel="stylesheet" href="assets/css/app.css" />
  </head>
  <body class="auth-page">
    <header class="hotbar">
      <div class="hotbar__inner">
        <a href="products.jsp" class="brand">
          <span class="brand__logo">&#9749;</span>
          <span class="brand__text">Cafe Web Market</span>
        </a>
      </div>
    </header>

    <div class="container">
      <div class="auth-card">
        <h2 class="pd-card__title">Login</h2>

        <!-- ДОБАВЛЕННЫЙ БЛОК: Показ ошибки -->
        <% String error = request.getParameter("error"); if
        ("invalid".equals(error)) { %>
        <div
          style="
            color: #e74c3c;
            text-align: center;
            margin-bottom: 15px;
            font-weight: bold;
          "
        >
          Invalid email or password!
        </div>
        <% } %>
        <!-- КОНЕЦ БЛОКА -->

        <form action="loginProcess.jsp" method="post" class="auth-form">
          <div class="form-row">
            <label>Email</label>
            <input type="email" name="email" required />
          </div>

          <div class="form-row">
            <label>Password</label>
            <input type="password" name="password" required />
          </div>

          <div class="form-actions">
            <button type="submit" class="btn btn--primary btn--lg btn--full">
              Login
            </button>
          </div>

          <p class="auth-hint">
            No account?
            <a href="signup.jsp">Sign Up</a>
          </p>
        </form>
      </div>
    </div>
  </body>
</html>
