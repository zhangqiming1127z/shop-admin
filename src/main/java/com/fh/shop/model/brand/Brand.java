package com.fh.shop.model.brand;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

@Data
public class Brand implements Serializable {
    private static final long serialVersionUID = 2011031871580837660L;
    private Integer id;
    private String brandName;
    @DateTimeFormat(pattern = "yyyy")
    private Date CreateTime;
    private String imgurl;
    private Integer sort;
    private Integer recommend;

}
