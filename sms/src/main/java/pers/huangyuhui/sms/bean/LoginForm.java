package pers.huangyuhui.sms.bean;

/**
 * @project: ssm_sms
 * @description: 用户登录表单信息
 * @author: 黄宇辉
 * @date: 6/10/2019-10:31 AM
 * @version: 1.0
 * @website: https://yubuntu0109.github.io/
 */
public class LoginForm {

    private String username;
    private String password;
    private String verifiCode;
    private Integer userType;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getVerifiCode() {
        return verifiCode;
    }

    public void setVerifiCode(String verifiCode) {
        this.verifiCode = verifiCode;
    }

    public Integer getUserType() {
        return userType;
    }

    public void setUserType(Integer userType) {
        this.userType = userType;
    }
}
