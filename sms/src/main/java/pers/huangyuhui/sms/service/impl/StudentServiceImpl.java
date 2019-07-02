package pers.huangyuhui.sms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pers.huangyuhui.sms.bean.LoginForm;
import pers.huangyuhui.sms.bean.Student;
import pers.huangyuhui.sms.dao.StudentMapper;
import pers.huangyuhui.sms.service.StudentService;

import java.util.List;

/**
 * @project: sms
 * @description: 业务层实现类-操控学生信息
 * @author: 黄宇辉
 * @date: 6/16/2019-10:51 AM
 * @version: 1.0
 * @website: https://yubuntu0109.github.io/
 */
@Service
@Transactional
public class StudentServiceImpl implements StudentService {

    //注入Mapper接口对象
    @Autowired
    private StudentMapper studentMapper;

    @Override
    public Student login(LoginForm loginForm) {
        return studentMapper.login(loginForm);
    }

    @Override
    public Student fingBySno(Student student) {
        return studentMapper.findBySno(student);
    }

    @Override
    public List<Student> selectList(Student student) {
        return studentMapper.selectList(student);
    }

    @Override
    public int insert(Student student) {
        return studentMapper.insert(student);
    }

    @Override
    public int update(Student student) {
        return studentMapper.update(student);
    }

    @Override
    public int updatePassowrd(Student student) {
        return studentMapper.updatePassword(student);
    }

    @Override
    public int deleteById(Integer[] ids) {
        return studentMapper.deleteById(ids);
    }
}
