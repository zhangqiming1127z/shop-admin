package com.fh.shop.service.user;

import com.fh.shop.commons.ResultState;
import com.fh.shop.dao.IUserDao;
import com.fh.shop.model.area.Area;
import com.fh.shop.model.user.User;
import com.fh.shop.parameter.UserParam;
import com.fh.shop.responseEnum.ResponseEnum;
import com.fh.shop.vo.UserVo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.utils.DateUtil;
import org.utils.Md5Util;
import org.utils.distributivesession.BuildSession;
import org.utils.distributivesession.Constant;
import org.utils.redis.RedisUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

@Service
public class UserServiceImpl implements IUserService{
        @Autowired
        private IUserDao iUserDao;

    //用户登录
    public ResultState login(UserParam userParam, HttpServletRequest request, HttpServletResponse response) {
  /*      //获取共享session中的验证码
        String redisValue = RedisUtil.getRedisValue(BuildSession.getSessionId(request, response, Constant.CODE_KEY, Constant.DOMAIN));
        if (StringUtils.isEmpty(redisValue)){
            return ResultState.error(ResponseEnum.CODE_IS_NOT);
        }
        if (!redisValue.equals(userParam.getCode())){
            return ResultState.error(ResponseEnum.CODE_IS_ERROR);
        }*/
        //先根据用户名查询判断是否有改用户如果有继续查密码
        User user=iUserDao.queryUserName(userParam.getUserName());
        //判断是否有该用户
        if(user==null){
            return ResultState.error(ResponseEnum.NAME);
        }
        //如果有该用户判断输入的密码是否正确
        String salt = user.getSalt();
        if (!user.getUserPassWord().equals(Md5Util.md5(userParam.getUserPassWord()+salt))){
            return ResultState.error(ResponseEnum.PASSWD);
        }
        //全部验证通过相应前台
        BuildSession.distributiveSession(request,response,user,Constant.USER_KEY,Constant.DOMAIN,Constant.Login_TIME);
        iUserDao.updateUserLoginTime(new Date(),user.getId());
        return ResultState.success(ResponseEnum.SUCCESS);
    }




    public Map queryUser(UserParam userParam) {
        long count=iUserDao.queryCount(userParam);
        List<User> userList=iUserDao.queryUserList(userParam);
        List<UserVo> userVoList = getUserVos(userList);
        Map map = getMap(userParam, count, userVoList);
        return map;
    }

    @Override
    public void deleteUser(Integer id) {
        iUserDao.deleteUser(id);
    }

    @Override
    public void addUser(User user) {
        String salt = UUID.randomUUID().toString();
        user.setSalt(salt);
        user.setUserPassWord(Md5Util.md5(Md5Util.md5(user.getUserPassWord())+salt));
        iUserDao.addUser(user);
    }

    @Override
    public UserVo findUserById(Integer id) {
        User user=iUserDao.findUserById(id);
        UserVo userVo = getUserVo(user);
        return userVo;
    }

    @Override
    public void updateUser(User user) {
        iUserDao.updateUser(user);
    }

    @Override
    public User queryName(String userName) {
        return iUserDao.queryName(userName);
    }

    //三级联动
    public List<Area> queryArea(Integer pid) {
        return iUserDao.queryArea(pid);
    }

    private UserVo getUserVo(User user) {
        UserVo userVo=new UserVo();
        userVo.setId(user.getId());
        userVo.setSex(user.getSex());
        userVo.setUserName(user.getUserName());
        userVo.setUserPassWord(user.getUserPassWord());
        userVo.setRealName(user.getRealName());
        userVo.setBirthday(DateUtil.date2String(user.getBirthday(),DateUtil.Y_M_D));
        userVo.setAreaName(user.getAreaName());
        userVo.setPhone(user.getPhone());
        userVo.setPhoto(user.getPhoto());
        userVo.setIdNumber(user.getIdNumber());
        userVo.setSite(user.getSite());
        userVo.setMail(user.getMail());
        userVo.setNation(user.getNation());
        userVo.setStudy(user.getStudy());
        return userVo;
    }

    private Map getMap(UserParam userParam, long count, List<UserVo> userVoList) {
        Map map = new HashMap();
        map.put("draw",userParam.getDraw());
        map.put("recordsTotal",count);
        map.put("recordsFiltered",count);
        map.put("data",userVoList);
        return map;
    }

    private List<UserVo> getUserVos(List<User> userList) {
        List<UserVo> userVoList=new ArrayList<>();
        for (User user : userList) {
            UserVo userVo = new UserVo();
            userVo.setId(user.getId());
            userVo.setUserName(user.getUserName());
            userVo.setRealName(user.getRealName());
            userVo.setBirthday(DateUtil.date2String(user.getBirthday(),DateUtil.Y_M_D));
            userVo.setUserPassWord(user.getUserPassWord());
            userVo.setSex(user.getSex());
            userVo.setAreaName(user.getAreaName());
            userVo.setPhone(user.getPhone());
            userVo.setPhoto(user.getPhoto());
            userVo.setIdNumber(user.getIdNumber());
            userVo.setSite(user.getSite());
            userVo.setMail(user.getMail());
            userVo.setNation(user.getNation());
            userVo.setStudy(user.getStudy());
            userVoList.add(userVo);

        }
        return userVoList;
    }
}
