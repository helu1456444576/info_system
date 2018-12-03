<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/8/11
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
    <link rel="stylesheet"  href="../css/login.css">

    <script src="../js/jquery-2.1.1.min.js"></script>
</head>
<body>
<div class="htmleaf-container">
    <div class="wrapper">
        <div class="container">
            <h1>Register</h1>

            <form class="form" action="/register" method="post">
                <input type="text" placeholder="Username" name="username">
                <input type="password" placeholder="Password" name="password">
                <input type="password" placeholder="Password Again" name="repassword">
                <input type="text" placeholder="Name" name="name">
                <div id="choose-sex">
                    <input class="sel" type="radio" name="sex" value="男" checked><span>Male</span>
                    <input class="sel" type="radio" name="sex" value="女"><span>Female</span>
                </div>
                <button type="submit" id="confirm-button" onclick="">Confirm</button><br>
                <button id="return-button" style="padding: 0;"><a href="/login" style="display: block; width: 100%; padding: 10px 15px;">Return</a></button>

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

<script>
    function func(event) {
        event.preventDefault();
        document.getElementsByTagName('form').fadeOut(500);
        document.getElementsByClassName('.wrapper').addClass('form-success');
    }
</script>

</body>
</html>
