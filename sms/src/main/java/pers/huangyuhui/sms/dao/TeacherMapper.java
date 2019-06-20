package pers.huangyuhui.sms.dao;

import pers.huangyuhui.sms.bean.LoginForm;
import pers.huangyuhui.sms.bean.Teacher;

import java.util.List;

/**
 * @project: sms
 * @description: 数据访问层-操控学生信息
 * @author: 黄宇辉
 * @date: 6/18/2019-9:47 AM
 * @version: 1.0
 * @website: https://yubuntu0109.github.io/
 */
public interface TeacherMapper {

    // TODO: 6/18/2019 验证登录信息是否正确
    Teacher login(LoginForm loginForm);

    // TODO: 6/18/2019 根据教师与班级名查询指定/全部教师信息列表
    List<Teacher> selectList(Teacher teacher);

    // TODO: 6/19/2019 根据工号查询指定教师信息
    Teacher findByTno(Teacher teacher);

    // TODO: 6/18/2019 添加教师信息
    int insert(Teacher teacher);

    // TODO: 6/18/2019 根据id修改指定教师信息 
    int update(Teacher teacher);

    // TODO: 6/18/2019 根据id修改指定教师密码
    int updatePassword(Teacher teacher);

    // TODO: 6/18/2019 根据id删除指定教师信息  
    int deleteById(Integer[] ids);

}
