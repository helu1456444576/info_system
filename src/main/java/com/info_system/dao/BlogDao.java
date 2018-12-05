package com.info_system.dao;

import com.info_system.entity.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BlogDao {

     int updateByPrimaryKey(Blog blog);
     int addBlog(Blog blog);
     Blog getBlogById(int blogId);

     List<Blog> getAllBlogs();
     int getLikeNumByUser(@Param("blogId") int blogId,  @Param("userId") int userId);
     int getCommentNumByUser(@Param("blogId") int blogId,  @Param("userId") int userId);

     List<Comment> getCommentByBlogId(int blogId);

     int addMyComment(Comment comment);
     int getCommentLikeCount(int commentId);
     int deleteCommentByCommentAndUser(int commentId,int userId);
     int insertCommentLikeByUserAndComment(LikeComment likeComment);
     Comment getCommentByCommentId(int commentId);
     int addBlogLike(LikeBlog likeBlog);

     int deleteBlogLike(int blogId,int userId);
     List<Blog>getMyAllBlogs(int userId);

     int updateDeleteFlag(@Param("deleteFlag") int deleteFlag,@Param("blogId") int blogId);

     List<Comment> getMyComments(@Param("userId") int userId);
     int updateCommentDeleteFlag(@Param("deleteFlag") int deleteFlag,@Param("commentId") int commentId);

     User getDetailUserById(int userId);

     int getFansNumByUserId(int userId);

     int getBlogNumByUserId(int userId);

     List<User> getAllUser();

     int addInform(Inform inform);

     int addMessage(Message message);

}
