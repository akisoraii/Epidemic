一、需求分析（产品经理、技术经理、需求分析师）、（使用Axure绘制界面草图）
	1、全国疫情统计分布图
		全国地图 ，通过颜色区分各个省份的确诊人数 的严重性 
		表格数据，展示每个省份确诊人数（累计，新增），疑似人数（累计，新增），治愈人数（累计，新增），死亡人数
	2、按省份划分的变化曲线图
		折线图展示近10天以来，各种数据的变化曲线。用户可以改变省份，可以改变时间范围长度（近5天，近10天，近15天，近30天）
	3、登录功能
		管理员账号+密码
	4、数据录入界面
		可以录入每个 省份每日的各种数据

二、数据库设计
	1、确定采用的数据库管理系统（MySQL）
	2、设计数据库中的表(PowerDesigner)
	3、将生成的sql脚本文件导入SQLyog

三、概要设计
	页面设计

四、搭建项目基本框架
	IDEA中的配置
	加入SSM框架
		1、加入SpringMVC+Spring依赖的jar包
			spring-aop-4.3.3.RELEASE.jar
			spring-aspects-4.3.3.RELEASE.jar
			spring-beans-4.3.3.RELEASE.jar
			spring-context-4.3.3.RELEASE.jar
			spring-context-support-4.3.3.RELEASE.jar
			spring-core-4.3.3.RELEASE.jar
			spring-expression-4.3.3.RELEASE.jar
			spring-jdbc-4.3.3.RELEASE.jar
			spring-tx-4.3.3.RELEASE.jar
			spring-web-4.3.3.RELEASE.jar
			spring-webmvc-portlet-4.3.3.RELEASE.jar
			aspectjweaver.jar
			cglib-2.2.0.jar
			commons-logging-1.2.jar
		2、编写应用程序初始化类
			log4j-1.2.17.jar
			slf4j-api-1.7.25.jar
			slf4j-log4j12-1.7.25.jar
			log4j.properties
		3、加入mybatis框架依赖jar包
			mybatis-3.4.6.jar
			mybatis-spring-1.3.2.jar
			mysql-connector-java-5.1.45-bin.jar
			commons-dbcp-1.4.jar
			commons-pool-1.6.jar

五、开发页面
