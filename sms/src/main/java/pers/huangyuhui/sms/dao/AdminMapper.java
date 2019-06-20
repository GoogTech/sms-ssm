package pers.huangyuhui.sms.dao;

import pers.huangyuhui.sms.bean.Admin;
import pers.huangyuhui.sms.bean.LoginForm;

import java.util.List;

/**
 * @project: sms
 * @description: 数据访问层-操控管理员信息
 * @author: 黄宇辉
 * @date: 6/10/2019-3:51 PM
 * @version: 1.0
 * @website: https://yubuntu0109.github.io/
 */
public interface AdminMapper {

    // TODO: 6/18/2019 验证登录信息是否正确
    Admin login(LoginForm loginForm);

    // TODO: 6/12/2019 通过姓名查询指定管理员信息
    Admin findByName(String name);

    // TODO: 6/12/2019 添加管理员信息
    int insert(Admin admin);

    // TODO: 6/12/2019 根据姓名查询指定/所有管理员信息列表
    List<Admin> selectList(Admin admin);

    // TODO: 6/13/2019 根据id更新指定管理员信息
    int update(Admin admin);

    // TODO: 6/18/2019 根据id修改指定管理员密码
    int updatePassword(Admin admin);

    // TODO: 6/13/2019 根据id删除指定管理员信息
    int deleteById(Integer[] ids);

}