package pers.huangyuhui.sms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import pers.huangyuhui.sms.bean.Admin;
import pers.huangyuhui.sms.bean.LoginForm;
import pers.huangyuhui.sms.bean.Student;
import pers.huangyuhui.sms.bean.Teacher;
import pers.huangyuhui.sms.service.AdminService;
import pers.huangyuhui.sms.service.StudentService;
import pers.huangyuhui.sms.service.TeacherService;
import pers.huangyuhui.sms.util.CreateVerifiCodeImage;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @project: sms
 * @description: 控制器-管理系统登录与主页面
 * @author: 黄宇辉
 * @date: 6/10/2019-3:55 PM
 * @version: 1.0
 * @website: https://yubuntu0109.github.io/
 */
@Controller
@RequestMapping("/system")
public class SystemController {

    //注入业务对象
    @Autowired
    private AdminService adminService;
    @Autowired
    private TeacherService teacherService;
    @Autowired
    private StudentService studentService;

    //存储返回给页面的对象数据
    private Map<String, Object> result = new HashMap<>();

    /**
     * @description: 跳转到用户登录页面
     * @param: no
     * @date: 2019-06-09 6:34 PM
     * @return: java.lang.String
     */
    @GetMapping("/goLogin")
    public String goLogin() {
        return "system/login";
    }

    /**
     * @description: 获取并显示验证码图片
     * @param: request
     * @param: response
     * @date: 2019-06-09 6:34 PM
     * @return: void
     */
    @GetMapping("/getVerifiCodeImage")
    public void getVerifiCodeImage(HttpServletRequest request, HttpServletResponse response) {
        // 验证码图片
        BufferedImage verifiCodeImage = CreateVerifiCodeImage.getVerifiCodeImage();
        // 验证码
        String verifiCode = String.valueOf(CreateVerifiCodeImage.getVerifiCode());
        // 将验证码图片输出到登录页面
        try {
            ImageIO.write(verifiCodeImage, "JPEG", response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 存储验证码Session
        request.getSession().setAttribute("verifiCode", verifiCode);
    }

    /**
     * @description: 验证用户登录信息
     * @param: loginForm
     * @param: request
     * @date: 2019-06-19 7:05 PM
     * @return: java.util.Map<java.lang.String, java.lang.Object>
     */
    @PostMapping("login")
    @ResponseBody
    public Map<String, Object> login(LoginForm loginForm, HttpServletRequest request) {

        // 校验验证码信息
        String vcode = (String) request.getSession().getAttribute("verifiCode");
        if ("".equals(vcode)) {
            result.put("success", false);
            result.put("msg", "长时间为操作,会话已失效,请刷新页面后重试!");
            return result;
        } else if (!loginForm.getVerifiCode().equalsIgnoreCase(vcode)) {
            result.put("success", false);
            result.put("msg", "验证码错误!");
            return result;
        }
        request.getSession().removeAttribute("verifiCode");

        //效验用户登录信息
        switch (loginForm.getUserType()) {
            //管理员身份
            case 1:
                try {
                    Admin admin = adminService.login(loginForm);//验证账户和密码是否存在
                    if (admin != null) {
                        HttpSession session = request.getSession(); //将用户信息存储到Session
                        session.setAttribute("userInfo", admin);
                        session.setAttribute("userType", loginForm.getUserType());
                        result.put("success", true);
                        return result;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    result.put("success", false);
                    result.put("msg", "登录失败! 服务器端发生异常!");
                    return result;
                }
                break;
            //学生身份
            case 2:
                try {
                    Student student = studentService.login(loginForm);
                    if (student != null) {
                        HttpSession session = request.getSession();
                        session.setAttribute("userInfo", student);
                        session.setAttribute("userType", loginForm.getUserType());
                        result.put("success", true);
                        return result;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    result.put("success", false);
                    result.put("msg", "登录失败! 服务器端发生异常!");
                    return result;
                }
                break;
            //教师身份
            case 3:
                try {
                    Teacher teacher = teacherService.login(loginForm);
                    if (teacher != null) {
                        HttpSession session = request.getSession();
                        session.setAttribute("userInfo", teacher);
                        session.setAttribute("userType", loginForm.getUserType());
                        result.put("success", true);
                        return result;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    result.put("success", false);
                    result.put("msg", "登录失败! 服务器端发生异常!");
                    return result;
                }
                break;
        }
        //登录失败
        result.put("success", false);
        result.put("msg", "用户名或密码错误!");
        return result;
    }

    /**
     * @description: 跳转到系统主页面
     * @param: no
     * @date: 2019-06-10 10:54 AM
     * @return: java.lang.String
     */
    @GetMapping("/goSystemMainView")
    public String goSystemMainView() {
        return "system/main";
    }


    /**
     * @description: 注销用户信息
     * @param: request
     * @date: 2019-06-11 6:40 PM
     * @return: void
     */
    @GetMapping("/loginOut")
    public void loginOut(HttpServletRequest request, HttpServletResponse response) {
        request.getSession().removeAttribute("userInfo");
        request.getSession().removeAttribute("userType");

        //注销后重定向到登录页面
        try {
            response.sendRedirect("WEB-INF/view/system/login.jsp");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
