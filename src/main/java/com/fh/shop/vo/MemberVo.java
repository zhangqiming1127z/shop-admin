package com.fh.shop.vo;

import lombok.Data;

import java.io.Serializable;
@Data
public class MemberVo implements Serializable {
    private  Integer id;
    private String userName;
    private String passWord;
    private String realName;
    private String birthday;
    private String phoneNumber;
    private String mail;
    private Integer dq1;
    private Integer dq2;
    private Integer dq3;
    private String aname;
    private Integer isforbidden;
}
