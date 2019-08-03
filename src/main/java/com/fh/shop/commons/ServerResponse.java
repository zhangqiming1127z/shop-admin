package com.fh.shop.commons;

import java.io.Serializable;

public class ServerResponse implements Serializable {
    private static final long serialVersionUID = -5086340582215218991L;
    private int code;
    private String msg;
    private Object data;

    private ServerResponse(int code, String msg, Object data){
        this.code =  code;
        this.msg = msg;
        this.data = data;
    }

    public static ServerResponse success(){
        return new ServerResponse(ResponseEmnu.SUCCESS.getCode(),ResponseEmnu.SUCCESS.getMsg(),null);
     }
    public static ServerResponse success(Object data){
        return new ServerResponse(ResponseEmnu.SUCCESS.getCode(),ResponseEmnu.SUCCESS.getMsg(),data);
    }
    public  static ServerResponse error(){
        return  new ServerResponse(ResponseEmnu.ERROR.getCode(),ResponseEmnu.ERROR.getMsg(),null);
    }
    public  static ServerResponse error(ResponseEmnu responseEmnu){
        return  new ServerResponse(responseEmnu.getCode(),responseEmnu.getMsg(),null);
    }
    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
