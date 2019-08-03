package com.fh.shop.service.user;

import com.fh.shop.commons.ResultState;
import com.fh.shop.model.area.Area;
import com.fh.shop.model.user.User;
import com.fh.shop.parameter.UserParam;
import com.fh.shop.vo.UserVo;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

public interface IUserService {
    ResultState login(UserParam userParam, HttpServletRequest request, HttpServletResponse response);

    Map queryUser(UserParam userParam);

    void deleteUser(Integer id);

    void addUser(User user);

    UserVo findUserById(Integer id);

    void updateUser(User user);

    User queryName(String userName);

    List<Area> queryArea(Integer pid);
}
