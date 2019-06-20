package pers.huangyuhui.sms.bean;

/**
 * @project: sms
 * @description: 班级信息
 * @author: 黄宇辉
 * @date: 6/14/2019-5:01 PM
 * @version: 1.0
 * @website: https://yubuntu0109.github.io/
 */
public class Clazz {
    //班级信息
    private Integer id;
    private String name;
    private String number;
    private String introducation;
    //班主任信息
    private String coordinator;
    private String telephone;
    private String email;
    //所属年级
    private String grade_name;

    public Clazz(String name, String grade_name) {
        this.name = name;
        this.grade_name = grade_name;
    }

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

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getIntroducation() {
        return introducation;
    }

    public void setIntroducation(String introducation) {
        this.introducation = introducation;
    }

    public String getCoordinator() {
        return coordinator;
    }

    public void setCoordinator(String coordinator) {
        this.coordinator = coordinator;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getGrade_name() {
        return grade_name;
    }

    public void setGrade_name(String grade_name) {
        this.grade_name = grade_name;
    }
}
