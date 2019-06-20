package pers.huangyuhui.sms.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @project: sms
 * @description: 用户登录拦截器
 * @author: 黄宇辉
 * @date: 6/11/2019-5:15 PM
 * @version: 1.0
 * @website: https://yubuntu0109.github.io/
 */
public class LoginInterceptor implements HandlerInterceptor {

    //该方法会在控制器方法前执行,其返回值表示是否中断后续操作
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //获取请求的url
        String url = request.getRequestURI();
        //判断用户是否已登录
        if (request.getSession().getAttribute("userInfo") != null) {
            return true;
        }
        //用户未登录,拦击其请求并将其转发到用户登录页面
        request.getRequestDispatcher("/WEB-INF/view/system/login.jsp").forward(request, response);
        return false;
    }

    //该方法会在控制器方法调用之后,且解析视图之前调用
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    //该方法会在整个请求完成,既视图渲染结束之后执行
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
