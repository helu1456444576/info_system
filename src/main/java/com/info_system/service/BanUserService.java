package com.info_system.service;

import com.info_system.dao.BanUserDao;
import com.info_system.dao.UserDao;
import com.info_system.entity.Blog;
import com.info_system.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BanUserService {

    @Autowired
    private BanUserDao banUserDao;

    public List<User> listUser() {
        System.out.println("listUser in BanUserService");
        return banUserDao.listUser();
    }

    public List<Blog> listBlog() {
        System.out.println("listBlog in BanUserService");
        return banUserDao.listBlog();
    }

    /**
     *
     * @param user
     */
    public void changeUser(User user) {
        System.out.println("changeUser in BanUserService");
        banUserDao.changeUser(user);
    }

    /**
     *
     * @param blog
     */
    public void changeBlog(Blog blog) {
        System.out.println("changeBlog in BanUserService");
        banUserDao.changeBlog(blog);
    }
}
