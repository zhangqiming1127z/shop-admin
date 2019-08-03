package com.fh.shop.service.area;

import com.fh.shop.model.area.Area;
import com.fh.shop.parameter.ProductCondition;

import java.util.List;

public interface IAreaService {
    List<Area> queryArea();

    void deleteZtree(Integer id);

    void updateArea(Area area);

    void addArea(Area area);
}
