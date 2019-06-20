package pers.huangyuhui.sms.bean;

/**
 * @project: sms
 * @description: 年级及年级主任信息
 * @author: 黄宇辉
 * @date: 6/14/2019-10:19 AM
 * @version: 1.0
 * @website: https://yubuntu0109.github.io/
 */
public class Grade {

    //年级信息
    private Integer id;
    private String name;
    private String introducation;
    //年级主任信息
    private String manager;
    private String email;
    private String telephone;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIntroducation() {
        return introducation;
    }

    public void setIntroducation(String introducation) {
        this.introducation = introducation;
    }

    public String getManager() {
        return manager;
    }

    public void setManager(String manager) {
        this.manager = manager;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }
}