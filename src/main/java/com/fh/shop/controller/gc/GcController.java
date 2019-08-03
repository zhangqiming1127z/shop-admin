package com.fh.shop.controller.gc;

import com.fh.shop.commons.ServerResponse;
import com.fh.shop.parameter.ProductCondition;
import com.fh.shop.service.gc.IGcService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Map;

@RestController
public class GcController {
        @Resource(name = "gcService")
        private IGcService gcService;

        @RequestMapping(value = "/trashRecycling")
        public Map trashRecycling(ProductCondition pcn){
           Map gcList=gcService.queryDeleteProduct(pcn);
            return gcList;
        }
        @RequestMapping(value = "/restore")
        public ServerResponse restore(@RequestParam(value = "array[]") String[] array){
            gcService.restore(array);
            return ServerResponse.success();
        }

}
