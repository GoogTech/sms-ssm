<%--
  Created by IntelliJ IDEA.
  User: 黄宇辉
  Date: 6/18/2019
  Time: 9:37 AM
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
    <title>教师信息管理页面</title>
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
                url: "getTeacherList?t" + new Date().getTime(),
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
                    {field: 'clazz_name', title: '任课班级', width: 150},
                    {field: 'name', title: '姓名', width: 150},
                    {field: 'tno', title: '工号', width: 150},
                    {field: 'gender', title: '性别', width: 50},
                    {field: 'email', title: '邮箱', width: 150},
                    {field: 'telephone', title: '电话', width: 150},
                    {field: 'address', title: '住址', width: 150}
                ]],
                toolbar: "#toolbar"//工具栏
            });

            //设置分页控件
            var p = $('#dataList').datagrid('getPager');
            $(p).pagination({
                pageSize: 10,//设置每页显示的记录条数,默认为10
                pageList: [10, 20, 30, 50, 100],//设置每页记录的条数
                beforePageText: '第',
                afterPageText: '页    共 {pages} 页',
                displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
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
                        ids[i] = row.id;//将预删除行的id存储到数组中
                    });
                    $.messager.confirm("消息提醒", "删除后将无法恢复该教师信息! 确定继续?", function (r) {
                        if (r) {
                            $.ajax({
                                type: "post",
                                url: "deleteTeacher?t" + new Date().getTime(),
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

            //设置添加教师信息窗口
            $("#addDialog").dialog({
                title: "添加教师信息窗口",
                width: 660,
                height: 470,
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
                                    url: "addTeacher?t" + new Date().getTime(),
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
                            $("#add_tno").textbox('setValue', "");
                            $("#add_name").textbox('setValue', "");
                            $("#add_gender").textbox('setValue', "男");
                            $("#add_password").textbox('setValue', "");
                            $("#add_email").textbox('setValue', "");
                            $("#add_telephone").textbox('setValue', "");
                            $("#add_address").textbox('setValue', "");
                        }
                    }
                ]
            });

            //设置编辑教师信息窗口
            $("#editDialog").dialog({
                title: "修改教师信息窗口",
                width: 660,
                height: 430,
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
                                    url: "editTeacher?t=" + new Date().getTime(),
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
                            $("#edit_gender").textbox('setValue', "男");
                            $("#edit_password").textbox('setValue', "");
                            $("#edit_email").textbox('setValue', "");
                            $("#edit_telephone").textbox('setValue', "");
                            $("#edit_address").textbox('setValue', "");
                            $("#edit_introducation").textbox('setValue', "");
                        }
                    }
                ],
                //打开窗口前先初始化表单数据(表单回显)
                onBeforeOpen: function () {
                    var selectRow = $("#dataList").datagrid("getSelected");
                    $("#edit_id").val(selectRow.id);//初始化id值,需根据id更新教师信息
                    $("#edit_tno").textbox('setValue', selectRow.tno);
                    $("#edit_name").textbox('setValue', selectRow.name);
                    $("#edit_gender").textbox('setValue', selectRow.gender);
                    $("#edit_password").textbox('setValue', selectRow.password);
                    $("#edit_email").textbox('setValue', selectRow.email);
                    $("#edit_telephone").textbox('setValue', selectRow.telephone);
                    $("#edit_address").textbox('setValue', selectRow.address);
                    //通过获取头像路径来显示该教师的头像
                    $("#edit-portrait").attr('src', selectRow.portrait_path);
                    //初始化头像路径(已优化:在执行SQL语句时通过判断头像路径是否为空,为空则代表用户并未修改头像)
                    //$("#edit_portrait-path").val(selectRow.portrait_path);
                }
            });

            //教师与班级名搜索按钮的监听事件(将其值返回给Controller)
            $("#search-btn").click(function () {
                $('#dataList').datagrid('load', {
                    teachername: $('#search-teachername').val(),//获取教师名称
                    clazzname: $('#search-clazzname').combobox('getValue')//获取年级名称
                });
            });

            //添加信息窗口中上传头像的按钮事件
            $("#add-upload-btn").click(function () {
                if ($("#choose-portrait").filebox("getValue") === '') {
                    $.messager.alert("提示", "请选择图片!", "warning");
                    return;
                }
                $("#add-uploadForm").submit();//提交表单

            });

            //修改信息窗口中上传头像的按钮事件
            $("#edit-upload-btn").click(function () {
                if ($("#edit-choose-portrait").filebox("getValue") === '') {
                    $.messager.alert("提示", "请选择图片!", "warning");
                    return;
                }
                $("#edit-uploadForm").submit();

            });

        });

        //上传头像按钮事件
        function uploaded() {
            var data = $(window.frames["photo_target"].document).find("body pre").text();
            data = JSON.parse(data);//将data装换为JSON对象
            if (data.success) {
                $.messager.alert("提示", "图片上传成功!", "info");
                //切换头像
                $("#add-portrait").attr("src", data.portrait_path);
                $("#edit-portrait").attr("src", data.portrait_path);
                //将头像路径存储到教师信息表单中(利用从用户信息中读取头像路径来显示头像)
                $("#add_portrait-path").val(data.portrait_path);
                $("#edit_portrait-path").val(data.portrait_path);
            } else {
                $.messager.alert("提示", data.msg, "warning");
            }
        }

    </script>
</head>
<body>

<!-- 教师列表信息 -->
<table id="dataList" cellspacing="0" cellpadding="0"></table>

<!-- 工具栏 -->
<div id="toolbar">
    <div style="float: left;"><a id="add" href="javascript:" class="easyui-linkbutton"
                                 data-options="iconCls:'icon-add',plain:true">添加</a></div>
    <div style="float: left;" class="datagrid-btn-separator"></div>
    <%-- 通过JSTL设置用户操作权限: 将修改和删除按钮设置为仅管理员可见 --%>
    <c:if test="${userType==1}">
        <div style="float: left;"><a id="edit" href="javascript:" class="easyui-linkbutton"
                                     data-options="iconCls:'icon-edit',plain:true">修改</a></div>
        <div style="float: left;" class="datagrid-btn-separator"></div>
        <div style="float: left;"><a id="delete" href="javascript:" class="easyui-linkbutton"
                                     data-options="iconCls:'icon-some-delete',plain:true">删除</a></div>
    </c:if>

    <!-- 教师,班级名搜索域 -->
    <div style="margin-left: 10px;">
        <div style="float: left;" class="datagrid-btn-separator"></div>
        <!-- 班级名称下拉框 -->
        <a href="javascript:" class="easyui-linkbutton"
           data-options="iconCls:'icon-class',plain:true">班级名称</a>
        <select id="search-clazzname" style="width: 155px;" class="easyui-combobox" name="clazzname">
            <!-- 通过JSTL遍历显示年级信息,clazzList:为Contrller传递的来的,存储着Clazz的List对象 -->
            <option value="">未选择班级</option>
            <c:forEach items="${clazzList}" var="clazz">
                <option value="${clazz.name}">${clazz.name}</option>
            </c:forEach>
        </select>
        <!-- 教师姓名搜索框 -->
        <a href="javascript:" class="easyui-linkbutton"
           data-options="iconCls:'icon-user-teacher',plain:true">教师名称</a>
        <input id="search-teachername" class="easyui-textbox" name="studentname"/>
        <!-- 搜索按钮 -->
        <a id="search-btn" href="javascript:" class="easyui-linkbutton"
           data-options="iconCls:'icon-search',plain:true">搜索</a>
    </div>
</div>

<!-- 添加信息窗口 -->
<div id="addDialog" style="padding: 15px 0 0 55px;">
    <!-- 设置添加头像功能 -->
    <div style="float: right; margin: 15px 40px 0 0; width: 250px; border: 1px solid #EEF4FF" id="add-photo">
        <img id="add-portrait" alt="照片" style="max-width: 250px; max-height: 300px;" title="照片"
             src="${pageContext.request.contextPath}/image/portrait/default_teacher_portrait.png"/>
        <!-- 头像信息表单 -->
        <form id="add-uploadForm" method="post" enctype="multipart/form-data" action="uploadPhoto"
              target="photo_target">
            <input id="choose-portrait" class="easyui-filebox" name="photo" data-options="prompt:'选择照片'"
                   style="width:200px;">
            <input id="add-upload-btn" class="easyui-linkbutton" style="width: 50px; height: 24px;;float:right;"
                   type="button" value="上传"/>
        </form>
    </div>
    <!-- 教师信息表单 -->
    <form id="addForm" method="post" action="#">
        <table id="addTable" style="border-collapse:separate; border-spacing:0 3px;" cellpadding="6">
            <!-- 存储所上传的头像路径 -->
            <input id="add_portrait-path" type="hidden" name="portrait_path"/>
            <tr>
                <td>班级</td>
                <td colspan="1">
                    <select id="add_clazz_name" style="width: 200px; height: 30px;" class="easyui-combobox"
                            name="clazz_name" data-options="required:true, missingMessage:'请选择所属班级哟~'">
                        <c:forEach items="${clazzList}" var="clazz">
                            <option value="${clazz.name}">${clazz.name}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td>姓名</td>
                <td colspan="1">
                    <input id="add_name" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="name" data-options="required:true, missingMessage:'请填写姓名哟~'"/>
                </td>
            </tr>
            <tr>
                <td>性别</td>
                <td>
                    <select id="add_gender" class="easyui-combobox"
                            data-options="editable: false, panelHeight: 50, width: 60, height: 30,
                            required:true, missingMessage:'请选择性别哟~'" name="gender">
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>工号</td>
                <td colspan="1">
                    <input id="add_tno" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="tno" data-options="required:true, missingMessage:'请填写工号哟~'"/>
                </td>
            </tr>
            <tr>
                <td>密码</td>
                <td colspan="1">
                    <input id="add_password" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="password" name="password" data-options="required:true, missingMessage:'请填写自定义密码哟~'"/>
                </td>
            </tr>
            <tr>
                <td>邮箱</td>
                <td colspan="1"><input id="add_email" style="width: 200px; height: 30px;" class="easyui-textbox"
                                       type="text" name="email" validType="email"
                                       data-options="required:true, missingMessage:'请填写邮箱地址哟~'"/>
                </td>
            </tr>
            <tr>
                <td>电话</td>
                <td colspan="4"><input id="add_telephone" style="width: 200px; height: 30px;" class="easyui-textbox"
                                       type="text" name="telephone" validType="mobile"
                                       data-options="required:true, missingMessage:'请填写联系方式哟~'"/>
                </td>
            </tr>
            <tr>
                <td>住址</td>
                <td colspan="1"><input id="add_address" style="width: 200px; height: 30px;" class="easyui-textbox"
                                       type="text" name="address"
                                       data-options="required:true, missingMessage:'请填写家庭住址哟~'"/>
                </td>
            </tr>
        </table>
    </form>
</div>


<!-- 修改信息窗口 -->
<div id="editDialog" style="padding: 20px 0 0 65px">
    <!-- 设置修改头像功能 -->
    <div style="float: right; margin: 15px 40px 0 0; width: 250px; border: 1px solid #EEF4FF" id="edit-photo">
        <img id="edit-portrait" alt="照片" style="max-width: 250px; max-height: 300px;" title="照片"
             src="${pageContext.request.contextPath}/image/portrait/default_student_portrait.png"/>
        <!-- 头像信息表单 -->
        <form id="edit-uploadForm" method="post" enctype="multipart/form-data" action="uploadPhoto"
              target="photo_target">
            <input id="edit-choose-portrait" class="easyui-filebox" name="photo" data-options="prompt:'选择照片'"
                   style="width:200px;">
            <input id="edit-upload-btn" class="easyui-linkbutton" style="width: 50px; height: 24px;;float:right;"
                   type="button" value="上传"/>
        </form>
    </div>
    <!-- 教师信息表单 -->
    <form id="editForm" method="post" action="#">
        <!-- 获取被修改信息的教师id -->
        <input type="hidden" id="edit_id" name="id"/>
        <table id="editTable" style="border-collapse:separate; border-spacing:0 3px;" cellpadding="6">
            <!-- 存储所上传的头像路径 -->
            <input id="edit_portrait-path" type="hidden" name="portrait_path"/>
            <tr>
                <td>班级</td>
                <td colspan="1">
                    <select id="edit_clazz_name" style="width: 200px; height: 30px;" class="easyui-combobox"
                            name="clazz_name">
                        <c:forEach items="${clazzList}" var="clazz">
                            <option value="${clazz.name}">${clazz.name}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td>姓名</td>
                <td colspan="1">
                    <input id="edit_name" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="name" data-options="required:true, missingMessage:'请填写姓名哟~'"/>
                </td>
            </tr>
            <tr>
                <td>性别</td>
                <td>
                    <select id="edit_gender" class="easyui-combobox"
                            data-options="editable: false, panelHeight: 50, width: 60, height: 30" name="gender">
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>工号</td>
                <td colspan="1">
                    <!-- 设置为只读 -->
                    <input id="edit_tno" data-options="readonly: true" style="width: 200px; height: 30px;"
                           class="easyui-textbox" type="text"/>
                </td>
            </tr>
            <tr>
                <td>邮箱</td>
                <td colspan="1"><input id="edit_email" style="width: 200px; height: 30px;" class="easyui-textbox"
                                       type="text" name="email" validType="email"
                                       data-options="required:true, missingMessage:'请填写邮箱地址哟~'"/>
                </td>
            </tr>
            <tr>
                <td>电话</td>
                <td colspan="4"><input id="edit_telephone" style="width: 200px; height: 30px;" class="easyui-textbox"
                                       type="text" name="telephone" validType="mobile"
                                       data-options="required:true, missingMessage:'请填写联系方式哟~'"/>
                </td>
            </tr>
            <tr>
                <td>住址</td>
                <td colspan="1"><input id="edit_address" style="width: 200px; height: 30px;" class="easyui-textbox"
                                       type="text" name="address"
                                       data-options="required:true, missingMessage:'请填写家庭住址哟~'"/>
                </td>
            </tr>
        </table>
    </form>
</div>

<!-- 表单处理 -->
<iframe id="photo_target" name="photo_target" onload="uploaded(this)"></iframe>

</body>
</html>
