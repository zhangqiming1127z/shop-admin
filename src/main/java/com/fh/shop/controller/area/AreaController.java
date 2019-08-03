package com.fh.shop.controller.area;

import com.fh.shop.commons.ResultState;
import com.fh.shop.model.area.Area;
import com.fh.shop.parameter.ProductCondition;
import com.fh.shop.responseEnum.ResponseEnum;
import com.fh.shop.service.area.IAreaService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class AreaController {
    @Resource(name = "areaService")
    private IAreaService areaService;

    /**
     *  简单数据类型ztree
     * @return
     */
    @ResponseBody
    @RequestMapping("queryArea")
    public ResultState queryArea(){
        List<Area> list = areaService.queryArea();
        return ResultState.success(ResponseEnum.SUCCESS,list);
    }

    @ResponseBody
    @RequestMapping("deleteArea")
    public ResultState deleteZtree(Integer id){
        areaService.deleteZtree(id);
        return ResultState.success(ResponseEnum.SUCCESS);
    }
    @ResponseBody
    @RequestMapping("updateArea")
    public ResultState updateArea(Area area){
        areaService.updateArea(area);
        return ResultState.success(ResponseEnum.SUCCESS);
    }

    @RequestMapping("addArea")
    @ResponseBody
    public ResultState addArea (Area area){
        areaService.addArea(area);
        return ResultState.success(ResponseEnum.SUCCESS,area);
    }
}
