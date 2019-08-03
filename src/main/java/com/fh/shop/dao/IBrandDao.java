package com.fh.shop.dao;

import com.fh.shop.model.brand.Brand;
import com.fh.shop.parameter.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IBrandDao {
    long queryCount();

    List<Brand> queryBrandList(Page page);

    void addBrand(Brand brand);

    void deleteBrand(Integer id);

    Brand findBrandById(Integer id);

    void updateBrand(Brand brand);

    List findBrand();

    void updateRecommend(@Param("id")Integer id,@Param("rid")Integer rid);
}
