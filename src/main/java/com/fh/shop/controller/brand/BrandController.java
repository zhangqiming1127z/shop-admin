package com.fh.shop.controller.brand;

import com.fh.shop.commons.ResultState;
import com.fh.shop.commons.ServerResponse;
import com.fh.shop.commons.datatables.DataTableResult;
import com.fh.shop.model.brand.Brand;
import com.fh.shop.parameter.Page;
import com.fh.shop.responseEnum.ResponseEnum;
import com.fh.shop.service.brand.IBrandService;
import com.fh.shop.vo.BrandVo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
@CrossOrigin
@Controller//声明控制层
public class BrandController {
        @Resource(name = "brandService")
        private IBrandService iBrandService;
        //返回前台Json对象所以加上ResponseBody

        //RequestMapping和Url请求互相映射
        @RequestMapping("queryBrandList")
        public @ResponseBody
        DataTableResult queryBrandList(Page page){
                DataTableResult dataTableResult=iBrandService.queryBrandList(page);
                return dataTableResult;
        }
        @ResponseBody
        @RequestMapping("addBrand")
        public ResultState addBrand(Brand brand){

                iBrandService.addBrand(brand);

                return ResultState.success(ResponseEnum.SUCCESS);
        }
        @ResponseBody
        @RequestMapping("deleteBrand")
        public ResultState deleteBrand(Integer id){
                iBrandService.deleteBrand(id);

                return ResultState.success(ResponseEnum.SUCCESS);
        }

        @ResponseBody
        @RequestMapping("findBrandById")
        public ResultState findBrandById(Integer id){
                BrandVo brandVo=iBrandService.findBrandById(id);
                return ResultState.success(ResponseEnum.SUCCESS,brandVo);
        }
        @ResponseBody
        @RequestMapping("updateBrand")
        public ResultState updateBrand(Brand brand){

                iBrandService.updateBrand(brand);

                  return ResultState.success(ResponseEnum.SUCCESS);
        }
        @ResponseBody
        @RequestMapping("findBrand")
        public  ResultState findBrand(){
                List brandMap= iBrandService.findBrand();
                return ResultState.success(ResponseEnum.SUCCESS,brandMap);
        }
        @ResponseBody
        @RequestMapping("updateRecommend")
        public ServerResponse updateRecommend(Integer id,Integer rid){
                iBrandService.updateRecommend(id,rid);
                return ServerResponse.success();
        }
        }
