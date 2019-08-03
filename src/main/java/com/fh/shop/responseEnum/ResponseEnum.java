package com.fh.shop.responseEnum;

/*枚举   返回值定义类*/
public enum ResponseEnum {
    NAME(201,"用户名不存在"),
    PASSWD(202,"密码错误"),
    ERROR(400,"error"),
    SUCCESS(200,"ok"),
    NAME_PASSWORD_NULL(222,"用户名或密码不存在"),
    CODE_IS_NOT(223,"验证码为空"),
    CODE_IS_ERROR(224,"验证码错误"),
    NAME_ISOK(444,"用户名已存在");
    private Integer code;

    private String mag;

    ResponseEnum(Integer code, String mag) {
        this.code = code;
        this.mag = mag;
    }

    public Integer getCode() {
        return code;
    }

    public String getMag() {
        return mag;
    }
}
