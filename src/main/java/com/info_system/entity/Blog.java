package com.info_system.entity;

import java.util.Date;

public class Blog {
    private int blogId;
    private String blogTitle;
    private String blogContent;
    private User user;
    private Date blogTime;
    private int deleteFlag;

    private String blogPic;

    private boolean hasLike;//判断当前用户是否有点赞该博文
    private boolean hasComment;//判断当前用户是否有评论该博文

    public boolean isHasLike() {
        return hasLike;
    }

    public void setHasLike(boolean hasLike) {
        this.hasLike = hasLike;
    }

    public boolean isHasComment() {
        return hasComment;
    }

    public void setHasComment(boolean hasComment) {
        this.hasComment = hasComment;
    }

    private int likeCount;
    private int commentCount;

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }

    public int getCommentCount() {
        return commentCount;
    }

    public void setCommentCount(int commentCount) {
        this.commentCount = commentCount;
    }

    public String getBlogPic() {
        return blogPic;
    }

    public void setBlogPic(String blogPic) {
        this.blogPic = blogPic;
    }

    public int getBlogId() {
        return blogId;
    }

    public void setBlogId(int blogId) {
        this.blogId = blogId;
    }

    public String getBlogTitle() {
        return blogTitle;
    }

    public void setBlogTitle(String blogTitle) {
        this.blogTitle = blogTitle;
    }

    public String getBlogContent() {
        return blogContent;
    }

    public void setBlogContent(String blogContent) {
        this.blogContent = blogContent;
    }


    public Date getBlogTime() {
        return blogTime;
    }

    public void setBlogTime(Date blogTime) {
        this.blogTime = blogTime;
    }

    public int getDeleteFlag() {
        return deleteFlag;
    }

    public void setDeleteFlag(int deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "Blog{" +
                "blogId=" + blogId +
                ", blogTitle='" + blogTitle + '\'' +
                ", blogContent='" + blogContent + '\'' +
                ", user=" + user +
                ", blogTime=" + blogTime +
                ", deleteFlag=" + deleteFlag +
                ", blogPic='" + blogPic + '\'' +
                ", hasLike=" + hasLike +
                ", hasComment=" + hasComment +
                ", likeCount=" + likeCount +
                ", commentCount=" + commentCount +
                '}';
    }
}
