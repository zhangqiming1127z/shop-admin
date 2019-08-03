package com.fh.shop.dao.gc;

import com.fh.shop.parameter.ProductCondition;

import java.util.List;

public interface IGcDao {
    List queryDeleteProduct(ProductCondition pcn);

    Integer queryCount(ProductCondition pcn);

    void restore(String[] array);
}
