package com.fh.shop.controller.member;

import com.fh.shop.commons.ServerResponse;
import com.fh.shop.commons.datatables.DataTableResult;
import com.fh.shop.parameter.MemberParam;
import com.fh.shop.service.member.IMemberService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
public class MemberController {
    @Resource(name = "memberService")
    private IMemberService memberService;

    @RequestMapping("/findMember")
    public DataTableResult findMember(MemberParam mpm){
        DataTableResult member = memberService.findMember(mpm);
        return member;
    }
    @RequestMapping("/updateisforbidden")
    public ServerResponse updateisforbidden(Integer id,Integer fid){
        memberService.updateisforbidden(id,fid);
        return ServerResponse.success();
    }

    @RequestMapping(value = "/findAreaById")
    public ServerResponse findAreaById(Integer id){
        return memberService.findAreaById(id);
    }
}
