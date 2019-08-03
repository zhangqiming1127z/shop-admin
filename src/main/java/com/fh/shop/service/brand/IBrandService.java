package com.fh.shop.service.brand;

import com.fh.shop.commons.datatables.DataTableResult;
import com.fh.shop.model.brand.Brand;
import com.fh.shop.parameter.Page;
import com.fh.shop.vo.BrandVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface IBrandService {
    DataTableResult queryBrandList(Page page);

    void addBrand(Brand brand);

    void deleteBrand(Integer id);

    BrandVo findBrandById(Integer id);

    void updateBrand(Brand brand);

    List findBrand();

    void updateRecommend( Integer id, Integer rid);
}
