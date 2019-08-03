package com.fh.shop.commons.datatables;

import lombok.Data;

import java.util.List;

@Data
public class DataTableResult {
    private int draw;
    private long recordsFiltered;
    private long recordsTotal;
    private List data;

    public DataTableResult(int draw,long count, List data) {
        this.draw = draw;
        this.data = data;
        this.recordsFiltered = count;
        this.recordsTotal = count;
    }
}
