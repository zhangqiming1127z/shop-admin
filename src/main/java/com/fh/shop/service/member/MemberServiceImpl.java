package com.fh.shop.service.member;

import com.fh.shop.commons.ServerResponse;
import com.fh.shop.commons.datatables.DataTableResult;
import com.fh.shop.dao.member.IMemberMapper;
import com.fh.shop.model.member.Member;
import com.fh.shop.parameter.MemberParam;
import com.fh.shop.vo.MemberVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.utils.DateUtil;

import java.util.ArrayList;
import java.util.List;

@Service("memberService")
public class MemberServiceImpl implements IMemberService {

    @Autowired
    private IMemberMapper memberMapper;

    public DataTableResult findMember(MemberParam mpm) {
       long count = memberMapper.queryCount(mpm);
       List<Member>list=memberMapper.queryList(mpm);
        List newList = builVo(list);
        DataTableResult dataTableResult = new DataTableResult(mpm.getDraw(),count,newList);
        return dataTableResult;
    }


    public void updateisforbidden(Integer id, Integer fid) {
        memberMapper.updateisforbidden(id,fid);
    }

    public ServerResponse findAreaById(Integer id) {
        List areaById = memberMapper.findAreaById(id);
        return ServerResponse.success(areaById);
    }

    private List builVo(List<Member> list) {
        List newList=new ArrayList();
        for (Member member : list) {
            MemberVo memberVo = new MemberVo();
            memberVo.setId(member.getId());
            memberVo.setUserName(member.getUserName());
            memberVo.setRealName(member.getRealName());
            memberVo.setBirthday(DateUtil.date2String(member.getBirthday(),DateUtil.Y_M_D));
            memberVo.setAname(member.getAname());
            memberVo.setIsforbidden(member.getIsforbidden());
            newList.add(member);
        }
        return newList;
    }
}
