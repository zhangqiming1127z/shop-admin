package com.fh.shop.service.productType;

import com.fh.shop.dao.IProductTypeDao;
import com.fh.shop.model.area.Area;
import com.fh.shop.model.productType.ProductType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("productTypeService")
public class ProductTypeServiceImpl implements IProductTypeService {

    @Autowired
    private IProductTypeDao productTypeDao;


    public List queryProductType() {
       List<ProductType>list=productTypeDao.queryProductType();
       List typeList = new ArrayList();

        for (ProductType productType : list) {
            Map map = new HashMap();
            map.put("id",productType.getId());
            map.put("pId",productType.getPid());
            map.put("name",productType.getTypeName());
            typeList.add(map);
        }
        return typeList ;
    }

    @Override
    public void addType(ProductType productType) {

        productTypeDao.addType(productType);
    }

    @Override
    public void deleteZtree(Integer id) {
        productTypeDao.deleteZtree(id);
    }

    @Override
    public void updateType(ProductType productType) {
        productTypeDao.updateType(productType);
    }

    //类型三级联动查询父id
    public List queryFirstType(Integer id) {
        List list = productTypeDao.queryFirstType(id);
        return list;
    }


    public List queryTwoType(Integer id) {
        return productTypeDao.queryTwoType(id);
    }

    @Override
    public List queryThreeType(Integer twoId) {
        return productTypeDao.queryThreeType(twoId);
    }



}
