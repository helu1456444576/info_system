package com.info_system.dao;

import com.info_system.entity.Blog;
import com.info_system.entity.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BanUserDao {
    List<User> listUser();
    List<Blog> listBlog();
    void changeUser(User user);
    void changeBlog(Blog blog);
}
