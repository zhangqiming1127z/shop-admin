package com.fh.shop.dao;

import com.fh.shop.model.productType.ProductType;

import java.util.List;

public interface IProductTypeDao {
    List<ProductType> queryProductType();

    void addType(ProductType productType);

    void deleteZtree(Integer id);

    void updateType(ProductType productType);

    List queryFirstType(Integer id);

    List queryTwoType(Integer id);

    List queryThreeType(Integer twoId);
}
