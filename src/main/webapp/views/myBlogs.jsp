<%--
  Created by IntelliJ IDEA.
  User: 折一架铁飞机
  Date: 2018/12/4
  Time: 19:39
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
    <title>我的博文</title>
    <link rel="stylesheet" type="text/css" href="//unpkg.com/iview/dist/styles/iview.css">
    <link rel="stylesheet" type="text/css" href="../css/layout.css">
    <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="app" v-cloak>

    <table class="table table-hover table-bordered table-condensed" style="margin-top: 20px;" >
        <!--<table id="contentTable" class="table table-striped table-bordered table-condensed">-->
        <thead>
        <tr style="font-size: 15px;">
            <%--<th style="width: 50px;">--%>
                <%--<Checkbox @on-change="checkAll()"  v-model="viewModel.allChecked" style="margin-left: 8px;">--%>
                <%--</Checkbox>--%>
            <%--</th>--%>
            <th align="center" style="text-align: center">图片</th>
            <th style="text-align: center">主题</th>
            <th style="text-align: center">内容</th>
                <th style="text-align: center">时间</th>
            <th style="text-align: center">点赞数</th>
            <th style="text-align: center">评论数</th>
            <th style="text-align: center">显示状态</th>
            <th style="text-align: center">查看</th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="(item,index) in blogList">
            <%--<td>--%>
                <%--<Checkbox v-model="item.checked" style="margin-left: 8px;" :key="item.id"></Checkbox>--%>
            <%--</td>--%>

            <td style="text-align: center">
                <img :src="'<%=basePath%>'+item.blogPic" style="width: 100px;"/>
            </td>
            <td style="text-align: center">{{item.blogTitle}}</td>
            <td style="text-align: center">{{item.blogContent}}</td>
                <td style="text-align: center">{{item.blogTime}}</td>
            <td style="text-align: center">{{item.likeCount}}</td>
                <td style="text-align: center">{{item.commentCount}}</td>
            <td style="text-align: center"><i-switch v-model="item.deleteFlag" @on-change="changeStatus(item.deleteFlag,item,index)"></i-switch></td>
                <td style="text-align: center"><a @click="turnToDetail(item)">查看详细</a></td>
        </tr>
        </tbody>
    </table>
</div>

<script src="../js/ajax.js"></script>
<script src="../js/jquery-2.1.1.min.js"></script>
<script src="../js/jquery-2.0.0.min.js"></script>
<script src="../js/common.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/vue.min.js"></script>
<script src="../js/iview.min.js"></script>
<script src="../js/homepage.js"></script>

<script type="text/javascript">
    var app = new Vue({
        el: "#app",
        data:{
            blogList:[],
        }

    });

    $(document).ready(function(){
        var url="<%=basePath%>/info_system/getMyBlogList";
        ajaxGet(url,function(res){
            if(res.code=="success"){
                app.blogList=res.data;
                for(var i=0;i<res.data.length;i++){
                    app.blogList[i].blogTime=getTime(app.blogList[i].blogTime);
                    if(app.blogList[i].deleteFlag==1){
                        app.blogList[i].deleteFlag=true;
                    }else{
                        app.blogList[i].deleteFlag=false;
                    }
                }
            }
        },null,false)
    });

    function changeStatus(deleteFlag,item,index){
        var data={
            deleteFlag:deleteFlag,
            blogId:item.blogId
        };
        var url="<%=basePath%>/info_system/updateDeleteFlag";
        ajaxPost(url,data,function(res){
            if(res.code=="success"){
                app.blogList[index].deleteFlag=res.data;
            }
        },null,false)
    }

    function turnToDetail(item){
        console.log("进入方法");
        parent.app.page="<%=basePath%>/info_system/blogDetail?blogId="+item.blogId;
    }

</script>
</body>
</html>
