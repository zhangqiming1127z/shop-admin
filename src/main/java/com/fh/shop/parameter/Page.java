package com.fh.shop.parameter;

import lombok.Data;

@Data
public class Page {
    private  Integer draw;
    private  Integer start;
    private  Integer length;
}
