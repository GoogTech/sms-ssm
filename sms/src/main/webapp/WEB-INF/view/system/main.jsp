<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 6/10/2019
  Time: 5:23 PM
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- use EL-Expression-->
<%@ page isELIgnored="false" %>
<!-- use JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>学生管理系统 | 系统主页面</title>
    <!-- 引入CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/css/default.css"/>
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/static/easyui/themes/metro/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/icon.css"/>
    <!-- 引入JS -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src='${pageContext.request.contextPath}/static/easyui/js/outlook2.js'></script>

    <!-- 页面事件 -->
    <script type="text/javascript">
        //加载页面函数
        $(function () {
            //消息推送窗口
            $.messager.show({
                width: 360,
                height: 50,
                title: '推送',
                msg: '很开心你能体现这个小小小项目哟 ! （づ￣3￣）づ╭❤～ ',
                showSpeed: 1500,
                timeout: 0,
                showType: 'slide'
            });
        });
        //设置系统功能菜单栏
        var _menus = {
            "menus": [
                {
                    "menuid": "1", "icon": "", "menuname": "学生信息管理",
                    "menus": [
                        {
                            "menuid": "21",
                            "menuname": "学生列表",
                            "icon": "icon-student",
                            "url": "../student/goStudentListView"
                        }
                    ]
                },
                <%-- 通过JSTL设置用户查看权限: 仅管理员和教师可以查看教师列表信息 --%>
                <c:if test="${userType == 1 || userType == 3}">
                {
                    "menuid": "2", "icon": "", "menuname": "教师信息管理",
                    "menus": [
                        {
                            "menuid": "22",
                            "menuname": "教师列表",
                            "icon": "icon-teacher",
                            "url": "../teacher/goTeacherListView"
                        }
                    ]
                },
                </c:if>
                <%-- 通过JSTL设置用户查看权限:  仅管理员可以查看年级,班级,管理员列表信息 --%>
                <c:if test="${userType == 1}">
                {
                    "menuid": "3", "icon": "", "menuname": "班级信息管理",
                    "menus": [
                        {
                            "menuid": "23",
                            "menuname": "班级列表",
                            "icon": "icon-class",
                            "url": "../clazz/goClazzListView"
                        }
                    ]
                },
                {
                    "menuid": "4", "icon": "", "menuname": "年级信息管理",
                    "menus": [
                        {
                            "menuid": "24",
                            "menuname": "年级列表",
                            "icon": "icon-grade",
                            "url": "../grade/goGradeListView"
                        }
                    ]
                },
                {
                    "menuid": "5", "icon": "", "menuname": "系统用户管理",
                    "menus": [
                        {
                            "menuid": "25",
                            "menuname": "管理员列表",
                            "icon": "icon-admin",
                            "url": "../admin/goAdminListView"
                        }
                    ]
                },
                </c:if>
                {
                    "menuid": "6", "icon": "", "menuname": "个人信息管理",
                    "menus": [
                        {
                            "menuid": "26",
                            "menuname": "修改密码",
                            "icon": "icon-settings",
                            "url": "../common/goSettingView"
                        }
                    ]
                }
            ]
        };

    </script>
</head>

<body class="easyui-layout" style="overflow-y: hidden" scroll="no">

<!-- 页面顶部 -->
<div region="north" split="true" border="false" style="overflow: hidden; height: 30px;
        line-height: 20px;color: #fff; font-family: Verdana, 微软雅黑,黑体,'Lucida Console',serif">
        <span style="float:right; padding-right:20px;" class="head">
        	<span style="color:blue;" class="easyui-linkbutton" data-options="iconCls:'icon-user',plain:true">
                <!-- 获取用户登录类型 -->
        		<c:choose>
                    <c:when test="${userType==1 }">管理员 : </c:when>
                    <c:when test="${userType==2 }">学生 : </c:when>
                    <c:when test="${userType==3}">教师 : </c:when>
                </c:choose>
        	</span>
            <%-- 从Session中获取登录用户的用户名	--%>
        	<span style="color:red; font-weight:bold;">${userInfo.name}</span>&nbsp;&nbsp;&nbsp;&nbsp;
        	<a href="loginOut" id="loginOut" style="color: darkgrey;" class="easyui-linkbutton"
               data-options="iconCls:'icon-exit',plain:true">
                [安全退出]
        	</a>
        </span>
    <span style="padding-left:10px; font-size: 20px; color:darkgrey;font-weight: bold">学生管理系统 — SSM</span>
</div>

<!-- 页面底部-->
<div region="south" split="true" style="height: 30px;">
    <div class="footer">
        Copyright @ 2019 黄宇辉. All rights reserved | 本人博客网站 : https://yubuntu0109.github.io
    </div>
</div>

<!-- 导航菜单内容 -->
<div region="west" hide="true" split="true" title="[ 导航菜单 ]" style="width:180px;" id="west">
    <div id="nav" class="easyui-accordion" fit="true">
        <!-- ······ -->
    </div>
</div>

<!-- 引入欢迎页面资源 -->
<div id="mainPanle" region="center" style="background: #eee; overflow-y:hidden">
    <div id="tabs" class="easyui-tabs" fit="true">
        <jsp:include page="/WEB-INF/view/system/intro.jsp"/>
    </div>
</div>

</body>
</html>