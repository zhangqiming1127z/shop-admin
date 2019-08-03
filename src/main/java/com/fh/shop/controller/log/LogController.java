package com.fh.shop.controller.log;

import com.fh.shop.parameter.LogParam;
import com.fh.shop.service.log.ILogService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Map;

@Controller
public class LogController {
    @Resource(name = "logService")
    private ILogService logService;


    @RequestMapping("queryLog")
    public @ResponseBody Map queryLog(LogParam logParam){
        Map map =logService.queryLog(logParam);
        return map;
    }
}
