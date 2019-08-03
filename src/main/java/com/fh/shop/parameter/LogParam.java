package com.fh.shop.parameter;

import lombok.Data;


@Data
public class LogParam extends Page{
    private String user;
    private Integer status;
    private String content;
    private String minDate;
    private String maxDate;
}
