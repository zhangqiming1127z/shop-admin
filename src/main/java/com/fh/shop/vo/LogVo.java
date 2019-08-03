package com.fh.shop.vo;

import lombok.Data;

@Data
public class LogVo {
    private Integer id;
    private String user;
    private String info;
    private String createDate;
    private Integer status;
    private String content;
    private String context;
}
