package com.fh.shop.commons;

import javax.servlet.http.HttpServletRequest;

public class WebContext {
    private static ThreadLocal<HttpServletRequest> threadLocal = new ThreadLocal<>();

    public static void setThreadLocal(HttpServletRequest req){
        threadLocal.set(req);
    }

    public static HttpServletRequest getRequest(){
        return threadLocal.get();
    }
    public static void remove(){
        threadLocal.remove();
    }

}
