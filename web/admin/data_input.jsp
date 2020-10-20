<%--
  Created by IntelliJ IDEA.
  User: akisora
  Date: 2020/10/19
  Time: 17:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>疫情数据录入</title>
    <jsp:include page="../template/bootstrap_common.jsp"></jsp:include>
    <link rel="stylesheet" type="text/css" href="../bootstrap/datepicker/bootstrap-datepicker3.css">
</head>
<body>
<div class="container">
    <jsp:include page="../template/top.jsp"></jsp:include>
    <div class="row">
        <div class="class col-md-2">
            <jsp:include page="../template/menu.jsp"></jsp:include>
        </div>
        <div class="col-md-10">
            <ul class="breadcrumb">
                <li><a href="../main.jsp">主页</a></li>
                <li>数据录入</li>
            </ul>
            <div class="row">
                <div class="input-group date col-md-4" id="datepicker" data-date-format="yyyy-mm-dd">
                    <div class="input-group-addon">数据日期</div>
                    <input class="form-control" size="16" type="text" value="" readonly id="dataDate">
                    <div class="input-group-addon">
                        <span class="add-on glyphicon glyphicon-calendar"></span>
                    </div>
                </div>
            </div>
            <br>
            <div class="row">
                <table class="table table-striped table-hover table-bordered">
                    <thead>
                    <tr>
                        <th>省份</th>
                        <th>确诊人数</th>
                        <th>疑似人数</th>
                        <th>隔离人数</th>
                        <th>治愈人数</th>
                        <th>死亡人数</th>
                    </tr>
                    </thead>
                    <tbody id="body1">
                    <tr>
                        <td>湖北</td>
                        <td><input type="text" name="affirmed" size="4" maxlength="4" class="form-control"></td>
                        <td><input type="text" name="suspected" size="4" maxlength="4" class="form-control"></td>
                        <td><input type="text" name="isolated" size="4" maxlength="4" class="form-control"></td>
                        <td><input type="text" name="cured" size="4" maxlength="4" class="form-control"></td>
                        <td><input type="text" name="dead" size="4" maxlength="4" class="form-control"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../template/footer.jsp"></jsp:include>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/bootstrap/datepicker/bootstrap-datepicker.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/bootstrap/datepicker/bootstrap-datepicker.zh-CN.min.js"></script>
<script type="text/javascript">
    //使用bootstrap特性注册日期选择器函数
    $(function () {
        //设置日期输入框的初始值和取值范围
        const datepicker = $("#datepicker");
        datepicker.datepicker({
            language: 'zh-CN',
            autoclose: true
        });
        const current = new Date();
        datepicker.datepicker("setDate", current);
        const date1 = new Date();
        date1.setDate(current.getDate() - 7);
        datepicker.datepicker("setStartDate", date1);
        datepicker.datepicker("setEndDate", current);
        //给日期选择框设置事件处理函数
        datepicker.datepicker().on("changeDate", loadProvinceList);
        //装载省份列表
        loadProvinceList();
    });

    function loadProvinceList() {
        //清空表格
        const tbody1 = $("#body1");
        tbody1.empty()
        //获取当前日期框的日期
        const date = $("#dataDate").val();

        //从服务器获取未录入数据的省份列表(get请求),发送date格式数据,在回调函数中处理结果
        $.get("${pageContext.request.contextPath}/province/ajax/noDataList", {date: date}, function (resp) {
            console.info(resp);
        }, "json");
    }
</script>
</body>
</html>
