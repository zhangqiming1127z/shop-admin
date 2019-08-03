package com.fh.shop.dao;

import com.fh.shop.model.area.Area;
import com.fh.shop.model.user.User;
import com.fh.shop.parameter.UserParam;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface IUserDao {
    User queryUserName(String userName);

    long queryCount(UserParam userParam);

    List queryUserList(UserParam userParam);

    void deleteUser(Integer id);

    void addUser(User user);

    User findUserById(Integer id);

    void updateUser(User user);

    User queryName(String userName);



    void updateUserLoginTime(@Param("date") Date date,@Param("id") Integer id);

    List<Area> queryArea(Integer pid);
}
