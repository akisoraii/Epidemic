package com.akisora.epidemic;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class EpidemicApplicationInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {
    @Override
    protected Class<?>[] getRootConfigClasses() {
        //Spring的配置类
        return new Class[0];
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
        //Spring MVC的配置类
        return new Class[0];
    }

    @Override
    protected String[] getServletMappings() {
        //返回映射到DispatcherServlet的请求路径
        return new String[]{"/"};
    }
}