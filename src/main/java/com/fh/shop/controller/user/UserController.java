package com.fh.shop.controller.user;

import com.fh.shop.Constant.Constant;
import com.fh.shop.commons.LogAnnotation;
import com.fh.shop.commons.ResultState;
import com.fh.shop.model.area.Area;
import com.fh.shop.model.user.User;
import com.fh.shop.parameter.UserParam;
import com.fh.shop.responseEnum.ResponseEnum;
import com.fh.shop.service.user.IUserService;
import com.fh.shop.vo.UserVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.utils.distributivesession.CookieUtil;
import org.utils.redis.RedisUtil;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

@Controller
//声明控制层
public class UserController {
    @Resource
    //注入service
    private IUserService iUserService;

    //用户登录
    @ResponseBody
    @RequestMapping("userLogin")
    public ResultState userLogin(UserParam userParam, HttpServletRequest request, HttpServletResponse response) {
        ResultState map = iUserService.login(userParam, request, response);
        return map;
    }

    //用户分页查询
    @ResponseBody
    @RequestMapping("queryUser")
    public Map queryUser(UserParam userParam) {
        Map map = iUserService.queryUser(userParam);
        return map;
    }

    //删除
    @LogAnnotation("删除用户")
    @ResponseBody
    @RequestMapping("deleteUser")
    public ResultState deleteUser(Integer id) {
        iUserService.deleteUser(id);
        return ResultState.success(ResponseEnum.SUCCESS);
    }

    //添加用户
    @LogAnnotation("添加用户")
    @ResponseBody
    @RequestMapping("addUser")
    public ResultState addUser(User user) {
        iUserService.addUser(user);
        return ResultState.success(ResponseEnum.SUCCESS);
    }

    //回显
    @ResponseBody
    @RequestMapping("findUserById")
    public ResultState findUserById(Integer id) {
        UserVo userVo = iUserService.findUserById(id);
        return ResultState.success(ResponseEnum.SUCCESS, userVo);
    }

    //修改用户
    @LogAnnotation("修改用户")
    @ResponseBody
    @RequestMapping("updateUser")
    public ResultState updateUser(User user) {
        iUserService.updateUser(user);
        return ResultState.success(ResponseEnum.SUCCESS);
    }

    @ResponseBody
    @RequestMapping("queryName")
    public ResultState queryName(String userName) {
        User user = iUserService.queryName(userName);
        //如果用户名不存在可以注册
        if (user == null) {
            return ResultState.success(ResponseEnum.SUCCESS);
            //如果用户名存在不可以注册
        }
        return ResultState.error(ResponseEnum.ERROR);
    }

    //注销用户登陆
    @ResponseBody
    @RequestMapping("offUser")
    public ResultState offUser(HttpServletResponse response, HttpServletRequest request) {
        Cookie cookie = new Cookie(Constant.USER_KEY, null);
        cookie.setMaxAge(0);
        cookie.setDomain(Constant.DOMAIN);
        cookie.setPath("/");
        response.addCookie(cookie);
        String s = CookieUtil.readCookie(Constant.USER_KEY, request);
        RedisUtil.delRedisValue(s);
        return ResultState.success(ResponseEnum.SUCCESS);
    }

    @ResponseBody
    @RequestMapping("threeArea")
    public ResultState queryArea(Integer pid) {
        List<Area> list = iUserService.queryArea(pid);
        return ResultState.success(ResponseEnum.SUCCESS, list);
    }
}
