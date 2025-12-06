<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String userName = (String) session.getAttribute("user_name");
    boolean isUser = (userName != null);
%>

<header class="hotbar">
  <div class="hotbar__inner">
    <a href="products.jsp" class="brand" aria-label="Home">
      <span class="brand__logo">☕</span>
      <span class="brand__text">Cafe Web Market</span>
    </a>

    <nav class="nav" aria-label="Main">
      <a class="nav__link" href="products.jsp">Products</a>

      <% if (isUser) { %>
        <a class="nav__link" href="stamps.jsp">Stamps 🎫</a>

        <div class="nav__user-info" style="display: inline-flex; align-items: center; gap: 8px; margin-right: 10px;">
            <span style="font-size: 1.2em;">👤</span>
            <span style="font-weight: 600;"><%= userName %></span>
        </div>

        <button id="themeToggle" class="toggle" aria-label="Toggle Dark Mode">
             <span id="themeIcon">🌗</span>
        </button>

        <a class="nav__link btn btn--sm" href="logout.jsp" style="margin-left: 10px;">Logout</a>

      <% } else { %>
        
        <button id="themeToggle" class="toggle" aria-label="Toggle Dark Mode">
             <span id="themeIcon">🌗</span>
        </button>

        <a class="nav__link" href="login.jsp">Login</a>
        <a class="nav__link btn btn--primary" href="signup.jsp">Sign Up</a>
      <% } %>

    </nav>
  </div>
</header>