package com.info_system.controller;

import com.info_system.dto.AjaxMessage;
import com.info_system.dto.MsgType;
import com.info_system.entity.*;
import com.info_system.service.BlogService;
import com.info_system.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping(value = "/info_system")
public class BlogController {
    @Autowired
    private BlogService blogService;
    @Autowired
    private UserService userService;

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

    @RequestMapping(value="/myBlogs")
    public String myBlog(HttpSession session,HttpServletRequest request){
        return "myBlogs";
    }

    @RequestMapping(value="/myComment")
    public String myComment(HttpServletRequest request,HttpSession session){
        return "myComment";
    }
    @RequestMapping(value="/addBlog")
    @ResponseBody
    public Object addBlog(HttpServletRequest request, Model model, HttpSession session){
        return blogService.addBlog(session,request);
    }


    @RequestMapping(value="/otherBlogs")
    public String otherBlogs(Model model,@RequestParam("userId") int userId){
        model.addAttribute("userId",userId);
        return "otherBlogs";
    }

    @RequestMapping(value="/getOtherBlogs")
    @ResponseBody
    public Object getOtherBlogs(@RequestParam("userId") int userId){
        User user=blogService.getDetailUserById(userId);
        List<Blog> blogList=blogService.getMyAllBlogs(userId);
        HashMap<String,Object> map=new HashMap<String, Object>();

        if(user!=null){
            map.put("user",user);
            map.put("blogList",blogList);
            return new AjaxMessage().Set(MsgType.Success,map);
        }

        return new AjaxMessage().Set(MsgType.Error,null);

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

    @RequestMapping(value="/blogDetail")
    public String  getBlogDetail(@RequestParam("blogId") int blogId,Model model){
        model.addAttribute("nowBlogId",blogId);
        return "blogDetail";
    }

    @RequestMapping(value="/getBlogItem")
    @ResponseBody
    public Object getBlogItem(@RequestParam("blogId") int blogId,HttpSession session){
        Blog blog=blogService.getBlogById(blogId);
        List<Comment> commentList=blogService.getCommentByBlogId(blogId);
        User user=(User) session.getAttribute("userSession");
        int  userId=user.getId();

        for(int i=0;i<commentList.size();i++){
            if(blogService.getCommentLikeCount(commentList.get(i).getCommentId())>0){
                commentList.get(i).setHasComment(true);
            }else{
                commentList.get(i).setHasComment(false);
            }
        }
        if(blogService.getLikeNumByUser(blogId,userId)>0){
            blog.setHasLike(true);
        }else{
            blog.setHasLike(false);
        }
        if(blogService.getCommentNumByUser(blogId,userId)>0){
            blog.setHasComment(true);
        }else{
            blog.setHasComment(false);
        }
        HashMap<String ,Object> map=new HashMap<String, Object>();
        map.put("blog",blog);
        map.put("commentList",commentList);
        map.put("userId",userId);
        if(map!=null){
            return new AjaxMessage().Set(MsgType.Success,map);
        }
        return new AjaxMessage().Set(MsgType.Error,null);
    }

    @RequestMapping(value="/addMyComment")
    @ResponseBody
    public Object addMyComment(HttpSession session,HttpServletRequest request){
        User user=(User)session.getAttribute("userSession");
        int userId=user.getId();
        String content=request.getParameter("commentContent");
        int blogId=Integer.parseInt(request.getParameter("blogId"));
        Date commentTime=new Date();
        Comment comment=new Comment();

        comment.setBlogId(blogId);
        comment.setCommentContent(content);
        comment.setUserId(userId);
        comment.setCommentTime(commentTime);

        int commentId=blogService.addMyComment(comment);
        commentId=comment.getCommentId();
        if(commentId>=0){
            Comment newCom=blogService.getCommentByCommentId(commentId);
            return new AjaxMessage().Set(MsgType.Success,"提交成功",newCom);
        }
        return new AjaxMessage().Set(MsgType.Error,"添加失败",null);
    }

    @RequestMapping(value="/deleteCommentLike")
    @ResponseBody
    public Object deleteCommentLike(HttpSession session,HttpServletRequest request){
        int commentId=Integer.parseInt(request.getParameter("commentId"));
        User user=(User) session.getAttribute("userSession");
        int userId=user.getId();
        if(blogService.deleteCommentByCommentAndUser(commentId,userId)>=0){
            return new AjaxMessage().Set(MsgType.Success,null);
        }
        return new AjaxMessage().Set(MsgType.Error,null);
    }

    @RequestMapping(value="/addCommentLike")
    @ResponseBody
    public Object addCommentLike(HttpServletRequest request,HttpSession session){
        User user=(User) session.getAttribute("userSession");
        int userId=user.getId();
        int commentId=Integer.parseInt(request.getParameter("commentId"));
        LikeComment likeComment=new LikeComment();
        likeComment.setCommentId(commentId);
        likeComment.setUserId(userId);
        if(blogService.insertCommentLikeByUserAndComment(likeComment)>=0){
            return new AjaxMessage().Set(MsgType.Error,null);
        }
        return new AjaxMessage().Set(MsgType.Error,null);
    }

    @RequestMapping(value="/addBlogLike")
    @ResponseBody
    public Object addBlogLike(HttpSession session,HttpServletRequest request){
        User user=(User) session.getAttribute("userSession");
        int userId=user.getId();
        int blogId=Integer.parseInt(request.getParameter("blogId"));
        LikeBlog likeBlog=new LikeBlog();
        likeBlog.setBlogId(blogId);
        likeBlog.setUserId(userId);
        if(blogService.addBlogLike(likeBlog)>=0){
            return new AjaxMessage().Set(MsgType.Success,null);
        }
        return new AjaxMessage().Set(MsgType.Error,null);
    }

    @RequestMapping(value="/deleteBlogLike")
    @ResponseBody
    public Object deleteBlogLike(HttpServletRequest request,HttpSession session){
        User user=(User) session.getAttribute("userSession");
        int userId=user.getId();
        int blogId=Integer.parseInt(request.getParameter("blogId"));
        if(blogService.deleteBlogLike(blogId,userId)>=0){
            return new AjaxMessage().Set(MsgType.Success,null);
        }
        return new AjaxMessage().Set(MsgType.Error,null);
    }

    @RequestMapping(value="/getMyBlogList")
    @ResponseBody
    public Object getMyBlogList(HttpSession session){
        User user=(User) session.getAttribute("userSession");
        int userId=user.getId();
        List<Blog> blogList=blogService.getMyAllBlogs(userId);
        if(blogList.size()>=0){
            return new AjaxMessage().Set(MsgType.Success,blogList);
        }
        return new AjaxMessage().Set(MsgType.Error,null);
    }

    @RequestMapping(value="/updateDeleteFlag")
    @ResponseBody
    public Object updateDeleteFlag(HttpServletRequest request){
        String deleteFlag=request.getParameter("deleteFlag");
        int blogId=Integer.parseInt(request.getParameter("blogId"));
        int flag=0;
        boolean flagB;
        if(deleteFlag.equals("true")){
            flag=1;
            flagB=true;
        }else{
            flag=0;
            flagB=false;
        }
        if(blogService.updateDeleteFlag(flag,blogId)>=0){
           return new AjaxMessage().Set(MsgType.Success,flagB);
        }
        return new AjaxMessage().Set(MsgType.Error,null);
    }

    @RequestMapping(value="/getMyComments")
    @ResponseBody
    public Object getMyComments(HttpSession session){
        User user=(User) session.getAttribute("userSession");
        int userId=user.getId();
        List<Comment> commentList=blogService.getMyComments(userId);
        if(commentList.size()>=0){
            return new AjaxMessage().Set(MsgType.Success,commentList);
        }
        return new AjaxMessage().Set(MsgType.Error,null);
    }

    @RequestMapping(value="/updateCommentDeleteFlag")
    @ResponseBody
    public Object updateCommentDeleteFlag(HttpSession session,HttpServletRequest request){
        String deleteFlag=request.getParameter("deleteFlag");
        int commentId=Integer.parseInt(request.getParameter("commentId"));
        int flag=0;
        boolean flagB;
        if(deleteFlag.equals("true")){
            flag=1;
            flagB=true;
        }else{
            flag=0;
            flagB=false;
        }
        if(blogService.updateCommentDeleteFlag(flag,commentId)>=0){
            return new AjaxMessage().Set(MsgType.Success,flagB);
        }
        return new AjaxMessage().Set(MsgType.Error,null);
    }


    @RequestMapping(value="/getAllUserList")
    @ResponseBody
    public Object getAllUserList(HttpServletRequest request){
        List<User> userList=blogService.getAllUser();
        if(userList.size()>=0){
            return new AjaxMessage().Set(MsgType.Success,userList);
        }
        return new AjaxMessage().Set(MsgType.Error,null);
    }
}
