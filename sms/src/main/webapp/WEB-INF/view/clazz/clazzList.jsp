<%--
  Created by IntelliJ IDEA.
  User: 黄宇辉
  Date: 6/15/2019
  Time: 8:11 AM
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- use EL-Expression-->
<%@ page isELIgnored="false" %>
<!-- use JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8" content="#">
    <title>班级信息管理页面</title>
    <!-- 引入CSS -->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/static/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/css/demo.css">
    <!-- 引入JS -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/easyui/themes/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/easyui/js/validateExtends.js"></script>

    <script type="text/javascript">
        //DOM加载完成后执行的回调函数
        $(function () {
            var table;
            //初始化datagrid
            $('#dataList').datagrid({
                iconCls: 'icon-more',//图标
                border: true,
                collapsible: false,//是否可折叠
                fit: true,//自动大小
                method: "post",
                url: "getClazzList?t" + new Date().getTime(),
                idField: 'id',
                singleSelect: false,//是否单选
                rownumbers: true,//行号
                pagination: true,//分页控件
                sortName: 'id',
                sortOrder: 'DESC',
                remoteSort: false,
                columns: [[
                    {field: 'chk', checkbox: true, width: 50},
                    {field: 'id', title: 'ID', width: 50, sortable: true},
                    {field: 'name', title: '班级名称', width: 150},
                    {field: 'number', title: '班级人数', width: 100},
                    {field: 'coordinator', title: '班主任姓名', width: 150},
                    {field: 'email', title: '班主任邮箱', width: 150},
                    {field: 'telephone', title: '班主任电话', width: 150},
                    {field: 'grade_name', title: '所属年级', width: 150},
                    {field: 'introducation', title: '班级介绍', width: 220}
                ]],
                toolbar: "#toolbar"//工具栏
            });

            //设置分页控件
            var p = $('#dataList').datagrid('getPager');
            $(p).pagination({
                pageSize: 10,//设置每页显示的记录条数,默认为10
                pageList: [10, 20, 30, 50, 100],//设置每页的记录条数
                beforePageText: '第',
                afterPageText: '页    共 {pages} 页',
                displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
            });

            //信息添加按钮事件
            $("#add").click(function () {
                table = $("#addTable");
                $("#addTable").form("clear");//清空表单数据
                $("#addDialog").dialog("open");//打开添加窗口
            });

            //信息修改按钮事件
            $("#edit").click(function () {
                table = $("#editTable");
                var selectRows = $("#dataList").datagrid("getSelections");
                if (selectRows.length !== 1) {
                    $.messager.alert("消息提醒", "请单条选择想要修改的数据哟!", "warning");
                } else {
                    $("#editDialog").dialog("open");
                }
            });

            //信息删除按钮事件
            $("#delete").click(function () {
                var selectRows = $("#dataList").datagrid("getSelections");//返回所有选中的行,当没有选中的记录时,将返回空数组
                var selectLength = selectRows.length;
                if (selectLength === 0) {
                    $.messager.alert("消息提醒", "请选择想要删除的数据哟!", "warning");
                } else {
                    var ids = [];
                    $(selectRows).each(function (i, row) {
                        ids[i] = row.id;//将预删除行的id存储到数据中
                    });
                    $.messager.confirm("消息提醒", "删除后将无法恢复该班级信息! 确定继续?", function (r) {
                        if (r) {
                            $.ajax({
                                type: "post",
                                url: "deleteClazz?t" + new Date().getTime(),
                                data: {ids: ids},
                                dataType: 'json',
                                success: function (data) {
                                    if (data.success) {
                                        $.messager.alert("消息提醒", "删除成功啦!", "info");
                                        $("#dataList").datagrid("reload");//刷新表格
                                        $("#dataList").datagrid("uncheckAll");//取消勾选当前页所有的行
                                    } else {
                                        $.messager.alert("消息提醒", "服务器端发生异常! 删除失败!", "warning");
                                    }
                                }
                            });
                        }
                    });
                }
            });

            //设置添加教师窗口
            $("#addDialog").dialog({
                title: "添加班级信息窗口",
                width: 430,
                height: 460,
                iconCls: "icon-house",
                modal: true,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                draggable: true,
                closed: true,
                buttons: [
                    {
                        text: '添加',
                        plain: true,
                        iconCls: 'icon-add',
                        handler: function () {
                            var validate = $("#addForm").form("validate");
                            if (!validate) {
                                $.messager.alert("消息提醒", "请检查你输入的数据哟!", "warning");
                            } else {
                                var data = $("#addForm").serialize();//序列化表单信息
                                $.ajax({
                                    type: "post",
                                    url: "addClazz?t" + new Date().getTime(),
                                    data: data,
                                    dataType: 'json',
                                    success: function (data) {
                                        if (data.success) {
                                            $("#addDialog").dialog("close"); //关闭窗口
                                            $('#dataList').datagrid("reload");//重新刷新页面数据
                                            $.messager.alert("消息提醒", "添加成功啦!", "info");
                                        } else {
                                            $.messager.alert("消息提醒", data.msg, "warning");
                                        }
                                    }
                                });
                            }
                        }
                    },
                    {
                        text: '重置',
                        plain: true,
                        iconCls: 'icon-reload',
                        handler: function () {
                            $("#add_name").textbox('setValue', "");
                            $("#add_number").textbox('setValue', "");
                            $("#add_coordinator").textbox('setValue', "");
                            $("#add_email").textbox('setValue', "");
                            $("#add_telephone").textbox('setValue', "");
                            $("#add_introduation").textbox('setValue', "");
                        }
                    }
                ]
            });

            //设置编辑班级信息窗口
            $("#editDialog").dialog({
                title: "修改班级信息窗口",
                width: 430,
                height: 460,
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
                        plain: true,
                        iconCls: 'icon-edit',
                        handler: function () {
                            var validate = $("#editForm").form("validate");
                            if (!validate) {
                                $.messager.alert("消息提醒", "请检查你输入的数据哟!", "warning");
                            } else {
                                var data = $("#editForm").serialize();//序列化表单信息
                                $.ajax({
                                    type: "post",
                                    url: "editClazz?t=" + new Date().getTime(),
                                    data: data,
                                    dataType: 'json',
                                    success: function (data) {
                                        if (data.success) {
                                            //关闭窗口
                                            $("#editDialog").dialog("close");
                                            //重新刷新页面数据
                                            $('#dataList').datagrid("reload");
                                            $('#dataList').datagrid("uncheckAll");
                                            //用户提示
                                            $.messager.alert("消息提醒", "修改成功啦!", "info");
                                        } else {
                                            $.messager.alert("消息提醒", data.msg, "warning");
                                        }
                                    }
                                });
                            }
                        }
                    },
                    {
                        text: '重置',
                        plain: true,
                        iconCls: 'icon-reload',
                        handler: function () {
                            $("#edit_name").textbox('setValue', "");
                            $("#edit_number").textbox('setValue', "");
                            $("#edit_coordinator").textbox('setValue', "");
                            $("#edit_email").textbox('setValue', "");
                            $("#edit_telephone").textbox('setValue', "");
                            $("#edit_introducation").textbox('setValue', "");
                        }
                    }
                ],
                //打开窗口前先初始化表单数据(表单回显)
                onBeforeOpen: function () {
                    var selectRow = $("#dataList").datagrid("getSelected");
                    $("#edit_id").val(selectRow.id);//需根据id更新班级信息
                    $("#edit_name").textbox('setValue', selectRow.name);
                    $("#edit_number").textbox('setValue', selectRow.number);
                    $("#edit_coordinator").textbox('setValue', selectRow.coordinator);
                    $("#edit_email").textbox('setValue', selectRow.email);
                    $("#edit_telephone").textbox('setValue', selectRow.telephone);
                    $("#edit_grade_name").textbox('setValue', selectRow.grade_name);
                    $("#edit_introducation").textbox('setValue', selectRow.introducation);
                }
            });

            //班级与年级名称搜索按钮的监听事件(将搜索值返回给Controller)
            $("#search-btn").click(function () {
                $('#dataList').datagrid('load', {
                    clazzname: $('#search-clazzname').val(),//获取班级名称
                    gradename: $('#search-gradename').combobox('getValue')//获取年级名称
                });
            });

        });

    </script>
</head>
<body>

<!-- 班级信息列表 -->
<table id="dataList" cellspacing="0" cellpadding="0"></table>

<!-- 工具栏 -->
<div id="toolbar">
    <div style="float: left;"><a id="add" href="javascript:" class="easyui-linkbutton"
                                 data-options="iconCls:'icon-add',plain:true">添加</a></div>
    <div style="float: left;" class="datagrid-btn-separator"></div>
    <div style="float: left;"><a id="edit" href="javascript:" class="easyui-linkbutton"
                                 data-options="iconCls:'icon-edit',plain:true">修改</a></div>
    <div style="float: left;" class="datagrid-btn-separator"></div>
    <div style="float: left;"><a id="delete" href="javascript:" class="easyui-linkbutton"
                                 data-options="iconCls:'icon-some-delete',plain:true">删除</a></div>

    <!-- 年级与班级名搜索域 -->
    <div style="margin-left: 10px;">
        <div style="float: left;" class="datagrid-btn-separator"></div>
        <!-- 年级名称下拉框 -->
        <a href="javascript:" class="easyui-linkbutton"
           data-options="iconCls:'icon-grade',plain:true">年级名称</a>
        <select id="search-gradename" style="width: 155px;" class="easyui-combobox" name="gradename">
            <!-- 通过JSTL遍历显示年级信息,gradeList:为Contrller传递的来的,存储着Grade的List对象 -->
            <option value="">未选择年级</option>
            <c:forEach items="${gradeList}" var="grade">
                <option value="${grade.name}">${grade.name}</option>
            </c:forEach>
        </select>
        <!-- 班级名称搜索框 -->
        <a href="javascript:" class="easyui-linkbutton"
           data-options="iconCls:'icon-class',plain:true">班级名称</a>
        <input id="search-clazzname" class="easyui-textbox" name="clazzname"/>
        <!-- 搜索按钮 -->
        <a id="search-btn" href="javascript:" class="easyui-linkbutton"
           data-options="iconCls:'icon-search',plain:true">搜索</a>
    </div>
</div>


<!-- 添加信息窗口 -->
<div id="addDialog" style="padding: 25px 0 0 55px;">
    <form id="addForm" method="post" action="#">
        <table id="addTable" style="border-collapse:separate; border-spacing:0 3px;" cellpadding="6">
            <tr>
                <td>班级名称</td>
                <td colspan="1">
                    <input id="add_name" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="name" data-options="required:true, missingMessage:'请选择所属年级哟~'"/>
                </td>
            </tr>
            <tr>
                <td>班级人数</td>
                <td colspan="1">
                    <input id="add_number" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="number" validType="number"
                           data-options="required:true, missingMessage:'请填写班级人数哟~'"/>
                </td>
            </tr>
            <tr>
                <td>班主任</td>
                <td colspan="1"><input id="add_coordinator" style="width: 200px; height: 30px;" class="easyui-textbox"
                                       type="text" name="coordinator"
                                       data-options="required:true, missingMessage:'请填写主任姓名哟~'"/>
                </td>
            </tr>
            <tr>
                <td>班主任邮箱</td>
                <td colspan="1"><input id="add_email" style="width: 200px; height: 30px;" class="easyui-textbox"
                                       type="text" name="email" validType="email"
                                       data-options="required:true, missingMessage:'请填写邮箱地址哟~'"/>
                </td>
            </tr>
            <tr>
                <td>班主任电话</td>
                <td colspan="4"><input id="add_telephone" style="width: 200px; height: 30px;" class="easyui-textbox"
                                       type="text" name="telephone" validType="mobile"
                                       data-options="required:true, missingMessage:'请填写联系方式哟~'"/>
                </td>
            </tr>
            <tr>
                <td>所属年级</td>
                <td colspan="1">
                    <select id="add_grade_name" style="width: 200px; height: 30px;" class="easyui-combobox"
                            name="grade_name">
                        <c:forEach items="${gradeList}" var="grade">
                            <option value="${grade.name}">${grade.name}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td>班级介绍</td>
                <td colspan="4"><input id="add_introduation" style="width: 200px; height: 60px;" class="easyui-textbox"
                                       type="text" name="introducation"
                                       data-options="multiline:true,required:true, missingMessage:'班级介绍不能为空呦~'"/>
                </td>
            </tr>
        </table>
    </form>
</div>


<!-- 修改信息窗口 -->
<div id="editDialog" style="padding: 20px 0 0 65px">
    <form id="editForm" method="post" action="#">
        <!-- 获取被修改信息的班级id -->
        <input type="hidden" id="edit_id" name="id"/>
        <table id="editTable" style="border-collapse:separate; border-spacing:0 3px;" cellpadding="6">
            <tr>
                <td>班级名称</td>
                <td><input id="edit_name" style="width: 200px; height: 30px;" class="easyui-textbox" type="text"
                           name="name" data-options="required:true, missingMessage:'请填写班级姓名哟~'"/>
                </td>
            </tr>
            <tr>
                <td>班级人数</td>
                <td colspan="1">
                    <input id="edit_number" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="number" validType="number"
                           data-options="required:true, missingMessage:'请填写班级人数哟~'"/>
                </td>
            </tr>
            <tr>
                <td>班级主任</td>
                <td colspan="4"><input id="edit_coordinator" style="width: 200px; height: 30px;" class="easyui-textbox"
                                       type="text" name="coordinator"
                                       data-options="required:true, missingMessage:'请填写班级主任姓名哟~'"/>
                </td>
            </tr>
            <tr>
                <td>主任邮箱</td>
                <td colspan="4"><input id="edit_email" style="width: 200px; height: 30px;" class="easyui-textbox"
                                       type="text" name="email" validType="email"
                                       data-options="required:true, missingMessage:'请填写邮箱地址哟~'"/>
                </td>
            </tr>
            <tr>
                <td>主任电话</td>
                <td><input id="edit_telephone" style="width: 200px; height: 30px;" class="easyui-textbox" type="text"
                           name="telephone" validType="mobile"
                           data-options="required:true, missingMessage:'请填写联系方式哟~'"/>
                </td>
            </tr>
            <tr>
                <td>所属年级</td>
                <td colspan="1">
                    <select id="edit_grade_name" style="width: 200px; height: 30px;" class="easyui-combobox"
                            name="grade_name">
                        <c:forEach items="${gradeList}" var="grade">
                            <option value="${grade.name}">${grade.name}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td>班级介绍</td>
                <td colspan="4"><input id="edit_introducation" style="width: 200px; height: 60px;"
                                       class="easyui-textbox"
                                       type="text" name="introducation"
                                       data-options="multiline:true,required:true, missingMessage:'班级介绍不能为空呦~'"/>
                </td>
            </tr>
        </table>
    </form>
</div>

</body>
</html>