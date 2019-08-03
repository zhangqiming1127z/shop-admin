package com.fh.shop.service.member;

import com.fh.shop.commons.ServerResponse;
import com.fh.shop.commons.datatables.DataTableResult;
import com.fh.shop.parameter.MemberParam;

public interface IMemberService {
    DataTableResult findMember(MemberParam mpm);

    void updateisforbidden(Integer id, Integer fid);

    ServerResponse findAreaById(Integer id);
}
