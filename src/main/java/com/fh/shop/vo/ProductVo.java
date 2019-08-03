package com.fh.shop.vo;


import lombok.Data;

import java.io.Serializable;

@Data
public class ProductVo implements Serializable {
    private static final long serialVersionUID = -5190299472183528863L;
    private  Integer id;
    private  String proName;
    private  float price;
    private String createDate;
    private Integer b;
    private String typeName;
    private Integer gc1;
    private Integer gc2;
    private Integer gc3;
    private String imgurl;
    private String sonimg;
    private Integer ishot;
    private Integer upOrDownOrDelete;
}
