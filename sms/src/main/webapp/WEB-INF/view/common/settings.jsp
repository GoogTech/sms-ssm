<%--
  Created by IntelliJ IDEA.
  User: 黄宇辉
  Date: 6/18/2019
  Time: 12:59 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!-- use EL-Expression-->
<%@ page isELIgnored="false" %>
<!-- use JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>用户信息管理页面</title>
    <!-- 引入CSS -->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/static/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/css/demo.css">
    <!-- 设置CSS样式	 -->
    <style type="text/css">
        .table th {
            font-weight: bold
        }

        .table th, .table td {
            padding: 8px;
            line-height: 20px
        }

        .table td {
            text-align: left
        }

        .table-border th, .table-border td {
            border-bottom: 1px solid #ddd
        }

        .table-bordered th, .table-bordered td {
            border-left: 1px solid #ddd
        }

        .table-striped tbody > tr:nth-child(odd) > td, .table-striped tbody > tr:nth-child(odd) > th {
            background-color: #f9f9f9
        }
    </style>
    <!-- 引入JS -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/easyui/js/validateExtends.js"></script>

    <script type="text/javascript">
        $(function () {
            //修改密码窗口
            $("#passwordDialog").dialog({
                title: "修改密码窗口",
                width: 400,
                height: 300,
                iconCls: "icon-house",
                modal: true,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                draggable: true,
                closed: true,
                buttons: [
                    {
                        text: '提交',
                        iconCls: 'icon-edit',
                        handler: function () {
                            var validate = $("#editPassword").form("validate");
                            if (!validate) {
                                $.messager.alert("消息提醒", "请检查你输入的数据哟!", "warning");
                            } else {
                                var data = $("#editPassword").serialize();
                                $.ajax({
                                    type: "post",
                                    url: "editPassword?t=" + new Date().getTime(),
                                    data: data,
                                    success: function (data) {
                                        if (data.success) {
                                            $.messager.alert("消息提醒", "修改成功! 你的账户将会在3秒后注销~", "info");
                                            setTimeout(function () {
                                                top.location.href = "../system/loginOut";
                                            }, 3000);
                                        } else {
                                            $.messager.alert("消息提醒", data.msg, "error")
                                        }
                                    }
                                });
                            }
                        }
                    },
                    {
                        text: '重置',
                        iconCls: 'icon-reload',
                        handler: function () {
                            $("#old_password").textbox('setValue', "");
                            $("#new_password").textbox('setValue', "");
                            $("#re_password").textbox('setValue', "");
                        }
                    }
                ]
            });

            //设置修改密码窗口
            $("#editDialog").dialog({
                title: "修改密码",
                width: 500,
                height: 400,
                fit: true,
                modal: false,
                noheader: true,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                draggable: true,
                closed: false,
                toolbar: [
                    {
                        text: '修改密码',
                        plain: true,
                        iconCls: 'icon-password',
                        handler: function () {
                            $("#passwordDialog").dialog("open");
                        }
                    }
                ]
            });

        })
    </script>
</head>
<body>

<div id="editDialog" style="padding: 20px;"></div>

<!-- 修改密码窗口 -->
<div id="passwordDialog" style="padding: 20px">
    <form id="editPassword" action="#" style="padding-left: 20px;padding-top: 15px">
        <table cellpadding="8">
            <tr>
                <td>原密码</td>
                <td>
                    <input id="old_password" style="width: 200px; height: 30px;" class="easyui-textbox" type="password"
                           name="oldPassword" data-options="required:true, missingMessage:'请输入原密码哟~'"/>
                </td>
            </tr>
            <tr>
                <td>新密码</td>
                <td>
                    <input type="hidden" name="account"/>
                    <input id="new_password" style="width: 200px; height: 30px;" class="easyui-textbox" type="password"
                           validType="password" name="newPassword"
                           data-options="required:true, missingMessage:'请输入新密码~'"/>
                </td>
            </tr>
            <tr>
                <td>新密码</td>
                <td><input id="re_password" style="width: 200px; height: 30px;" class="easyui-textbox" type="password"
                           validType="equals['#new_password']"
                           data-options="required:true, missingMessage:'请再次输入密码哟~'"/></td>
            </tr>
        </table>
    </form>
</div>

</body>
</html>