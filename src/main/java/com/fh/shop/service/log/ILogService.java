package com.fh.shop.service.log;

import com.fh.shop.model.log.Log;
import com.fh.shop.parameter.LogParam;
import com.fh.shop.vo.LogVo;

import java.util.Map;

public interface ILogService {

    void addLog(Log logInfo);

    Map queryLog(LogParam logParam);
}
