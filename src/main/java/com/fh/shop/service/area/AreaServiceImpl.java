package com.fh.shop.service.area;

import com.fh.shop.dao.IAreaDao;
import com.fh.shop.model.area.Area;
import com.fh.shop.parameter.ProductCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("areaService")
public class AreaServiceImpl implements IAreaService {
    @Autowired
    private IAreaDao areaDao;
    public List<Area> queryArea() {
        List<Area>list=areaDao.queryArea();
        List areaList = getList(list);
        return areaList;
    }

    //  删除
    public void deleteZtree(Integer id) {
        areaDao.deleteZtree(id);
    }

     //修改
    public void updateArea(Area area) {
        areaDao.updateArea(area);
    }

    @Override
    public void addArea(Area area) {
        areaDao.addArea(area);
    }

    private List getList(List<Area> list) {
        List areaList = new ArrayList<>();
        for (Area lista : list) {
            Map map = new HashMap();
            map.put("id",lista.getId());
            map.put("pId",lista.getPId());
            map.put("name",lista.getName());
            areaList.add(map);
        }
        return areaList;
    }
}
