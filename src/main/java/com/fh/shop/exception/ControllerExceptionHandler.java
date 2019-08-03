package com.fh.shop.exception;


import com.fh.shop.commons.ResultState;
import com.fh.shop.responseEnum.ResponseEnum;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
//用于拦截所有异常并统一处理
public class ControllerExceptionHandler {
    @ExceptionHandler(Exception.class)
    public ResultState exceptionHandler(Exception e){
        e.printStackTrace();
        return ResultState.error(ResponseEnum.ERROR);
    }
}
