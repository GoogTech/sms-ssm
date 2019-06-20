package pers.huangyuhui.sms.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import pers.huangyuhui.sms.bean.Teacher;
import pers.huangyuhui.sms.service.ClazzService;
import pers.huangyuhui.sms.service.TeacherService;
import pers.huangyuhui.sms.util.UploadFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * @project: sms
 * @description: 控制器-管理教师信息页面
 * @author: 黄宇辉
 * @date: 6/18/2019-9:46 AM
 * @version: 1.0
 * @website: https://yubuntu0109.github.io/
 */

@Controller
@RequestMapping("/teacher")
public class TeacherController {

    //注入业务对象
    @Autowired
    private ClazzService clazzService;
    @Autowired
    private TeacherService teacherService;

    //存储预返回页面的数据对象
    private Map<String, Object> result = new HashMap<>();

    /**
     * @description: 跳转到教师信息管理页面
     * @param: modelAndView
     * @date: 2019-06-18 9:52 AM
     * @return: org.springframework.web.servlet.ModelAndView
     */
    @GetMapping("/goTeacherListView")
    public ModelAndView goTeacherListView(ModelAndView modelAndView) {
        //向页面发送一个存储着Clazz的List对象
        modelAndView.addObject("clazzList", clazzService.selectAll());
        modelAndView.setViewName("teacher/teacherList");
        return modelAndView;
    }


    /**
     * @description: 分页查询学生信息列表:根据教师与班级名查询指定/全部教师信息列表
     * @param: page 当前页码
     * @param: rows 列表行数
     * @param: teachername
     * @param: clazzname
     * @date: 2019-06-18 10:17 AM
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("/getTeacherList")
    @ResponseBody
    public Map<String, Object> getTeacherList(Integer page, Integer rows, String teachername, String clazzname) {

        //存储查询的teachername,clazzname信息
        Teacher teacher = new Teacher(teachername, clazzname);
        //设置每页的记录数
        PageHelper.startPage(page, rows);
        //根据班级与教师名获取指定或全部教师信息列表
        List<Teacher> list = teacherService.selectList(teacher);
        //封装列表信息
        PageInfo<Teacher> pageInfo = new PageInfo<>(list);
        //获取总记录数
        long total = pageInfo.getTotal();
        //获取当前页数据列表
        List<Teacher> teacherList = pageInfo.getList();
        //存储数据对象
        result.put("total", total);
        result.put("rows", teacherList);

        return result;
    }

    /**
     * @description: 添加教师信息
     * @param: teacher
     * @date: 2019-06-18 10:23 AM
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("/addTeacher")
    @ResponseBody
    public Map<String, Object> addStudent(Teacher teacher) {
        //判断工号是否已存在
        if (teacherService.findByTno(teacher) != null) {
            result.put("success", false);
            result.put("msg", "工号已存在! 请修改后重试!");
            return result;
        }
        if (teacherService.insert(teacher) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "添加失败! (ಥ_ಥ)服务器端发生异常!");
        }
        return result;
    }


    /**
     * @description: 根据id修改指定的教师信息
     * @param: teacher
     * @date: 2019-06-18 10:29 AM
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("/editTeacher")
    @ResponseBody
    public Map<String, Object> editTeacher(Teacher teacher) {
        if (teacherService.update(teacher) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "修改失败! (ಥ_ಥ)服务器端发生异常!");
        }
        return result;
    }


    /**
     * @description: 根据id删除指定的教师信息
     * @param: ids
     * @date: 2019-06-18 10:34 AM
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("/deleteTeacher")
    @ResponseBody
    public Map<String, Object> deleteTeacher(@RequestParam(value = "ids[]", required = true) Integer[] ids) {

        if (teacherService.deleteById(ids) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "删除失败! (ಥ_ಥ)服务器端发生异常!");
        }
        return result;
    }


    /**
     * @description: 上传头像-原理:将头像上传到项目发布目录中,通过读取数据库中的头像路径来获取头像
     * @param: photo
     * @param: request
     * @date: 2019-06-18 10:38 AM
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("/uploadPhoto")
    @ResponseBody
    public Map<String, Object> uploadPhoto(MultipartFile photo, HttpServletRequest request) {
        final String DIR_PAHT = request.getServletContext().getRealPath("/upload/teacher_portrait/");//存储头像的本地目录
        final String PORTRAIT_PATH = request.getServletContext().getContextPath() + "/upload/teacher_portrait/";//存储头像的项目发布目录

        if (!photo.isEmpty() && photo.getSize() > 0) {
            //获取图片的原始名称
            String orginalName = photo.getOriginalFilename();
            //上传图片,error_result:存储头像上传失败的错误信息
            Map<String, Object> error_result = UploadFile.uploadPhoto(photo, DIR_PAHT);
            if (error_result != null) {
                return error_result;
            }
            //使用UUID重命名图片名称(uuid__原始图片名称)
            String newPhotoName = UUID.randomUUID() + "__" + orginalName;
            //将上传的文件保存到目标目录下
            try {
                photo.transferTo(new File(DIR_PAHT + newPhotoName));
                result.put("success", true);
                result.put("portrait_path", PORTRAIT_PATH + newPhotoName);//将存储头像的项目路径返回给页面
            } catch (IOException e) {
                e.printStackTrace();
                result.put("success", false);
                result.put("msg", "上传文件失败! 服务器端发生异常!");
                return result;
            }

        } else {
            result.put("success", false);
            result.put("msg", "头像上传失败! 未找到指定图片!");
        }
        return result;
    }

}