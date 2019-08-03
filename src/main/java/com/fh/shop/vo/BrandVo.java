package com.fh.shop.vo;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;


@Data
public class BrandVo implements Serializable {
    private static final long serialVersionUID = 1841302992136116624L;
    private Integer id;
    private String brandName;
    private String CreateTime;
    private  String imgurl;
    private Integer recommend;
    private Integer sort;
}
