package pers.huangyuhui.sms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pers.huangyuhui.sms.bean.Admin;
import pers.huangyuhui.sms.bean.LoginForm;
import pers.huangyuhui.sms.dao.AdminMapper;
import pers.huangyuhui.sms.service.AdminService;

import java.util.List;

/**
 * @project: sms
 * @description: 业务层实现类-操控管理员信息
 * @author: 黄宇辉
 * @date: 6/10/2019-3:52 PM
 * @version: 1.0
 * @website: https://yubuntu0109.github.io/
 */

@Service
public class AdminServiceImpl implements AdminService {

    //注入Mapper接口对象
    @Autowired
    private AdminMapper adminMapper;

    @Override
    public Admin login(LoginForm loginForm) { return adminMapper.login(loginForm); }

    @Override
    public List<Admin> selectList(Admin admin) {
        return adminMapper.selectList(admin);
    }

    @Override
    public Admin findByName(String name) {
        return adminMapper.findByName(name);
    }

    @Override
    public int insert(Admin admin) {
        return adminMapper.insert(admin);
    }

    @Override
    public int update(Admin admin) { return adminMapper.update(admin); }

    @Override
    public int updatePassowrd(Admin admin) {
        return adminMapper.updatePassword(admin);
    }

    @Override
    public int deleteById(Integer[] ids) {
        return adminMapper.deleteById(ids);
    }

}

