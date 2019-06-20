package pers.huangyuhui.sms.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import pers.huangyuhui.sms.bean.Grade;
import pers.huangyuhui.sms.service.GradeService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @project: sms
 * @description: 控制器-管理年级信息页面
 * @author: 黄宇辉
 * @date: 6/14/2019-8:08 AM
 * @version: 1.0
 * @website: https://yubuntu0109.github.io/
 */

@Controller
@RequestMapping("/grade")
public class GradeController {

    // 注入业务对象
    @Autowired
    private GradeService gradeService;

    // 存储预返回页面的结果对象
    private Map<String, Object> result = new HashMap<>();

    /**
     * @description: 跳转到年级信息管理页面
     * @param: no
     * @date: 2019-06-14 8:12 AM
     * @return: java.lang.String
     */
    @GetMapping("/goGradeListView")
    public String goGradeListPage() {
        return "grade/gradeList";
    }

    /**
     * @description: 分页查询:根据年级名称获取指定/所有年级信息列表
     * @param: page
     * @param: rows
     * @param: gradename
     * @date: 2019-06-15 1:14 PM
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("/getGradeList")
    @ResponseBody
    public Map<String, Object> getGradeList(Integer page, Integer rows, String gradename) {

        //注意:使用Java Bean传递gradename,防止以下异常 !
        //org.springframework.web.util.NestedServletException: Request processing failed;
        // nested exception is org.mybatis.spring.MyBatisSystemException:
        // nested exception is org.apache.ibatis.reflection.ReflectionException:
        // There is no getter for property named 'name' in 'class java.lang.String'
        Grade grade = new Grade();
        grade.setName(gradename);

        //设置每页的记录数
        PageHelper.startPage(page, rows);
        //根据年级名称获取指定或全部年级信息列表
        List<Grade> list = gradeService.selectList(grade);
        //封装信息列表
        PageInfo<Grade> pageInfo = new PageInfo<>(list);
        //获取总记录数
        long total = pageInfo.getTotal();
        //获取当前页数据列表
        List<Grade> gradeList = pageInfo.getList();
        //存储数据对象
        result.put("total", total);
        result.put("rows", gradeList);

        return result;
    }


    /**
     * @description: 添加年级信息
     * @param: grade
     * @date: 2019-06-14 3:30 PM
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("/addGrade")
    @ResponseBody
    public Map<String, Object> addGrade(Grade grade) {
        //判断年级名是否已存在
        Grade name = gradeService.findByName(grade.getName());
        if (name == null) {
            if (gradeService.insert(grade) > 0) {
                result.put("success", true);
            } else {
                result.put("success", false);
                result.put("msg", "添加失败! (ಥ_ಥ)服务器端发生异常!");
            }
        } else {
            result.put("success", false);
            result.put("msg", "该年级名称已存在! 请修改后重试!");
        }

        return result;
    }

    /**
     * @description: 根据id修改指定的年级信息
     * @param: grade
     * @date: 2019-06-14 3:42 PM
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("/editGrade")
    @ResponseBody
    public Map<String, Object> editGrade(Grade grade) {
        //需排除用户只修改年级名以外的信息
        Grade g = gradeService.findByName(grade.getName());
        if (g != null) {
            if (!(grade.getId().equals(g.getId()))) {
                result.put("success", false);
                result.put("msg", "该年级名称已存在! 请修改后重试!");
                return result;
            }
        }
        //添加操作
        if (gradeService.update(grade) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "添加失败! (ಥ_ಥ)服务器端发生异常!");
        }
        return result;
    }


    /**
     * @description: 根据id删除指定的年级信息
     * @param: ids 拼接后的id
     * @date: 2019-06-14 3:44 PM
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("/deleteGrade")
    @ResponseBody
    public Map<String, Object> deleteGrade(@RequestParam(value = "ids[]", required = true) Integer[] ids) {

        if (gradeService.deleteById(ids) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
        }
        return result;
    }

}