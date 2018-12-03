package com.info_system.service;
import com.alibaba.fastjson.JSONObject;
import com.info_system.dao.BlogDao;
import com.info_system.dto.AjaxMessage;
import com.info_system.dto.MsgType;
import com.info_system.entity.Blog;
import com.info_system.entity.User;


import com.info_system.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Service
public class BlogService {

    @Autowired
    private BlogDao  blogDao;
    public Object addBlog(HttpSession session, HttpServletRequest request){
        User user= (User) session.getAttribute("userSession");
        String param=request.getParameter("blog");
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        MultipartFile file=multipartRequest.getFile("uploadFile");
        String fileName="";
        if(file!=null)
        {
            String directory="/upload/blog/"+user.getId()+"/";
            fileName= FileUtils.writeToServer(request,directory,file);
        }

        JSONObject obj= JSONObject.parseObject(param);
        Blog blog=JSONObject.toJavaObject(obj,Blog.class);

        if(blog.getBlogId()>0)//修改商品
        {
            if(file!=null)
            {
                FileUtils.deleteFile(request.getSession().getServletContext().getRealPath("/")+blog.getBlogPic());
                blog.setBlogPic(fileName);
            }
            if(blogDao.updateByPrimaryKey(blog)>0)
            {
                return new AjaxMessage().Set(MsgType.Success,"商品信息修改成功",null);
            }
            else
            {
                return new AjaxMessage().Set(MsgType.Success, "商品信息修改失败", null);
            }
        }
        else//新增商品
        {
            blog.setBlogPic(fileName);
            blog.setUser(user);
            Date dateTime=new Date();
            blog.setBlogTime(dateTime);
            blog.setDeleteFlag(0);
            if(blogDao.addBlog(blog)>0)
            {
                return new AjaxMessage().Set(MsgType.Success,"添加成功！",null);
            }
            else
            {
                return new AjaxMessage().Set(MsgType.Error, "添加失败", null);
            }
        }
    }

    public List<Blog> getAllBlogs(){
        return blogDao.getAllBlogs();
    }

    public int getLikeNumByUser(int blogId,int userId){
        return blogDao.getLikeNumByUser( blogId, userId);
    }

    public int getCommentNumByUser(int blogId,int userId){
        return blogDao.getCommentNumByUser(blogId,userId);
    }

}
