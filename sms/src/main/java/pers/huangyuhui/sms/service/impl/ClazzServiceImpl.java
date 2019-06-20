package pers.huangyuhui.sms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pers.huangyuhui.sms.bean.Clazz;
import pers.huangyuhui.sms.dao.ClazzMapper;
import pers.huangyuhui.sms.service.ClazzService;

import java.util.List;

/**
 * @project: sms
 * @description: 业务层实现类-操控班级信息
 * @author: 黄宇辉
 * @date: 6/14/2019-5:09 PM
 * @version: 1.0
 * @website: https://yubuntu0109.github.io/
 */
@Service
public class ClazzServiceImpl implements ClazzService {

    //注入Mapper接口对象
    @Autowired
    private ClazzMapper clazzMapper;

    @Override
    public List<Clazz> selectList(Clazz clazz) { return clazzMapper.selectList(clazz); }

    @Override
    public List<Clazz> selectAll() {
        return clazzMapper.selectAll();
    }

    @Override
    public Clazz findByName(String name) {
        return clazzMapper.findByName(name);
    }

    @Override
    public int insert(Clazz clazz) {
        return clazzMapper.insert(clazz);
    }

    @Override
    public int update(Clazz clazz) {
        return clazzMapper.update(clazz);
    }

    @Override
    public int deleteById(Integer[] ids) {
        return clazzMapper.deleteById(ids);
    }
}
