package com.fh.shop.dao;

import com.fh.shop.model.log.Log;
import com.fh.shop.parameter.LogParam;

import java.util.List;

public interface ILogDao {
    void addLog(Log logInfo);

    List<Log> queryLog(LogParam logParam);

    Long queryCount(LogParam logParam);
}
