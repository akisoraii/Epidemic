疫情数据发布系统

一、需求分析(产品经理、技术经理、需求分析师)
1、全国疫情统计分布图
    全国地图，通过颜色区分各个省份的确诊人数的严重性
    表格数据，展示每个省份确诊人数(累计，新增)，疑似人数(累计，新增)，治愈人数(累计，新增)，死亡人数(累计，新增)，隔离人数(累计，新增)
    使用Axure绘制界面草图。

2、按省份划分的变化曲线图
   折线图展示近10天以来，这种数据的变化曲线。用户可以改变省份，可以改变时间范围长度(近5天，近10天，近15天，近30天)。

3、登录
   账号+密码

4、数据录入界面
   可以录入每个省份每日的各种数据。

二、数据库设计
确定采用的数据库管理系统(MySQL)，设计数据库中的表。
安装MySQL，SqlYog，PowerDesigner；

按住Shift键单击鼠标右键，选择[开控制台打开窗口]，可以快速打开命令行窗口。
D:\mysql-5.7.24-winx64\bin>
>mysqld --initialize-insecure --console

>mysqld --install MySQL57

>net start MySQL57

>mysqladmin -u root -p password
  root12345
>mysql -u root -p
mysql>use mysql;
mysql> update user set host='%' where user='root' and host='localhost';
mysql> flush privileges;
mysql>exit;

使用PowerDesigner设计物理数据模型，之后生成sql脚本，然后在SQLYog执行脚本。

三、概要设计
页面设计：
       页面名称        页面存放路径        访问权限        备注
       epidemic.jsp      /                   所有人
       change.jsp        /                   所有人
       login.jsp          /                   所有人
       data_input.jsp     /admin              登录系统的用户
       statistics.jsp       /admin               登录系统的用户

四、搭建项目的基本框架

Idea中配置：File  ->  Project Structure
   Modules  ->  Dependences  可以添加项目的依赖
   Libraries  ->  可以自定义库(一个库中可以包含多个jar包)
   Facets  -> 配置项目特性 (Web特性，其它框架特性)
   Artifacts  -> 配置项目最终生成的构件。


加入SSM框架
    Spring(管理应用程序中的对象，AOP声明式事务管理)  
    SpringMVC(方便的将客户端发来的请求关联到类中方法上，装载请求参数，输入校验)  
    MyBatis(对数据库的各种CRUD操作)

1、加入SpringMVC+Spring依赖的jar包
   应用程序的分层：展现层/表现层,控制层,业务逻辑层,数据访问层
   创建各个层对应的java包；
  
   拷贝SpringMVC和Spring相关的jar包：
               

   AOP相关的依赖jar包：
    

    日志jar包：
     


	如果是idea，需要在Project Structure中配置Modules/Dependencies。
	还要配置Artifacts。
2、编写应用程序初始化类
	继承自 AbstractAnnotationConfigDispatcherServeltInitializer类；
实现父类规定的三个方法。 (Alt+Insert)
public class EpidemicApplicationInitializer extends 
                               AbstractAnnotationConfigDispatcherServletInitializer {
    @Override
    protected Class<?>[] getRootConfigClasses() {
        //Spring的配置类
        return new Class[0];
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
        //Spring MVC的配置类
        return new Class[]{SpringMVCConfig.class};
    }

    @Override
    protected String[] getServletMappings() {
        //返回映射到DispatcherServlet的请求路径
        return new String[]{"/"};
    }
}

	SpringMVC的配置类：
@Configuration
@EnableWebMvc
@ComponentScan(includeFilters = @ComponentScan.Filter(type = FilterType.ANNOTATION, classes = Controller.class))
public class SpringMVCConfig extends WebMvcConfigurerAdapter {

    //添加视图控制器
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("epidemic");
    }

    //配置视图解析器
    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        //定义了一个内部资源视图解析器(InternalResourceViewResolver)
        registry.jsp("/", ".jsp");
    }
}


	加入Log4j日志jar包

   
  给src目录下放置 


	Ctrl+Shift+f  格式化代码

3、加入mybatis框架
拷贝jar包；
 
 
 
 
 

编写配置类。
@Configuration
@MapperScan(basePackages = "com.yueqian.epidemic.mapper")
public class MyBatisConfig {

    private static Logger logger = Logger.getLogger(MyBatisConfig.class);

    //配置数据源
    @Bean(name = "dataSource", destroyMethod = "close")
    public BasicDataSource basicDataSource() {
        BasicDataSource dataSource = new BasicDataSource();
        dataSource.setDriverClassName("com.mysql.jdbc.Driver");
        dataSource.setUrl("jdbc:mysql://127.0.0.1:3306/epidemic");
        dataSource.setUsername("root");
        dataSource.setPassword("root12345");

        dataSource.setInitialSize(3);
        dataSource.setMaxActive(50);
        dataSource.setMaxIdle(1);
        dataSource.setMaxWait(4000);
        dataSource.setDefaultAutoCommit(false);
        return dataSource;
    }

    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) {
        SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
        //设置要使用的数据源
        factoryBean.setDataSource(dataSource);

        SqlSessionFactory factory = null;
        try {
            //设置映射xml文件的路径
            Resource[] resources = new PathMatchingResourcePatternResolver().getResources("classpath:com/yueqian/epidemic/mapper/*Mapper.xml");
            factoryBean.setMapperLocations(resources);
            factory = factoryBean.getObject();
        } catch (Exception e) {
            logger.error("解析映射xml文件时异常:" + e.getMessage());
        }
        //设置xml文件中的类所在的包
        factoryBean.setTypeAliasesPackage("com.yueqian.epidemic.beans");

        //为了让myBatis自动将下划线分隔的列名转换为驼峰表示的属性名
        org.apache.ibatis.session.Configuration configuration=new org.apache.ibatis.session.Configuration();
        configuration.setMapUnderscoreToCamelCase(true);
        factoryBean.setConfiguration(configuration);

        return factory;
    }
}

五、开发页面

