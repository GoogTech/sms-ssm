## 一个Mini的学生管理系统
* ❗ 项目根目录为 : sms-ssm/sms/
* ❗ 若配置好环境后运行仍抛出异常, 请参考这个[解决方法](https://github.com/GoogTech/sms-ssm/issues/15#issue-645716616)


### 项目概述
:+1:*一个基于SSM的学生管理系统 : 代码注释详细,逻辑结构清晰,**对于初学 SSM 的同学非常具有参考,及学习价值哟 !***

:key:*数据库中默认的管理员身份信息 : 账户名 : `黄宇辉` , 密码 `demo0109`*


### 开发环境
| 工具    | 版本或描述                |    
| ------- | ------------------------ |    
| `OS`    | Windows 10               | 
| `JDK`   |  1.8                     |    
| `IDE`   | IntelliJ IDEA 2019.1     |    
| `Maven` | 3.6.0                    |    
| `MySQL` | 8.0.11                   |

> 本项目的数据库版本为`8.0.11`，请广大版本为`5.0.0+`的同学注意咯：可通过逐个复制表结构来创建该数据库哟 ~


### 用户权限介绍
- *管理员 : 具有所有管理模块的操控权限*
- *学生 : 仅具有学生信息管理模块的查询及添加信息的权限*
- *教师 : 仅具有学生信息管理模块的所有权限,且在教师信息管理模块中只具有查询及添加信息的权限*


### 项目截图
#### 管理员登录
- *用户登录页面*
<img width="960" alt="SMS-Login-view" src="https://user-images.githubusercontent.com/43493852/147872814-0d794f7d-aeb3-4edc-ac18-30398d1d8ec3.PNG">

- *系统主页面*
<img width="960" alt="SSM-Main-view" src="https://user-images.githubusercontent.com/43493852/147872824-54888fe7-8c8c-427b-b763-a00752ef3400.PNG">

- *管理员信息管理页面*
<img width="960" alt="SSM-AdminInfo-view" src="https://user-images.githubusercontent.com/43493852/147872868-4247ec05-94f2-4268-958f-2819fe1403b8.PNG">

#### 教师登录
- *教师仅具有学生信息管理模块的所有权限,且在教师信息管理模块中只具有查询及添加信息的权限*
<img width="960" alt="SMS-Teacher-permission" src="https://user-images.githubusercontent.com/43493852/147872900-b4ccc147-37fa-4fb5-96bf-d8c2708812c8.PNG">

#### 学生登录
- *学生仅具有学生信息管理模块的查询及添加信息的权限*
<img width="960" alt="SMS-Student-permission" src="https://user-images.githubusercontent.com/43493852/147872908-25678b0c-b51e-4e31-9f96-2733200182b7.PNG">


### 项目文件
数据库文件
```
ssm_sms.sql
```

数据库配置信息
```
c3p0.properties
```

H-ui 前端框架
```
h-ui/
```

EasyUI 前端框架
```
easyui/
```

Spring 核心配置文件
```
applicationContext.xml
```

Spring MVC 核心配置文件
```
springmvc-config.xml
```

MyBatis 核心配置文件
```
mybatis-config.xml
```

Mapper 接口映射文件
```
mapper/
```

用户默认头像
```
portrait/
```


### ER图
:sweat_smile: *数据库设计待优化 : 数据表之间的并没有设置约束关系,等你优化哟,好尴尬嘻嘻· · ·*
![SMS-Database-ER](https://user-images.githubusercontent.com/43493852/147872918-8450a76e-c2cd-4dc3-9669-753ee7711d80.png)


### Jar依赖关系
![SMS-Jar-dependency](https://user-images.githubusercontent.com/43493852/147872924-dc791161-7351-45f6-aa35-85ad0143d11c.png)


### 建议
> 2019-7-2回首仔细阅读并认真思索该项目的源码，惊喜地发现该项目中的代码有许多需要优化的地方，这毕竟是我第一个`SSM`小项目，所以暂请原谅吧嘿嘿~ 为了让你写出更加优美的代码及更加具有可扩张性的项目，这里我给出了一个可作为`重构`该项目的[参考案例](https://github.com/googtech/springboot-beginner/tree/refactor-190823). 如有问题请邮件联系.
