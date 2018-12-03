<%--
  Created by IntelliJ IDEA.
  User: 折一架铁飞机
  Date: 2018/11/29
  Time: 11:40
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
    <title>发博文</title>
    <link rel="stylesheet" type="text/css" href="//unpkg.com/iview/dist/styles/iview.css">
    <link rel="stylesheet" type="text/css" href="../css/layout.css">
    <link href="../css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div v-cloak id="app">
    <Row>
        <i-col span="12" offset="6">
            <i-form :model="formContent" :rules="validate" ref="form">
                <form-item label="标题:" prop="blogTitle">
                    <i-input v-model="formContent.blogTitle" placeholder="输入标题" style="width:30%"></i-input>
                </form-item>
                <form-item label="内容:" prop="blogContent">
                    <i-input v-model="formContent.blogContent" type="textarea" :autosize="{minRows: 7,maxRows: 10}" placeholder="输入内容" style="width:80%"></i-input>
                </form-item>
                <form-item label="图片：" prop="goodsPic">
                    <%--<i-Input v-model="goods.goodsPic" type="text" maxlength="255" ></i-Input>--%>
                    <div style="width: 350px;height:200px;">
                        <Upload style="width: 100%;height: 100%;"
                                accept="image/*"
                                :before-upload="handleBeforeUploadPic"
                                :show-upload-list="false">
                            <i-Button  style="width: 100%;height: 100%;" v-if="!hasPic"><Icon type="ios-add" size="100" ></Icon></i-Button>
                            <img :src="photo.src" style="width: 100%;height: 100%;" v-else/>
                        </Upload>
                    </div>
                </form-item>
                <form-item>
                    <Row>
                        <i-col span="5" offset="14">
                            <i-button style="margin-left: 8px">Cancel</i-button>

                        </i-col>
                        <i-col span="5">
                            <i-button type="primary" @click="submit">Submit</i-button>
                        </i-col>
                    </Row>

                </form-item>

            </i-form>
        </i-col>

    </Row>

</div>
<script src="../js/ajax.js"></script>
<script src="../js/jquery-2.1.1.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/vue.min.js"></script>
<script src="../js/iview.min.js"></script>
<script type="text/javascript">
    var app = new Vue({
        el: "#app",
        data:{
            formContent:{
                blogTitle:"",
                blogContent:""
            },
            photo:{
                src:"",
                file:null,
            },
            hasPic:false,
            // 验证规则
            validate: {
                blogTitle:[{required: true, message: '标题不能为空', trigger: 'blur' }],
                blogContent:[{required: true, message: '内容不能为空', trigger: 'blur' }],
            }
        }
    })

    //此函数放在app内部无作用，原因不明
    function handleBeforeUploadPic(file)
    {
        if (file.size > 10485760) {
            app.$Message.warning("照片大小超过限制");
            return false;
        }
        if (file.type.indexOf("image") != 0) {
            app.$Message.warning("文件类型不支持");
            return false;
        }
        var reader = new FileReader();
        reader.onload = function (e) {
            app.photo.src = e.target.result;
            app.photo.file = file;
        };
        reader.readAsDataURL(file);
        app.hasPic=true;
        return false;
    }


    // 提交表单
    function submit() {

        app.$refs["form"].validate(function (valid) {
            if (valid)
            {
                var formdata=new FormData();
                if(app.photo.file!=null)
                {
                    formdata.append('uploadFile', app.photo.file);
                }
                formdata.append("blog",JSON.stringify(app.formContent));
                $.ajax({
                    type : 'post',
                    url : "/info_system/addBlog",
                    data : formdata,
                    cache : false,
                    processData : false, // 不处理发送的数据，因为data值是Formdata对象，不需要对数据做处理
                    contentType : false, // 不设置Content-type请求头
                    success : function(rep)
                    {
                        if(rep.code=="success")
                        {
                            app.formContent.blogTitle="";
                            app.formContent.blogContent="";
                           app.$Message.success(rep.message);
                        }
                        else //显示错误信息
                        {
                            app.$Message.error(rep.message);
                        }
                    },
                    error : function()
                    {
                        app.$Message.error("请求出错");
                    }
                });
            }
            else
            {

                app.$Message.error('请正确填写信息!');
            }
        });

    }
</script>
</body>

</html>
