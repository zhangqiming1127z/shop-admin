package com.fh.shop.model.member;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;
@Data
public class Member implements Serializable {
    private static final long serialVersionUID = 265338351882134847L;
    private  Integer id;
    private String userName;
    private String passWord;
    private String realName;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birthday;
    private String phoneNumber;
    private String mail;
    private Integer dq1;
    private Integer dq2;
    private Integer dq3;
    private String aname;
    private Integer isforbidden;
}
