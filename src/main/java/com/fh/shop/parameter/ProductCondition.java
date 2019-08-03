package com.fh.shop.parameter;

import lombok.Data;

@Data
public class ProductCondition extends Page{
    private String proName;
    private Float minPrice;
    private Float maxPrice;
    private String minDate;
    private String maxDate;
    private Integer b;
    private String typeId;
    private Integer gc1;
    private Integer gc2;
    private Integer gc3;
    private Integer ishot;
    private Integer upOrDownOrDelete;
}
