package com.akisora.epidemic;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;


/*
* 应用Spring初始化器
* */
public class EpidemicApplicationInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

    //返回Spring IoC容器的Java配置类
    @Override
    protected Class<?>[] getRootConfigClasses() {
        //Spring的配置类
        return new Class[]{SpringConfig.class};
    }

    //返回Spring MVC的Java配置类
    @Override
    protected Class<?>[] getServletConfigClasses() {
        //Spring MVC的配置类
        return new Class[]{SpringMVCConfig.class};
    }

    //返回DispatcherServlet映射的路径
    @Override
    protected String[] getServletMappings() {
        //返回映射到DispatcherServlet的请求路径
        return new String[]{"/"};
    }
}
