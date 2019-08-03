package com.fh.shop.model.log;

import lombok.Data;

import java.util.Date;

@Data
public class Log {
    private Integer id;
    private String user;
    private String info;
    private Date createDate;
    private Integer status;
    private String content;
    private String context;
}
