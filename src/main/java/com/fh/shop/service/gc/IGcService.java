package com.fh.shop.service.gc;

import com.fh.shop.parameter.ProductCondition;

import java.util.Map;

public interface IGcService {
   Map queryDeleteProduct(ProductCondition pcn);

    void restore(String[] array);


}
