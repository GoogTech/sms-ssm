## :school::mortar_board::sparkles: a simple student management system , created by SSM framework ~


### 项目概述  (:speech_balloon: pause update)
:+1:*一个基于SSM的学生管理系统 : 代码注释详细,逻辑结构清晰,非常具有参考,学习价值哟 !*

:key:*数据库中默认的管理员身份信息 : 账户名 : `黄宇辉` , 密码 `demo0109`*


### 用户权限介绍
- *管理员 : 具有所有管理模块的操控权限*
- *教师 : 仅具有学生信息管理模块的所有权限,且在教师信息管理模块中只具有查询及添加信息的权限*
- *学生 : 仅具有学生信息管理模块的查询及添加信息的权限*


### 项目截图 (`管理员身份登录`)
- *用户登录页面*

![](https://raw.githubusercontent.com/YUbuntu0109/SSM-SMS/master/demonstration_picture/SMS-Login-view.PNG)

- *系统主页面*

![](https://raw.githubusercontent.com/YUbuntu0109/SSM-SMS/master/demonstration_picture/SSM-Main-view.PNG)

- *管理员信息管理页面*

![](https://raw.githubusercontent.com/YUbuntu0109/SSM-SMS/master/demonstration_picture/SSM-AdminInfo-view.PNG)

- *学生信息管理页面*

![](https://raw.githubusercontent.com/YUbuntu0109/SSM-SMS/master/demonstration_picture/SMS-StudentInfo-view.PNG)

- *教师信息管理页面*

![](https://raw.githubusercontent.com/YUbuntu0109/SSM-SMS/master/demonstration_picture/SMS-TeacherInfo-view.PNG)

- *年级信息管理页面*

![](https://raw.githubusercontent.com/YUbuntu0109/SSM-SMS/master/demonstration_picture/SMS-GradeInfo-view.PNG)

- *班级信息管理页面*

![](https://raw.githubusercontent.com/YUbuntu0109/SSM-SMS/master/demonstration_picture/SMS-ClassInfo-view.PNG)

- *个人信息管理页面*

![](https://raw.githubusercontent.com/YUbuntu0109/SSM-SMS/master/demonstration_picture/SMS-ModifyPwd-view.PNG)


### 项目截图 (`教师身份登录`)
- *教师仅具有学生信息管理模块的所有权限,且在教师信息管理模块中只具有查询及添加信息的权限*
![](https://raw.githubusercontent.com/YUbuntu0109/SSM-SMS/master/demonstration_picture/SMS-Teacher-permission.PNG)


### 项目截图 (`学生身份登录`)
- *学生仅具有学生信息管理模块的查询及添加信息的权限*
![](https://raw.githubusercontent.com/YUbuntu0109/SSM-SMS/master/demonstration_picture/SMS-Student-permission.PNG)


### 项目结构
```
│  .gitattributes
│  LICENSE
│  README.md
│
├─database file
│      ssm_sms.sql
│
├─demonstration_picture
│      SMS-ClassInfo-view.PNG
│      SMS-GradeInfo-view.PNG
│      SMS-Login-view.PNG
│      SMS-ModifyPwd-view.PNG
│      SMS-Student-permission.PNG
│      SMS-StudentInfo-view.PNG
│      SMS-Teacher-permission.PNG
│      SMS-TeacherInfo-view.PNG
│      SSM-AdminInfo-view.PNG
│      SSM-Main-view.PNG
│
└─sms
    │  pom.xml
    │
    │
    └─src
        └─main
            ├─java
            │  └─pers
            │      └─huangyuhui
            │          └─sms
            │              ├─bean
            │              │      Admin.java
            │              │      Clazz.java
            │              │      Grade.java
            │              │      LoginForm.java
            │              │      Student.java
            │              │      Teacher.java
            │              │
            │              ├─controller
            │              │      AdminController.java
            │              │      ClazzController.java
            │              │      CommonController.java
            │              │      GradeController.java
            │              │      StudentController.java
            │              │      SystemController.java
            │              │      TeacherController.java
            │              │
            │              ├─dao
            │              │      AdminMapper.java
            │              │      ClazzMapper.java
            │              │      GradeMapper.java
            │              │      StudentMapper.java
            │              │      TeacherMapper.java
            │              │
            │              ├─interceptor
            │              │      LoginInterceptor.java
            │              │
            │              ├─service
            │              │  │  AdminService.java
            │              │  │  ClazzService.java
            │              │  │  GradeService.java
            │              │  │  StudentService.java
            │              │  │  TeacherService.java
            │              │  │
            │              │  └─impl
            │              │          AdminServiceImpl.java
            │              │          ClazzServiceImpl.java
            │              │          GradeServiceImpl.java
            │              │          StudentServiceImpl.java
            │              │          TeacherServiceImpl.java
            │              │
            │              └─util
            │                      CreateVerifiCodeImage.java
            │                      UploadFile.java
            │
            ├─resource
            │  ├─database-conf
            │  │      c3p0.properties
            │  │
            │  ├─mapper
            │  │      AdminMapper.xml
            │  │      ClazzMapper.xml
            │  │      GradeMapper.xml
            │  │      StudentMapper.xml
            │  │      TeacherMapper.xml
            │  │
            │  ├─mybatis-conf
            │  │      mybatis-config.xml
            │  │
            │  └─spring-conf
            │          applicationContext.xml
            │          springmvc-config.xml
            │
            └─webapp
                │  index.jsp
                │
                ├─image
                │  └─portrait
                │          default_admin_portrait.png
                │          default_student_portrait.png
                │          default_teacher_portrait.png
                │
                ├─static
                │  ├─easyui
                │  │  │  
                │  │  ├─css     
                │  │  │
                │  │  ├─js    
                │  │  │
                │  │  └─themes
                │  │     
                │  │
                │  └─h-ui
                │      │(略..)
                │        
                │            
                │
                └─WEB-INF
                    │  web.xml
                    │
                    └─view
                        ├─admin
                        │      adminList.jsp
                        │
                        ├─clazz
                        │      clazzList.jsp
                        │
                        ├─common
                        │      settings.jsp
                        │
                        ├─error
                        │      404.jsp
                        │      500.jsp
                        │
                        ├─grade
                        │      gradeList.jsp
                        │
                        ├─student
                        │      studentList.jsp
                        │
                        ├─system
                        │      intro.jsp
                        │      login.jsp
                        │      main.jsp
                        │
                        └─teacher
                                teacherList.jsp
```

#### 项目文件说明-`数据库文件`
```
ssm_sms.sql
```

#### 项目文件说明-`数据库配置信息`
```
c3p0.properties
```

#### 项目文件说明-`H-ui 前端框架`
```
h-ui/
```

#### 项目文件说明-`EasyUI 前端框架`
```
easyui/
```

#### 项目文件说明-`Spring 核心配置文件`
```
applicationContext.xml
```

#### 项目文件说明-`Spring MVC 核心配置文件`
```
springmvc-config.xml
```

#### 项目文件说明-`MyBatis 核心配置文件`
```
mybatis-config.xml
```

#### 项目文件说明-`Mapper 接口映射文件`
```
mapper/
```

#### 项目文件说明-`用户默认头像`
```
portrait/
```


#### 数据库ER图
:sweat_smile: *数据库设计待优化 : 数据表之间的并没有设置约束关系,等你优化哟,好尴尬嘻嘻· · ·*
![](https://raw.githubusercontent.com/YUbuntu0109/SSM-SMS/master/demonstration_picture/SMS-Database-ER.png)

#### Jar包依赖关系图
![](https://raw.githubusercontent.com/YUbuntu0109/SSM-SMS/master/demonstration_picture/SMS-Jar-dependency.png)



:clock8: *`2019-7-2`回首仔细阅读并认真思索该项目的源码,发现该项目中的代码其实非常臃肿呀,其可扩张性也很差哟 ! 这毕竟是我第一个`SSM`小项目,所以请原谅吧嘿嘿~ 为了让你写出更加优美的代码及更加具有可扩张性的项目,这里我给出了一个可作为`重构`该项目的参考案例 ：https://github.com/YUbuntu0109/springboot-beginner/tree/refactor-190823 , 及一个可供你近一步参考与学习的小项目 : https://github.com/YUbuntu0109/springboot-shiro*



*:books:更多有趣项目及详细学习笔记请前往我的个人博客哟（づ￣3￣）づ╭❤～ : https://yubuntu0109.github.io/*

*👩‍💻学习笔记已全部开源 : https://github.com/YUbuntu0109/YUbuntu0109.github.io*
 
*:coffee: Look forward to your contribution, if you need any help, please contact me~ QQ : 3083968068*
