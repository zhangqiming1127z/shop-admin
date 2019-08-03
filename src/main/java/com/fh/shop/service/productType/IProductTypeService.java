package com.fh.shop.service.productType;

import com.fh.shop.model.productType.ProductType;
import com.fh.shop.parameter.ProductCondition;

import java.util.List;

public interface IProductTypeService {

    List queryProductType();

    void addType(ProductType productType);

    void deleteZtree(Integer id);

    void updateType(ProductType productType);


    List queryFirstType(Integer id);

    List queryTwoType(Integer id);

    List queryThreeType(Integer twoId);
}
