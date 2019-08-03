package com.fh.shop.controller.skip;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SkipController {
    //公共的跳转页面方法
    @RequestMapping("skipJsp")
    public  String skipJsp(String url){
        return url;
    }
}
