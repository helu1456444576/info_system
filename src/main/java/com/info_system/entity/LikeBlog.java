package com.info_system.entity;

public class LikeBlog {
    private int likeId;
    private Blog blog;
    private User user;

    public int getLikeId() {
        return likeId;
    }

    public void setLikeId(int likeId) {
        this.likeId = likeId;
    }

    public Blog getBlog() {
        return blog;
    }

    public void setBlog(Blog blog) {
        this.blog = blog;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "LikeBlog{" +
                "likeId=" + likeId +
                ", blog=" + blog +
                ", user=" + user +
                '}';
    }
}
