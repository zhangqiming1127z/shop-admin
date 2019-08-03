package com.fh.shop.dao.member;

import com.fh.shop.parameter.MemberParam;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IMemberMapper {


    long queryCount(MemberParam mpm);

    List queryList(MemberParam mpm);

    void updateisforbidden(@Param("id") Integer id, @Param("fid")Integer fid);

    List findAreaById(Integer id);
}
