package com.info_system.dao;

import com.info_system.entity.Blog;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BlogDao {

     int updateByPrimaryKey(Blog blog);
     int addBlog(Blog blog);

     List<Blog> getAllBlogs();
     int getLikeNumByUser(@Param("blogId") int blogId,  @Param("userId") int userId);
     int getCommentNumByUser(@Param("blogId") int blogId,  @Param("userId") int userId);
}
