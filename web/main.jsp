<%--
  Created by IntelliJ IDEA.
  User: akisora
  Date: 2020/10/15
  Time: 14:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>疫情发布系统后台管理</title>
    <jsp:include page="template/bootstrap_common.jsp"></jsp:include>
</head>
<body>
<div class="container">
    <%--        头部--%>
    <jsp:include page="template/top.jsp"></jsp:include>
    <div class="row">
        <%--        左侧菜单--%>
        <div class="col-md-2">
            <jsp:include page="template/menu.jsp"></jsp:include>
        </div>

        <%--        右侧内容--%>
        <div class="col-md-10">
            <ul class="breadcrumb">
                <li><a href="../template/menu.jsp">主页</a></li>
            </ul>
            这是主页
        </div>
    </div>
    <div class="row">footer</div>
</div>
<jsp:include page="template/footer.jsp"></jsp:include>
</body>
</html>
