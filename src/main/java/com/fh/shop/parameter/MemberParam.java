package com.fh.shop.parameter;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
@Data
public class MemberParam extends Page{
    private String userName;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date minbirthday;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date maxbirthday;
    private Integer dq1;
    private Integer dq2;
    private Integer dq3;
    private Integer isforbidden;
}
