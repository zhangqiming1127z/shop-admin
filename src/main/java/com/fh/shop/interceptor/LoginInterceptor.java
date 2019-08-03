package com.fh.shop.interceptor;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.Constant.Constant;
import com.fh.shop.commons.VariableInfo;
import com.fh.shop.model.user.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.utils.distributivesession.CookieUtil;
import org.utils.redis.RedisUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor implements HandlerInterceptor{
    //拦截器
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //获取请求
        String requestURI = request.getRequestURI();
        //判断是否是登录请求
        if (requestURI.indexOf(VariableInfo.LOGIN_REQUEST) >= 0) {
            return true;//放开
        }
        if (RedisUtil.existsKey(Constant.USER_KEY)) {
            return false;
        }

        String readCookie = CookieUtil.readCookie(Constant.USER_KEY, request);
        String redisValue = RedisUtil.getRedisValue(readCookie);
        User user = JSONObject.parseObject(redisValue, User.class);
        if (redisValue != null && !"".equals(readCookie)) {
            RedisUtil.expire(Constant.USER_KEY, Constant.Login_TIME);
            //放开拦截
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            return true;
        } else {
            //没有登录跳转到登录页面
            response.sendRedirect(VariableInfo.LOGIN_PATH);
        }

        return false;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
