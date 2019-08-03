package com.fh.shop.dao;

import com.fh.shop.model.brand.Brand;
import com.fh.shop.model.product.Product;
import com.fh.shop.parameter.ProductCondition;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IDao {
    long queryCount(ProductCondition productCondition);

    List queryProductData(ProductCondition productCondition);

    void deletePro(Integer id);

    Product getById(Integer id);

    void updatePro(Product product);

    void addProduct(Product product);

    void batchDelete(String[] array);

    long queryCount1(ProductCondition productCondition);

    List<Product> queryProductData1(ProductCondition productCondition);

    List<Product> exportExcel(ProductCondition productCondition);

    void addBrand(Brand brand);

    void addProduct2(List<Product> productList);

    List<Brand> queryBrandList();

    void upOrDown(@Param("id")Integer id, @Param("upId")Integer upId);
}
