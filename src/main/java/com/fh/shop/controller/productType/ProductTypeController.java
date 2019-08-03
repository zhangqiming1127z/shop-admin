package com.fh.shop.controller.productType;

import com.fh.shop.commons.ResultState;
import com.fh.shop.model.productType.ProductType;
import com.fh.shop.parameter.ProductCondition;
import com.fh.shop.responseEnum.ResponseEnum;
import com.fh.shop.service.productType.IProductTypeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ProductTypeController {
    @Resource(name = "productTypeService")
    private IProductTypeService productTypeService;


    /**
     * 按商品分类做类型的Ztree树
     *
     * @return
     */
    @RequestMapping("queryProClass")
    @ResponseBody
    public ResultState queryProductType() {
        List ztreeList = productTypeService.queryProductType();
        return ResultState.success(ResponseEnum.SUCCESS, ztreeList);
    }

    /**
     * ztree添加
     *
     * @param productType
     * @return
     */
    @RequestMapping("addType")
    @ResponseBody
    public ResultState addType(ProductType productType) {
        productTypeService.addType(productType);
        Map map =new HashMap<>();
        map.put("id",productType.getId());
        map.put("name",productType.getTypeName());
        map.put("pid",productType.getPid());
        return ResultState.success(ResponseEnum.SUCCESS,map);
    }

    /**
     * @param id
     * @return
     */
    @RequestMapping("deleteZtree")
    @ResponseBody
    public ResultState deleteZtree(Integer id) {
        productTypeService.deleteZtree(id);
        return ResultState.success(ResponseEnum.SUCCESS);
    }

    @RequestMapping("updateType")
    @ResponseBody
    public ResultState updateType(ProductType productType) {
        productTypeService.updateType(productType);
        return ResultState.success(ResponseEnum.SUCCESS);
    }

    @RequestMapping("firstType")
    @ResponseBody
    public ResultState firstType(Integer id) {
        List list = productTypeService.queryFirstType(id);
        return ResultState.success(ResponseEnum.SUCCESS, list);
    }


    @RequestMapping("twoType")
    @ResponseBody
    public ResultState twoType(Integer id) {
        List list = productTypeService.queryTwoType(id);
        return ResultState.success(ResponseEnum.SUCCESS, list);
    }

    @RequestMapping("threeType")
    @ResponseBody
    public ResultState threeType(Integer twoId) {
        List list = productTypeService.queryThreeType(twoId);
        return ResultState.success(ResponseEnum.SUCCESS, list);
    }

}
