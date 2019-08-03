package com.fh.shop.model.area;

import lombok.Data;

import java.io.Serializable;

@Data
public class Area  implements Serializable {
    private Integer id;
    private String name;
    private Integer pId;
}
