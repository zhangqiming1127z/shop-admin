package com.fh.shop.service.brand;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.commons.datatables.DataTableResult;
import com.fh.shop.dao.IBrandDao;
import com.fh.shop.model.brand.Brand;
import com.fh.shop.parameter.Page;
import com.fh.shop.vo.BrandVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.utils.DateUtil;
import org.utils.redis.RedisUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("brandService")
public class IBrandServiceImpl implements IBrandService {
        @Autowired
        private IBrandDao iBrandDao;

    public DataTableResult queryBrandList(Page page) {
        //查询总条数
        long count=iBrandDao.queryCount();
        //查询所有数据
        List<Brand> list=iBrandDao.queryBrandList(page);
        //组装数据
        List brandList = createData(list);
        //装配数据返给前台
        DataTableResult dataTableResult = new DataTableResult(page.getDraw(),count,brandList);
        return dataTableResult;
    }

    @Override
    public void addBrand(Brand brand) {
        iBrandDao.addBrand(brand);
    }

    @Override
    public void deleteBrand(Integer id) {
        iBrandDao.deleteBrand(id);
    }

    @Override
    public BrandVo findBrandById(Integer id) {
        Brand brand=iBrandDao.findBrandById(id);
        //重装数据
        BrandVo brandVo = buildDate(brand);
        return brandVo;
    }

    private BrandVo buildDate(Brand brand) {
        BrandVo brandVo = new BrandVo();
        brandVo.setId(brand.getId());
        brandVo.setBrandName(brand.getBrandName());
        brandVo.setCreateTime(DateUtil.date2String(brand.getCreateTime(),DateUtil.Y));
        brandVo.setImgurl(brand.getImgurl());
        brandVo.setSort(brand.getSort());
        return brandVo;
    }

    @Override
    public void updateBrand(Brand brand) {
        iBrandDao.updateBrand(brand);
    }

    @Override
    public List findBrand() {
        //先去redis中取key
        String brands = RedisUtil.getRedisValue("brand");
        //判断redis中是否有值
        if (brands==null){
            List<Brand> brandList=iBrandDao.findBrand();
            List brList = buildBrand(brandList);
            String s = JSONObject.toJSONString(brList);
            RedisUtil.setRedisValue("brand",s);
            return brList;
        }
        List brList = buildBrand(JSONObject.parseArray(brands,Brand.class));
        return brList;
    }


    public void updateRecommend(Integer id, Integer rid) {
        iBrandDao.updateRecommend(id,rid);
    }

    private List buildBrand(List<Brand> brandList) {
        List brList=new ArrayList();
        for (Brand brand : brandList) {
            Map map= new HashMap<>();
            map.put("id",brand.getId());
            map.put("brandName",brand.getBrandName());
            brList.add(map);
        }
        return brList;
    }


    private List createData(List<Brand> list) {
        List brandList = new ArrayList();
        for (Brand brand : list) {
            Map map = new HashMap();
            map.put("id",brand.getId());
            map.put("brandName",brand.getBrandName());
            map.put("createTime", DateUtil.date2String(brand.getCreateTime(),DateUtil.Y));
            map.put("imgurl",brand.getImgurl());
            map.put("recommend",brand.getRecommend());
            brandList.add(map);
        }
        return brandList;
    }
}
