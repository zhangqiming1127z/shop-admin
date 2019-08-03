package com.fh.shop.parameter;

public enum ResponseEunm {
    SUCCESS(200,"成功",null),
    ERROR(-1,"失败",null);


    private Integer code;
    private String msg;
    private Object data;
    private ResponseEunm(Integer code,String msg,Object data){
        this.code=code;
        this.msg=msg;
        this.data=data;
    }


    public Integer getCode() {
        return code;
    }
    public String getMsg() {
        return msg;
    }


}
