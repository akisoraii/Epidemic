<%--
  Created by IntelliJ IDEA.
  User: akisora
  Date: 2020/10/19
  Time: 16:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="row">
    <%--            默认占满12列,加入class="col-md-12"会产生内边距15px,优点:自动自适应宽度,缺点:有空隙--%>
    <div class="col-md-6 col-md-offset-2 header" style="margin-bottom: 40px">
        疫情数据发布系统
    </div>
    <div class="col-md-2 col-md-offset-2" style="margin-top: 20px">
        <p>欢迎你:<span class="label label-info">${loginUser.userName}</span></p>
        <a href="${pageContext.request.contextPath}/user/logout" class="btn btn-danger">退出登录</a>
    </div>
</div>
