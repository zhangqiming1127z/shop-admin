package com.fh.shop.commons;

import com.fh.shop.responseEnum.ResponseEnum;

import java.io.Serializable;

public class ResultState implements Serializable {

    private static final long serialVersionUID = 3012240901655776768L;
    private Integer code;

    private String mag;

    private Object data;

    private ResultState(Integer code, String mag) {
        this.code = code;
        this.mag = mag;
    }
    private ResultState(Integer code, String mag, Object data) {
        this.code = code;
        this.mag = mag;
        this.data = data;
    }
    public static ResultState name(){
        return  new ResultState(ResponseEnum.NAME.getCode(), ResponseEnum.NAME.getMag());
    };
    public static ResultState passwd(){
        return  new ResultState(ResponseEnum.PASSWD.getCode(), ResponseEnum.PASSWD.getMag());
    };

    /*成功   无参*/
    public static ResultState success(ResponseEnum responseEnum){
       return  new ResultState(responseEnum.getCode(),responseEnum.getMag());
    };
    /*成功   有参*/
   public static ResultState success(ResponseEnum responseEnum,Object data){
       return new ResultState(ResponseEnum.SUCCESS.getCode(), ResponseEnum.SUCCESS.getMag(), data);
    };
   /*失败   无参*/
    public static ResultState error(ResponseEnum responseEnum){
        return  new ResultState(responseEnum.getCode(),responseEnum.getMag());
    }
   /*失败   有参*/
    public static ResultState error(Object data){
        return  new ResultState(ResponseEnum.ERROR.getCode(), ResponseEnum.ERROR.getMag(), data);
    }


    public Integer getCode() {
        return code;
    }

    public String getMag() {
        return mag;
    }

    public Object getData() {
        return data;
    }
}
