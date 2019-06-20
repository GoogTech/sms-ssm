<%--
  Created by IntelliJ IDEA.
  User: 黄宇辉
  Date: 6/9/2019
  Time: 3:38 PM
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- use EL-Expression-->
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <!-- 引入CSS -->
    <link href="${pageContext.request.contextPath}/static/h-ui/css/H-ui.min.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/static/h-ui/css/H-ui.login.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/static/h-ui/lib/icheck/icheck.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/static/h-ui/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet"
          type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/static/easyui/themes/default/easyui.css">
    <!-- 引入JS -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/h-ui/js/H-ui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/h-ui/lib/icheck/jquery.icheck.min.js"></script>

    <!-- 页面事件 -->
    <script type="text/javascript">
        $(function () {
            //点击图片切换验证码
            $("#vcodeImg").click(function () {
                this.src = "getVerifiCodeImage?t=" + new Date().getTime();
            });
            //登录按钮事件
            $("#submitBtn").click(function () {
                //检查登录信息
                if ($('#username').val() === '') {
                    $.messager.alert("提示", "请输入用户名 !", "warning");
                } else if ($('#password').val() === '') {
                    $.messager.alert("提示", "请输入密码 !", "warning");
                } else if ($('#verifiCode').val() === '') {
                    $.messager.alert("提示", "请输入验证码 !", "warning");
                } else {
                    //提交用户的登录表单信息
                    var data = $("#form").serialize();
                    $.ajax({
                        type: "post",
                        url: "login",
                        data: data,
                        dataType: "json",
                        success: function (data) {
                            if (data.success) {
                                window.location.href = "goSystemMainView";//进入系统主页面
                            } else {
                                $.messager.alert("提示", data.msg, "warning");
                                $("#vcodeImg").click();//切换验证码
                                $("input[name='vcode']").val("");//清空验证码输入框
                            }
                        }
                    });
                }
            });
            //设置复选框
            $(".skin-minimal input").iCheck({
                radioClass: 'iradio-blue',
                increaseArea: '25%'
            });
        })
    </script>

    <title>学生管理系统 | 登录页面 </title>
    <meta name="keywords" content="学生信息管理系统">
</head>

<body style="font-weight: lighter; ">
<div class="header" style="padding: 0;">
    <h3 style="font-weight: lighter; color: white; width: 550px; height: 60px; line-height: 60px; margin: 0 0 0 30px; padding: 0;">
        Student Management System — SSM
    </h3>
</div>
<div class="loginWraper">
    <div id="loginform" class="loginBox">
        <form id="form" class="form form-horizontal" method="post" action="#">
            <!-- 用户身份信息 -->
            <div class="row cl">
                <label class="form-label col-3"><i class="Hui-iconfont">&#xe60a;</i></label>
                <div class="formControls col-8">
                    <input id="username" name="username" type="text" placeholder="账户" class="input-text radius size-L"/>
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-3"><i class="Hui-iconfont">&#xe63f;</i></label>
                <div class="formControls col-8">
                    <input id="password" name="password" type="password" placeholder="密码"
                           class="input-text radius size-L"/>
                </div>
            </div>
            <!-- 验证码 -->
            <div class="row cl">
                <label class="form-label col-3"><i class="Hui-iconfont">&#xe647;</i></label>
                <div class="formControls col-8">
                    <input id="verifiCode" class="input-text radius size-L" name="verifiCode" type="text"
                           placeholder="验证码"
                           style="width: 200px;">
                    <img title="点击图片切换验证码哟 ~" id="vcodeImg" src="getVerifiCodeImage" alt="#">
                </div>
            </div>
            <!-- 用户类型 -->
            <div class="mt-20 skin-minimal" style="text-align: center;">
                <div class="radio-box">
                    <input type="radio" id="radio-1" name="userType" value="1"/>
                    <label for="radio-3">管理员</label>
                </div>
                <div class="radio-box">
                    <input type="radio" id="radio-3" name="userType" value="3"/>
                    <label for="radio-2">老师</label>
                </div>
                <div class="radio-box">
                    <input type="radio" id="radio-2" name="userType" checked value="2"/>
                    <label for="radio-1">学生</label>
                </div>
            </div>
            <!-- 登录按钮 -->
            <div class="row">
                <div class="formControls col-8 col-offset-3">
                    <input id="submitBtn" type="button" class="btn btn-primary radius" value="&nbsp;
                    登&nbsp;&nbsp;&nbsp;&nbsp;录&nbsp;">
                </div>
            </div>
        </form>
    </div>
</div>

<!-- 页面底部版权声明 -->
<div class="footer">
    Copyright @ 2019 黄宇辉. All rights reserved | 本人博客网站 : https://yubuntu0109.github.io
</div>
</body>
</html>