package pers.huangyuhui.sms.service;

import org.springframework.stereotype.Service;
import pers.huangyuhui.sms.bean.Grade;

import java.util.List;

/**
 * @project: sms
 * @description: 业务层-操控年级信息
 * @author: 黄宇辉
 * @date: 6/14/2019-10:35 AM
 * @version: 1.0
 * @website: https://yubuntu0109.github.io/
 */
@Service
public interface GradeService {

    // TODO: 6/14/2019 根据年级名称查询指定/全部年级列表信息
    List<Grade> selectList(Grade gradename);

    // TODO: 6/15/2019 查询所有年级列表信息(用于在班级管理页面中获取年级信息)
    List<Grade> selectAll();

    // TODO: 6/14/2019 根据年级名称查询指定年级信息
    Grade findByName(String gradename);

    // TODO: 6/14/2019 添加年级信息
    int insert(Grade grade);

    // TODO: 6/14/2019 根据id修改指定年级信息
    int update(Grade grade);

    // TODO: 6/14/2019 根据id删除指定年级信息
    int deleteById(Integer[] ids);
}
