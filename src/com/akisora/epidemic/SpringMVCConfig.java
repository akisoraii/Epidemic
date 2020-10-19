package com.akisora.epidemic;

import com.akisora.epidemic.common.DateConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.format.FormatterRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.config.annotation.*;

/*
* SpringMVC配置类
* */

@Configuration    //Spring配置类注解
@EnableWebMvc     //自动注册SpringMVC的映射和构造器注解
//组件扫描注解,缺省则扫描包及其子包所有类,这里指定了扫描对象.扫描指定的包路径下带有@Controller、@Service、@Repository、@Component的类
@ComponentScan(includeFilters =
@ComponentScan.Filter(type = FilterType.ANNOTATION,classes = Controller.class))
public class SpringMVCConfig extends WebMvcConfigurerAdapter {

    @Autowired
    private DateConverter dateConverter;

    //添加视图控制器
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        //客户端发来请求没有明确指明访问哪一个资源,则返回epidemic视图名
        registry.addViewController("/").setViewName("epidemic");
    }

    //配置视图解析器
    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        //定义了一个内部资源视图解析器(InternalResourceViewResolver)
        registry.jsp("/", ".jsp");
    }

    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }

    //配置日期转换器
    @Override
    public void addFormatters(FormatterRegistry registry) {
        registry.addConverter(dateConverter);
    }
}
