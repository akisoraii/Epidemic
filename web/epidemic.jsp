<%--
  Created by IntelliJ IDEA.
  User: akisora
  Date: 2020/10/14
  Time: 17:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>疫情分析系统</title>
    <style type="text/css">
        #body1 {
            background-color: #10A1B5;
        }

        #container {
            height: 800px;
            background-color: #ffffff;
        }
    </style>
    <jsp:include page="template/bootstrap_common.jsp"></jsp:include>
</head>
<body id="body1">
<div id="container">
    <div class="row" style="height: 400px">地图</div>
    <div class="row" style="height: 500px">表格</div>
    <div class="row"><a href="login.jsp" class="btn btn-primary">登录</a></div>

</div>
<jsp:include page="template/footer.jsp"></jsp:include>
</body>
</html>
