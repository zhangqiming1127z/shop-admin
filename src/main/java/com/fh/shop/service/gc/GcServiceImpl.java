package com.fh.shop.service.gc;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.dao.gc.IGcDao;
import com.fh.shop.model.product.Product;
import com.fh.shop.parameter.ProductCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.utils.DateUtil;
import org.utils.redis.RedisUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("gcService")
public class GcServiceImpl implements IGcService{
    @Autowired
    private IGcDao iGcDao;
    @Override
    public Map queryDeleteProduct(ProductCondition pcn) {
        String gcList = RedisUtil.getRedisValue("gcList");
        String rGCount = RedisUtil.getRedisValue("gCount");
        if (gcList==null  && rGCount==null ){
            List list = iGcDao.queryDeleteProduct(pcn);
            Integer count = iGcDao.queryCount(pcn);
            String s = JSONObject.toJSONString(list);
            String gCount = JSONObject.toJSONString(count);
            RedisUtil.setRedisValue("gcList",s);
            RedisUtil.setRedisValue("gCount",gCount);
            List data = createData(list, pcn);
            Map map = biuldData(pcn, data, count);
            return map;
        }
        List<Product> pgcList = JSONObject.parseArray(gcList, Product.class);
        Object count = JSONObject.parse(rGCount);
        List data = createData(pgcList, pcn);
        Map map = biuldData(pcn, data, count);
        return map;
    }

    @Override
    public void restore(String[] array) {
        RedisUtil.delRedisValue("gcList");
        RedisUtil.delRedisValue("gCount");
        iGcDao.restore(array);
    }

    private Map biuldData(ProductCondition pcn, List gclist, Object count) {
        Map map = new HashMap();
        map.put("draw", pcn.getDraw());
        map.put("recordsFiltered", count);
        map.put("recordsTotal", count);
        map.put("data", gclist);
        return map;
    }

    private List createData(List<Product> proList, ProductCondition productCondition) {
        List list = new ArrayList();
        for (Product product : proList) {
            Map map = new HashMap();
            map.put("id", product.getId());
            map.put("productName", product.getProName());
            map.put("productPrice", product.getPrice());
            map.put("createDate", DateUtil.date2String(product.getCreateDate(), DateUtil.Y_M_D));
            map.put("bName", product.getBrand().getBrandName());
            map.put("imgurl", product.getImgurl());
            map.put("typeName",product.getTypeName());
            map.put("ishot",product.getIshot());
            map.put("upOrDownOrDelete",product.getUpOrDownOrDelete());
            list.add(map);
        }
        return list;
    }
}
