package com.fh.shop.Aop;


import com.fh.shop.commons.LogAnnotation;
import com.fh.shop.commons.VariableInfo;
import com.fh.shop.commons.WebContext;
import com.fh.shop.model.log.Log;
import com.fh.shop.model.user.User;

import com.fh.shop.service.log.ILogService;

import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;

public class LogAspect {
    private static final Logger LOGGER = LoggerFactory.getLogger(LogAspect.class);
    @Resource(name = "logService")
    private ILogService logService;

    //aop环绕通知
    public Object roundMethod(ProceedingJoinPoint joinPoint) {
        //拿到session中的信息

        HttpServletRequest request1 = WebContext.getRequest();
        HttpSession session = request1.getSession();
        User user = (User) session.getAttribute("user");

        Object proceed = null;
        //获取类名，自定义注解的内容
        String name = joinPoint.getSignature().getName();
        String canonicalName = joinPoint.getTarget().getClass().getCanonicalName();
        String val = "";
        MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();
        Method method = methodSignature.getMethod();
        if (method.isAnnotationPresent(LogAnnotation.class)) {
            LogAnnotation annotation = method.getAnnotation(LogAnnotation.class);
            val = annotation.value();
        }

        //拼接字符串
        String info = canonicalName + name;
        try {
            HttpServletRequest request = WebContext.getRequest();
            String sbrr = getString(request);
            LOGGER.info(canonicalName + "的" + name + "方法开始执行");
            proceed = joinPoint.proceed();
            LOGGER.info(canonicalName + "的" + name + "方法执行成功");
            Log logInfo = buildLog(user, canonicalName, info, sbrr, val);
            logService.addLog(logInfo);
        } catch (Throwable throwable) {
            throwable.printStackTrace();
            LOGGER.info(canonicalName + "的" + name + "方法执行失败");
            Log logInfo = new Log();
        }
        return proceed;
    }

    private String getString(HttpServletRequest request) {
        Map<String, String[]> parameterMap = request.getParameterMap();
        Iterator<Map.Entry<String, String[]>> iterator = parameterMap.entrySet().iterator();
        StringBuffer sbr = new StringBuffer();
        String sbrr = null;
        while (iterator.hasNext()) {
            Map.Entry<String, String[]> next = iterator.next();
            String key = next.getKey();
            String[] value = next.getValue();
            sbr.append(key).append("=").append(StringUtils.join(value, ",")).append(",");
            sbrr = sbr.toString();
        }
        return sbrr;
    }

    private Log buildLog(User user, String canonicalName, String info, String sbrr, String val) {
        com.fh.shop.model.log.Log logInfo = new Log();
        logInfo.setCreateDate(new Date());
        logInfo.setUser(user.getUserName());
        logInfo.setInfo(info);
        logInfo.setStatus(VariableInfo.SUCCESSSTATUS);
        logInfo.setContext(sbrr);
        logInfo.setContent(val);
        return logInfo;
    }
}
