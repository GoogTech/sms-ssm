package pers.huangyuhui.sms.service;

import org.springframework.stereotype.Service;
import pers.huangyuhui.sms.bean.Clazz;

import java.util.List;

/**
 * @project: sms
 * @description: 业务层-操控班级信息
 * @author: 黄宇辉
 * @date: 6/14/2019-5:08 PM
 * @version: 1.0
 * @website: https://yubuntu0109.github.io/
 */
public interface ClazzService {

    // TODO: 6/14/2019 根据年级与班级名查询指定/全部班级信息列表
    List<Clazz> selectList(Clazz clazz);

    // TODO: 6/16/2019 查询所有班级信息列表(用于在学生管理页面中获取班级信息)
    List<Clazz> selectAll();

    // TODO: 6/15/2019 添加班级信息
    int insert(Clazz clazz);

    // TODO: 6/15/2019 根据id删除指定班级信息
    int deleteById(Integer[] ids);

    // TODO: 6/15/2019 根据班级名获取指定班级信息
    Clazz findByName(String name);

    // TODO: 6/15/2019 根据id修改指定班级信息
    int update(Clazz clazz);

}
