package pers.huangyuhui.sms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pers.huangyuhui.sms.bean.Grade;
import pers.huangyuhui.sms.dao.GradeMapper;
import pers.huangyuhui.sms.service.GradeService;

import java.util.List;

/**
 * @project: sms
 * @description: 业务层实现类-操控年级信息
 * @author: 黄宇辉
 * @date: 6/14/2019-10:33 AM
 * @version: 1.0
 * @website: https://yubuntu0109.github.io/
 */

@Service
public class GradeServiceImpl implements GradeService {

    //注入Mapper接口对象
    @Autowired
    private GradeMapper gradeMapper;

    @Override
    public List<Grade> selectList(Grade gradename) {
        return gradeMapper.selectList(gradename);
    }

    @Override
    public List<Grade> selectAll() {
        return gradeMapper.selectAll();
    }

    @Override
    public Grade findByName(String gradename) {
        return gradeMapper.findByName(gradename);
    }

    @Override
    public int insert(Grade grade) {
        return gradeMapper.insert(grade);
    }

    @Override
    public int update(Grade grade) {
        return gradeMapper.update(grade);
    }

    @Override
    public int deleteById(Integer[] ids) {
        return gradeMapper.deleteById(ids);
    }
}