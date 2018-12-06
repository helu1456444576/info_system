<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/3
  Time: 19:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path ;
%>
<html>
<head>
    <title>我的消息</title>
    <link rel="stylesheet" type="text/css" href="//unpkg.com/iview/dist/styles/iview.css">
    <link rel="stylesheet" type="text/css" href="../css/layout.css">
    <link href="../css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div v-cloak id="app">
    <i-table @on-row-dblclick="clickRow" stript :columns="columnMessage" :data="dataMessage"></i-table>
</div>
<script src="../js/ajax.js"></script>
<script src="../js/jquery-2.1.1.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/vue.min.js"></script>
<script src="../js/iview.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/ajax.js"></script>
<script src="../js/jquery-2.0.0.min.js"></script>
<script src="../js/homepage.js"></script>
<script type="text/javascript">
    var app = new Vue({
        el: "#app",
        data: {
            username:'',
            columnMessage:[
                {
                title:'发送者',
                key:'senderName'
                },
                {
                    title:'内容',
                    key:'messageContent'
                }
            ],
            dataMessage:[]
        },
        methods: {
            clickRow: function(row) {
                console.log(row);
                turnToDetailUser(row);
            }
        }
    })

    $(document).ready(function () {
        ajaxGet("/info_system/getMessageList",function(res) {
            if(res.code=="success") {
                app.dataMessage=res.data;
            }
            console.log(app.dataMessage);
        },null,false);
    })

    function turnToDetail(item) {
        parent.app.page="<%=basePath%>/info_system/blogDetail?blogId="+item.blogId;
    }

    function turnToDetailUser(item) {
        parent.app.page="<%=basePath%>/info_system/otherBlogs?userId="+item.senderId;
    }

</script>
</body>
</html>
