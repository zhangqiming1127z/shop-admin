package com.fh.shop.service.log;

import com.fh.shop.dao.ILogDao;
import com.fh.shop.model.log.Log;
import com.fh.shop.parameter.LogParam;
import com.fh.shop.vo.LogVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.utils.DateUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("logService")
public class LogServiceImpl implements ILogService {
    @Autowired
    private ILogDao iLogDao;


    @Override
    public void addLog(Log logInfo) {
        iLogDao.addLog(logInfo);
    }

    @Override
    public Map queryLog(LogParam logParam) {
        List<Log> logList=iLogDao.queryLog(logParam);
        Long count=iLogDao.queryCount(logParam);
        List<LogVo> logListVo = getLogVos(logList);
        Map map = getMap(logParam, count, logListVo);
        return map;
    }

    private Map getMap(LogParam logParam, Long count, List<LogVo> logListVo) {
        Map map =new HashMap();
        map.put("draw",logParam.getDraw());
        map.put("recordsFiltered",count);
        map.put("recordsTotal",count);
        map.put("data",logListVo);
        return map;
    }

    private List<LogVo> getLogVos(List<Log> logList) {
        List<LogVo>logListVo=new ArrayList<>();
        for (Log log : logList) {
            LogVo logVo = new LogVo();
            logVo.setId(log.getId());
            logVo.setUser(log.getUser());
            logVo.setInfo(log.getInfo());
            logVo.setStatus(log.getStatus());
            logVo.setContent(log.getContent());
            logVo.setContext(log.getContext());
            logVo.setCreateDate(DateUtil.date2String(log.getCreateDate(),DateUtil.Y_M_D));
            logListVo.add(logVo);
        }
        return logListVo;
    }
}
