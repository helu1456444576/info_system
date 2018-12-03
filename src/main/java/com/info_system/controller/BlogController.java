package com.info_system.controller;

import com.info_system.dto.AjaxMessage;
import com.info_system.dto.MsgType;
import com.info_system.entity.Blog;
import com.info_system.entity.User;
import com.info_system.service.BlogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping(value = "/info_system")
public class BlogController {
    @Autowired
    private BlogService blogService;

    @RequestMapping(value = "/sendBlog")
    public String sendBlog(HttpSession session, HttpServletRequest request)
    {
        return "sendBlog";
    }

    @RequestMapping(value = "/home")
    public String home(HttpSession session, HttpServletRequest request)
    {
        return "home";
    }

    @RequestMapping(value="/addBlog")
    @ResponseBody
    public Object addBlog(HttpServletRequest request, Model model, HttpSession session){
        return blogService.addBlog(session,request);
    }

    @RequestMapping(value="/getAllBlogs")
    @ResponseBody
    public Object getAllBlogs(HttpSession session){
        List<Blog> blogList=blogService.getAllBlogs();
        User user=(User) session.getAttribute("userSession");
        int  userId=user.getId();
        for(int i=0;i<blogList.size();i++){
            int blogId=blogList.get(i).getBlogId();
            if(blogService.getLikeNumByUser(blogId,userId)>0){
                blogList.get(i).setHasLike(true);
            }else{
                blogList.get(i).setHasLike(false);
            }
            if(blogService.getCommentNumByUser(blogId,userId)>0){
                blogList.get(i).setHasComment(true);
            }else{
                blogList.get(i).setHasComment(false);
            }
        }
        if(blogList.size()>=0){
            return new AjaxMessage().Set(MsgType.Success,blogList);
        }
        return new AjaxMessage().Set(MsgType.Error,null);
    }
}
