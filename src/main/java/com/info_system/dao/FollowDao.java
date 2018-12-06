package com.info_system.dao;

import com.info_system.entity.Follow;
import com.info_system.entity.User;

import java.util.List;

public interface FollowDao {

    /**
     * 我关注的人
     * @param userId
     */
    List<Follow> listFollow(int userId);

    /**
     * 关注我的人
     * @param userId
     */
    List<Follow> listFans(int userId);

    /**
     * 我未关注的人
     * @param username
     */
    List<Follow> listUnFollow(String username);

    /**
     * 删除关注
     * @param followId
     */
    void deleteFollow(int followId);


    /**
     * 添加关注
     * @param follow
     */
    void addFollow(Follow follow);
}
