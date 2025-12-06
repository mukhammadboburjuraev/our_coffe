<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String userName = (String) session.getAttribute("user_name");
    
    if (userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int myStamps = 0;
    if (session.getAttribute("user_stamps") != null) {
        myStamps = (Integer) session.getAttribute("user_stamps");
    }

    int maxStamps = 10;
    
    // Проверяем, был ли только что использован купон
    String status = request.getParameter("status");
    boolean couponUsed = "redeemed".equals(status);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Stamps</title>
    <link rel="stylesheet" href="assets/css/app.css">
    
    <style>
        .stamp-container { max-width: 600px; margin: 40px auto; text-align: center; }
        
        .stamp-card {
            background: #fff; border: 2px solid #3b2f2f; border-radius: 16px;
            padding: 30px; box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }

        .stamp-header { margin-bottom: 30px; }
        .stamp-header h2 { margin: 0; color: #3b2f2f; font-size: 24px; }
        
        .stamp-grid {
            display: grid; grid-template-columns: repeat(5, 1fr);
            gap: 15px; justify-items: center; margin-bottom: 30px;
        }

        .stamp-slot {
            width: 60px; height: 60px; border: 2px dashed #ccc;
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            font-size: 24px; color: #ccc; background: #f9f9f9;
        }

        .stamp-slot.active {
            border: 2px solid #8c6b5d; background: #fdf0e9; color: #8c6b5d;
            box-shadow: 0 4px 8px rgba(140, 107, 93, 0.2);
        }

        /* Кнопка использования купона */
        .coupon-btn {
            background: linear-gradient(135deg, #d35400, #e67e22);
            color: white; border: none; padding: 15px 30px;
            font-size: 18px; font-weight: bold; border-radius: 50px;
            cursor: pointer; box-shadow: 0 4px 15px rgba(230, 126, 34, 0.4);
            transition: transform 0.2s;
            width: 100%;
            animation: pulse 2s infinite;
        }
        .coupon-btn:hover { transform: scale(1.05); }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }

        /* Сообщение об успехе */
        .success-box {
            background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb;
            padding: 20px; border-radius: 12px; margin-bottom: 20px;
        }
        .coupon-code {
            font-size: 24px; font-weight: 900; letter-spacing: 2px;
            color: #2c3e50; background: #fff; padding: 10px;
            border-radius: 8px; border: 2px dashed #2c3e50;
            display: inline-block; margin-top: 10px;
        }
    </style>
</head>
<body>

    <jsp:include page="WEB-INF/hotbar.jsp" />

    <div class="container stamp-container">
        
        <!-- Если купон использован, показываем сообщение -->
        <% if (couponUsed) { %>
        <div class="success-box">
            <h2>🎉 Enjoy your Free Coffee!</h2>
            <p>Show this code to the barista:</p>
            <div class="coupon-code">FREE-<%= System.currentTimeMillis() % 1000 %></div>
        </div>
        <% } %>

        <div class="stamp-card">
            <div class="stamp-header">
                <h2>Loyalty Card</h2>
                <p><strong><%= userName %></strong>, you have: <strong><%= myStamps %></strong> stamps</p>
            </div>

            <div class="stamp-grid">
                <% 
                // Показываем только до 10 штампов визуально
                for (int i = 1; i <= maxStamps; i++) { 
                    String activeClass = (i <= myStamps) ? "active" : "";
                %>
                    <div class="stamp-slot <%= activeClass %>">
                        <% if (i <= myStamps) { %> ☕ <% } else { %> <%= i %> <% } %>
                    </div>
                <% } %>
            </div>

            <!-- ЛОГИКА КНОПКИ -->
            <% if (myStamps >= 10) { %>
                <form action="useCoupon.jsp" method="post">
                    <button type="submit" class="coupon-btn">
                        🎁 Use Coupon (-10 Stamps)
                    </button>
                </form>
            <% } else { %>
                <p style="color: #7f8c8d;">Collect <strong><%= (10 - myStamps) %></strong> more stamps to get a reward!</p>
                <div style="background: #eee; height: 10px; border-radius: 5px; margin-top: 10px; overflow: hidden;">
                    <div style="width: <%= myStamps * 10 %>%; background: #8c6b5d; height: 100%;"></div>
                </div>
            <% } %>

        </div>
    </div>

</body>
</html>