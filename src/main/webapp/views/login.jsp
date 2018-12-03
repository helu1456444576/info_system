<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/8/11
  Time: 20:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <link rel="stylesheet" type="text/css" href="../css/login.css">
</head>
<body>
<div class="htmleaf-container">
    <div class="wrapper">
        <div class="container">
            <h1>Welcome</h1>

            <form class="form" action="/login" method="post">
                <input type="text" placeholder="Username" name="username">
                <input type="password" placeholder="Password" name="password">
                <button type="submit" id="login-button" >Login</button><br>
                <button id="register-button" style="padding: 0;"><a href="/register" style="display: block; width: 100%; padding: 10px 15px;">Register</a></button>
            </form>
            <div><br>${hint}</div>

        </div>

        <ul class="bg-bubbles">
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
</div>
<script type="text/javascript" src="../js/jquery-2.1.1.min.js"></script>

</body>
</html>