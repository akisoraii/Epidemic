package com.akisora.epidemic;

import org.apache.commons.dbcp.BasicDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import javax.sql.DataSource;

@Configuration
@MapperScan(basePackages = "com.akisora.epidemic.mapper")
public class MyBatisConfig {

    private static Logger logger = Logger.getLogger(MyBatisConfig.class);

    //配置数据源
    @Bean(name = "dataSource",destroyMethod = "close")
    public BasicDataSource basicDataSource(){
        BasicDataSource dataSource = new BasicDataSource();
        dataSource.setDriverClassName("com.mysql.jdbc.Driver");
        dataSource.setUrl("jdbc:mysql://127.0.0.1:3306/epidemic");
        dataSource.setUsername("root");
        dataSource.setPassword("password");

        //设置初始连接数
        dataSource.setInitialSize(3);
        //设置最大主动连接数
        dataSource.setMaxActive(50);
        //设置最大空闲连接数
        dataSource.setMaxIdle(1);
        //设置最大的等待时间(ms)
        dataSource.setMaxWait(4000);
        //自动提交source
        dataSource.setDefaultAutoCommit(false);
        return dataSource;
    }

    //数据库会话工厂
    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource){
        SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
        //设置要使用的数据源
        factoryBean.setDataSource(dataSource);

        SqlSessionFactory factory = null;
        try {
            //设置映射xml文件的路径
            Resource[] resources = new PathMatchingResourcePatternResolver()
                    .getResources("classpath:com/akisora/epidemic/mapper/");
            factoryBean.setMapperLocations(resources);
            factory = factoryBean.getObject();
        } catch (Exception e) {
            logger.error("解析映射xml文件时异常:\t"+e.getMessage());
        }
        //设置xml文件中的类所在的包
        factoryBean.setTypeAliasesPackage("com.akisora.epidemic.beans");

        return factory;
    }
}
