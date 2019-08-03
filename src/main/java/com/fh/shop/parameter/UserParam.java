package com.fh.shop.parameter;

import lombok.Data;


@Data
public class UserParam extends Page{
    private Integer id;
    private String userName;
    private String userPassWord;
    private String  realName;
    private String birthday;
    private Integer sex;
    private String  minDate;
    private String maxDate;
    private String phone;
    private String mail;
    private String photo;
    private Integer study;
    private Integer nation;
    private String idNumber;
    private Integer province;
    private Integer city;
    private Integer county;
    private String site;
    private String areaName;
    private String code;
}
