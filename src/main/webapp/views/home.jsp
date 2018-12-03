<%--
  Created by IntelliJ IDEA.
  User: 折一架铁飞机
  Date: 2018/11/29
  Time: 10:57
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
    <title>MICBLOG</title>
    <link rel="stylesheet" type="text/css" href="//unpkg.com/iview/dist/styles/iview.css">
    <link rel="stylesheet" type="text/css" href="../css/layout.css">
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <style>
        .goods-item-img{
            width:100%;
            height:160px
        }
    </style>
</head>
<body>
<div v-cloak id="app">
   <div style="margin-left:10%;width:80%;margin-right:10%">
       <carousel v-model="value1" loop style="width:100%;margin-top:30px" autoplay>
           <carousel-item>
               <img  src="../img/cat.jpg" alt="太帅 无法加载">
           </carousel-item>
           <carousel-item>
               <img  src="../img/cat.jpg" alt="太帅 无法加载">
           </carousel-item>
           <carousel-item>
               <img  src="../img/cat.jpg" alt="太帅 无法加载">
           </carousel-item>
           <carousel-item>
               <img  src="../img/cat.jpg" alt="太帅 无法加载">
           </carousel-item>
       </carousel>
       <div style="margin-top:30px;width:100%" v-for="item in allBlogList">
            <div>
                <Row>
                    <i-col span="6" v-if="item.blogPic!=null">
                        <div style="border:solid 0.1pt;padding:10px;border-color: #E5DDDB">
                            <img :src="'<%=basePath%>'+item.blogPic" class="goods-item-img">
                        </div>
                    </i-col>
                    <i-col span="17" offset="1" style="margin-top:10px">
                        <div><span style="font-size: 15pt">{{item.blogTitle}}</span></div>
                        <div style="height:100px">
                            <p>{{item.blogContent}}</p>
                        </div>
                        <div>
                            <Row>
                                <i-col span="1">
                                    <Avatar icon="ios-person" size="small" src="../img/cat.jpg" />
                                </i-col>
                                <i-col span="1">
                                    <span style="font-size: 10pt">{{item.user.username}}</span>
                                </i-col>
                                <i-col span="5" offset="1">
                                    <span style="font-size: 10pt">{{item.blogTime}}</span>
                                </i-col>
                                <i-col span="1" offset="10" v-if="item.hasLike">
                                    <a @click="doLike(item)"><Icon type="md-thumbs-up" color="#E34118"/></a>

                                </i-col>
                                <i-col span="1" offset="10" v-else>
                                    <a @click="doLike(item)"><Icon type="md-thumbs-up" color="#A3A2A1"/></a>
                                </i-col>
                                <i-col span="1">
                                    <span>{{item.likeCount}}&nbsp;&nbsp; |</span>
                                </i-col>

                                <i-col span="1" v-if="item.hasComment">
                                    &nbsp;
                                   <a @click="doComment(item)"><Icon type="md-chatboxes" color="#E34118"/></a>
                                </i-col>
                                <i-col span="1" v-else>
                                    &nbsp;
                                    <a @click="doComment(item)"><Icon type="md-chatboxes" color="#A3A2A1"/></a>
                                </i-col>

                                <i-col span="1">
                                    <span>{{item.commentCount}}</span>
                                </i-col>
                            </Row>
                        </div>

                    </i-col>
                </Row>
                <hr/>
            </div>
       </div>
   </div>
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
            value1:0,
            allBlogList:[],
        }
    });

    $(document).ready(function () {
        ajaxGet("/info_system/getAllBlogs",function(res){
            if(res.code=="success"){
                app.allBlogList=res.data;
                for(var i=0;i<app.allBlogList.length;i++){
                    //将时间戳转换为日期
                    app.allBlogList[i].blogTime=getTime(app.allBlogList[i].blogTime);
                }
                console.log(app.allBlogList);
            }
        },null,false);
    });

    //点赞
    function doLike(item){
        console.log("点击了方法");
        if(app.item.hasLike){
            app.item.hasLike=false;
            app.item.likeCount-=1;
        }else{
            app.item.hasLike=true;
            app.item.likeCount+=1;
        }
        //发送请求改变后端数据库的点赞

    }

    //评论
    function doComment(item){
        if(app.item.hasComment){
            app.item.hasComment=false;
            app.item.commentCount-=1;
        }else{
            app.item.hasComment=true;
            app.item.commentCount+=1;
        }
        //发送请求改变后端数据库的评论


    }
</script>
</body>
</html>
