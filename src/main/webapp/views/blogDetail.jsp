<%--
  Created by IntelliJ IDEA.
  User: 折一架铁飞机
  Date: 2018/11/29
  Time: 11:41
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
    <title>博文详细</title>
    <link rel="stylesheet" type="text/css" href="//unpkg.com/iview/dist/styles/iview.css">
    <link rel="stylesheet" type="text/css" href="../css/layout.css">
    <link href="../css/bootstrap.min.css" rel="stylesheet">
<style>
    .goods-item-img{
        width:550px;
        height:500px;
    }
</style>
</head>
<body>
<div v-cloak id="app">
    <div style="border:solid 0.1pt;padding:10px;border-color: #E5DDDB;width:90%;margin-left:5%">
        <Row style="margin-top:30px;margin-left:20px">
            <i-col span="3" style="text-align: right">
                <a @click="turnToDetailUser(userId)"><Avatar icon="ios-person" size="large" /></a>
            </i-col>
            <i-col span="18" offset="1">
                <Row>
                    <i-col span="6" style="text-align: left">
                        <span style="font-size: 18pt">{{blog.user.userName}}</span>
                        <p>{{blog.blogTime}}</p>
                    </i-col>
                    <i-col span="4" offset="12" v-if="userId!=blog.user.userId">
                        <i-button style="width:100px">关注</i-button>
                    </i-col>
                </Row>

                <Row style="margin-top:6px">
                    <i-col span="6">
                        <span style="font-size:20pt">{{blog.blogTitle}}</span>
                    </i-col>
                </Row>
                <Row>
                    <span style="font-size: 13pt">{{blog.blogContent}}</span>
                </Row>
                <Row :v-if="blog.blog_pic">
                    <img :src="'<%=basePath%>'+blog.blog_pic" class="goods-item-img">
                </Row>
            </i-col>
        </Row>
        <hr/>
        <Row style="margin-top:20px">
            <i-col span="12" style="text-align: center">

                    <div v-if="blog.hasLike">
                        <a @click="doLike()"><Icon type="md-thumbs-up" color="#2d8cf0"/></a>
                        <span style="margin-left:20px">{{blog.likeCount}}</span>
                    </div>
                    <div v-else>
                        <a @click="doLike()"><Icon type="md-thumbs-up" color="#A3A2A1"/></a>
                        <span style="margin-left:20px">{{blog.likeCount}}</span>
                    </div>

            </i-col>
            <i-col span="1" style="text-align: center;">
                <table style="height:25px;border-color:#000000;border-left-style:solid;border-width:1px"><tr><td valign="top"></td></tr></table>
            </i-col>
            <i-col span="11" style="text-align: center">
                    <div v-if="blog.hasComment">
                        <a><Icon type="md-chatboxes" color="#2d8cf0"/></a>
                        <span style="margin-left:20px">{{blog.commentCount}}</span>
                    </div>
                    <div v-else>
                        <a><Icon type="md-chatboxes" color="#A3A2A1"/></a>
                        <span style="margin-left:20px">{{blog.commentCount}}</span>
                    </div>

            </i-col>
        </Row>

        <hr/>

        <span style="font-size:15pt">评论</span>
        <hr/>
        <Row>
            <i-input v-model="myComment" type="textarea" :rows="4" placeholder="发表我的评论" />
        </Row>
       <Row>
           <i-button type="info" @click="submitMyComment" style="margin-top:15px;">发表</i-button>
       </Row>

        <hr/>

        <div v-for="(item,index) in commentList">
            <Row>
                <i-col span="3" style="text-align: right">
                   <a @click="turnToDetailUser(item.user.id)"><Avatar shape="square" icon="ios-person" /></a>
                </i-col>
                <i-col span="18" offset="1">
                    <Row>
                        <i-col span="6" style="text-align: left">
                            <span style="font-size: 12pt">{{item.user.username}}</span>
                            <p>{{item.commentTime}}</p>
                        </i-col>
                    </Row>
                    <Row>
                        <i-col span="18">
                            <p>{{item.commentContent}}</p>
                        </i-col>
                        <i-col span="4" v-if="item.hasComment">
                            <a @click="doLikeComment(item,index)"><Icon type="md-thumbs-up" color="#2d8cf0"/></a>
                            <span style="margin-left:10px">{{item.commentCount}}</span>
                        </i-col>
                        <i-col span="4" v-else>
                            <a @click="doLikeComment(item,index)"><Icon type="md-thumbs-up" color="#A3A2A1"/></a>
                            <span style="margin-left:10px">{{item.commentCount}}</span>
                        </i-col>
                    </Row>
                </i-col>
            </Row>
            <hr/>
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
            userId:'',
            blogId:'${nowBlogId}',//获取当前的博客ID
            commentList:[],
            myComment:'',//我的评论
            blog:{
                user:{
                    userId:0,
                    userName:'',
                },
                blogTitle:'',
                blogContent:'',
                blogTime:'',
                blog_pic:'',
                likeCount:0,
                commentCount:0,
                hasLike:false,
                hasComment:false
            }
        }
    });

    $(document).ready(function(){
        ajaxGet("<%=basePath%>/info_system/getBlogItem?blogId="+app.blogId,function(res){
            if(res.code=="success"){
                app.userId=res.data.userId;
                app.blog.user.userId=res.data.blog.user.userId;
                app.blog.user.userName=res.data.blog.user.username;
                app.blog.blogTitle=res.data.blog.blogTitle;
                app.blog.blogContent=res.data.blog.blogContent;
                app.blog.blogTime=getTime(res.data.blog.blogTime);
                app.blog.blog_pic=res.data.blog.blogPic;
                app.blog.hasLike=res.data.blog.hasLike;
                app.blog.hasComment=res.data.blog.hasComment;
                app.blog.likeCount=res.data.blog.likeCount;
                app.blog.commentCount=res.data.blog.commentCount;

                for(var i=0;i<res.data.commentList.length;i++){
                    if(res.data.commentList[i].commentTime!=null){
                        res.data.commentList[i].commentTime=getTime(res.data.commentList[i].commentTime);
                    }
                    app.commentList.push(res.data.commentList[i]);
                }
                console.log(app.commentList);
            }
        },null,false);
    })

    //给博客点赞
    function doLike(){
        var data={
            blogId:app.blogId
        };

        if(app.blog.hasLike==true){
            app.blog.hasLike=false;
            app.blog.likeCount-=1;
            ajaxPost("<%=basePath%>/info_system/deleteBlogLike",data,function(res){

            },null,false);
        }else{
            app.blog.hasLike=true;
            app.blog.likeCount+=1;
            ajaxPost("<%=basePath%>/info_system/addBlogLike",data,function(res){

            },null,false);
        }
        //发送请求改变后端数据库的点赞
    }

    //给评论点赞
    function doLikeComment(item,index){
        var data={
            commentId:item.commentId
        };
        if(item.hasComment==true){
            //取消点赞
            app.commentList[index].hasComment=false;
            app.commentList[index].commentCount-=1;
            ajaxPost("<%=basePath%>/info_system/deleteCommentLike",data,function(res){

            },null,false);
        }else{
            //添加点赞
            app.commentList[index].hasComment=true;
            app.commentList[index].commentCount+=1;
            ajaxPost("<%=basePath%>/info_system/addCommentLike",data,function(res){

            },null,false);
        }

    }

    //发表我的评论
    function submitMyComment(){
        var url="<%=basePath%>/info_system/addMyComment";
        var data={
            blogId:app.blogId,
            commentContent:app.myComment
        };
        //构造一个假得评论插入前端数组，可以在不刷新得情况下看到自己发布得评论
        ajaxPost(url,data,function(res){
            if(res.code=="success"){
                console.log(res.data);
                app.commentList.push(res.data);
            }
        },null,false);

    }

    //跳转到用户详细页面
    function turnToDetailUser(userId){
        console.log(userId);
        parent.app.page="<%=basePath%>/info_system/otherBlogs?userId="+userId;
    }

</script>
</body>
</html>
