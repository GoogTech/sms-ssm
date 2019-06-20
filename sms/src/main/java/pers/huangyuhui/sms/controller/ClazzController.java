package pers.huangyuhui.sms.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import pers.huangyuhui.sms.bean.Clazz;
import pers.huangyuhui.sms.service.ClazzService;
import pers.huangyuhui.sms.service.GradeService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @project: sms
 * @description: 控制器-管理班级信息页面
 * @author: 黄宇辉
 * @date: 6/14/2019-5:02 PM
 * @version: 1.0
 * @website: https://yubuntu0109.github.io/
 */
@Controller
@RequestMapping("/clazz")
public class ClazzController {

    //注入业务对象
    @Autowired
    private ClazzService clazzService;
    @Autowired
    private GradeService gradeService;

    //存储预返回页面的数据对象
    private Map<String, Object> result = new HashMap<>();


    /**
     * @description: 跳转到班级信息管理页面
     * @param: modelAndView
     * @date: 2019-06-15 2:02 PM
     * @return: org.springframework.web.servlet.ModelAndView
     */
    @GetMapping("/goClazzListView")
    public ModelAndView goClazzListPage(ModelAndView modelAndView) {
        //向页面发送一个存储着Grade的List对象
        modelAndView.addObject("gradeList", gradeService.selectAll());
        modelAndView.setViewName("clazz/clazzList");
        return modelAndView;
    }


    /**
     * @description: 分页查询班级信息列表:根据班级与年级名查询指定/全部班级信息列表
     * @param: page 当前页码
     * @param: rows 列表行数
     * @param: gradename 年级名称
     * @param: clazzname 班级名称
     * @date: 2019-06-14 10:00 PM
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("/getClazzList")
    @ResponseBody
    public Map<String, Object> getClazzList(Integer page, Integer rows, String clazzname, String gradename) {

        //存储查询的clazzname,gradename信息
        Clazz clazz = new Clazz(clazzname, gradename);
        //设置每页的记录数
        PageHelper.startPage(page, rows);
        //根据班级与年级名获取指定或全部班级信息列表
        List<Clazz> list = clazzService.selectList(clazz);
        //封装列表信息
        PageInfo<Clazz> pageInfo = new PageInfo<>(list);
        //获取总记录数
        long total = pageInfo.getTotal();
        //获取当前页数据列表
        List<Clazz> clazzList = pageInfo.getList();
        //存储数据对象
        result.put("total", total);
        result.put("rows", clazzList);

        return result;
    }


    /**
     * @description: 添加班级信息
     * @param: clazz
     * @date: 2019-06-15 2:23 PM
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("/addClazz")
    @ResponseBody
    public Map<String, Object> addClazz(Clazz clazz) {
        //判断班级名是否已存在
        Clazz name = clazzService.findByName(clazz.getName());
        if (name == null) {
            if (clazzService.insert(clazz) > 0) {
                result.put("success", true);
            } else {
                result.put("success", false);
                result.put("msg", "添加失败! (ಥ_ಥ)服务器端发生异常!");
            }
        } else {
            result.put("success", false);
            result.put("msg", "该班级名称已存在! 请修改后重试!");
        }

        return result;
    }

    /**
     * @description: 根据id修改指定的班级信息
     * @param: clazz
     * @date: 2019-06-15 2:28 PM
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("/editClazz")
    @ResponseBody
    public Map<String, Object> editClazz(Clazz clazz) {
        //需排除用户只修改班级名以外的信息
        Clazz c = clazzService.findByName(clazz.getName());
        if (c != null) {
            if (!(clazz.getId().equals(c.getId()))) {
                result.put("success", false);
                result.put("msg", "该班级名称已存在! 请修改后重试!");
                return result;
            }
        }
        //添加操作
        if (clazzService.update(clazz) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "添加失败! (ಥ_ಥ)服务器端发生异常!");
        }
        return result;
    }


    /**
     * @description: 删除指定id的班级信息
     * @param: ids 拼接后的id
     * @date: 2019-06-15 2:16 PM
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("/deleteClazz")
    @ResponseBody
    public Map<String, Object> deleteGrade(@RequestParam(value = "ids[]", required = true) Integer[] ids) {

        if (clazzService.deleteById(ids) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
        }
        return result;
    }

}
