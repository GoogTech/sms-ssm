package pers.huangyuhui.sms.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import pers.huangyuhui.sms.bean.Admin;
import pers.huangyuhui.sms.service.AdminService;
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
 * @description: 控制器-管理管理员信息页面
 * @author: 黄宇辉
 * @date: 6/11/2019-7:06 PM
 * @version: 1.0
 * @website: https://yubuntu0109.github.io/
 */

@Controller
@RequestMapping("/admin")
public class AdminController {

    //注入业务对象
    @Autowired
    private AdminService adminService;

    //存储预返回页面的结果对象
    private Map<String, Object> result = new HashMap<>();

    /**
     * @description: 跳转到管理员信息管理页面
     * @param: no
     * @date: 2019-06-11 7:11 PM
     * @return: java.lang.String
     */
    @GetMapping("/goAdminListView")
    public String getAdminList() {
        return "admin/adminList";
    }

    /**
     * @description: 分页查询:根据管理员姓名获取指定/所有管理员信息列表
     * @param: page 当前页码
     * @param: rows 列表行数
     * @param: username 管理员姓名
     * @date: 2019-06-13 1:31 PM
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("/getAdminList")
    @ResponseBody
    public Map<String, Object> getAdminList(Integer page, Integer rows, String username) {

        //获取查询的用户名
        Admin admin = new Admin();
        admin.setName(username);
        //设置每页的记录数
        PageHelper.startPage(page, rows);
        //根据姓名获取指定或所有管理员列表信息
        List<Admin> list = adminService.selectList(admin);
        //封装查询结果
        PageInfo<Admin> pageInfo = new PageInfo<>(list);
        //获取总记录数
        long total = pageInfo.getTotal();
        //获取当前页数据列表
        List<Admin> adminList = pageInfo.getList();
        //存储对象数据
        result.put("total", total);
        result.put("rows", adminList);

        return result;
    }


    /**
     * @description: 添加管理员信息
     * @param: admin
     * @date: 2019-06-12 10:26 AM
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("/addAdmin")
    @ResponseBody
    public Map<String, Object> addAdmin(Admin admin) {
        //判断用户名是否已存在
        Admin user = adminService.findByName(admin.getName());
        if (user == null) {
            if (adminService.insert(admin) > 0) {
                result.put("success", true);
            } else {
                result.put("success", false);
                result.put("msg", "添加失败! (ಥ_ಥ)服务器端发生异常!");
            }
        } else {
            result.put("success", false);
            result.put("msg", "该用户名已存在! 请修改后重试!");
        }
        return result;
    }


    /**
     * @description: 根据id修改指定管理员信息
     * @param: admin
     * @date: 2019-06-13 5:29 PM
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("/editAdmin")
    @ResponseBody
    public Map<String, Object> edityAdmin(Admin admin) {
        //需排除用户只修改账户名以外的信息
        Admin user = adminService.findByName(admin.getName());
        if (user != null) {
            if (!(admin.getId().equals(user.getId()))) {
                result.put("success", false);
                result.put("msg", "该用户名已存在! 请修改后重试!");
                return result;
            }
        }
        //添加操作
        if (adminService.update(admin) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "添加失败! (ಥ_ಥ)服务器端发生异常!");
        }
        return result;
    }

    /**
     * @description: 删除指定id的管理员信息
     * @param: ids 拼接后的id
     * @date: 2019-06-14 3:41 PM
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("/deleteAdmin")
    @ResponseBody
    public Map<String, Object> deleteAdmin(@RequestParam(value = "ids[]", required = true) Integer[] ids) {

        if (adminService.deleteById(ids) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
        }
        return result;
    }


    /**
     * @description: 上传头像-原理:将头像上传到项目发布目录中,通过读取数据库中的头像路径来获取头像
     * @param: photo
     * @param: request
     * @date: 2019-06-19 1:09 PM
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("/uploadPhoto")
    @ResponseBody
    public Map<String, Object> uploadPhoto(MultipartFile photo, HttpServletRequest request) {
        final String DIR_PAHT = request.getServletContext().getRealPath("/upload/admin_portrait/");//存储头像的本地目录
        final String PORTRAIT_PATH = request.getServletContext().getContextPath() + "/upload/admin_portrait/";//存储头像的项目发布目录

        if (!photo.isEmpty() && photo.getSize() > 0) {
            //获取图片的原始名称
            String orginalName = photo.getOriginalFilename();
            //上传图片,error_result:存储图片上传失败的错误信息
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
