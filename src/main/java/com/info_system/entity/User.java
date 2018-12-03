package com.info_system.entity;

public class User {
    private Integer id;
    private String username;
    private String password;
    private int deleteFlag;
    private int adminFlag;


    public int getAdminFlag() {
        return adminFlag;
    }

    public void setAdminFlag(int adminFlag) {
        this.adminFlag = adminFlag;
    }

    public User() {
        super();
    }

    public User(String name, String sex, String username, String password) {
        this.username = username;
        this.password = password;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }


    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getDeleteFlag() {
        return deleteFlag;
    }

    public void setDeleteFlag(int deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", deleteFlag=" + deleteFlag +
                '}';
    }
}
