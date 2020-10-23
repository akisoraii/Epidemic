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
                <div class="col-md-4">
                    <div class="input-group date" id="datepicker" data-date-format="yyyy-mm-dd">
                        <div class="input-group-addon">数据日期</div>
                        <input class="form-control" size="16" type="text" value="" readonly id="dataDate">
                        <div class="input-group-addon">
                            <span class="add-on glyphicon glyphicon-calendar"></span>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <button type="button" class="btn btn-primary" id="btnSubmit">提交 <span
                            class="glyphicon glyphicon-ok"></span></button>
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
                    </tbody>
                </table>
            </div>
            <div class="row">
                <div id="msg"></div>
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
    let provinces = null;
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
        //给提交按钮绑定事件处理函数
        $("#btnSubmit").click(checkAndSubmitData);
    });

    function checkAndSubmitData() {
        let valid = true;
        const affirmed = $("input[name=affirmed]");
        const suspected = $("input[name=suspected]");
        const isolated = $("input[name=isolated]");
        const cured = $("input[name=cured]");
        const dead = $("input[name=dead]");
        affirmed.each(function (index, element) {
            if (isNaN(Number(element.value))) {
                valid = false;
            }
        });
        if (valid) {
            //提交
            const dataArray = [];
            for (let i = 0; i < provinces.length; i++) {
                const obj = {};
                obj.provinceId = provinces[i].provinceId;
                obj.affirmed = affirmed.get(i).value;
                obj.suspected = suspected.get(i).value;
                obj.isolated = isolated.get(i).value;
                obj.cured = cured.get(i).value;
                obj.dead = dead.get(i).value;
                dataArray.push(obj);
            }
            const date = $("#dataDate").val();
            const data={};
            data.date=date;
            data.array=dataArray;

            //传统post提交方式
            <%--$.post("${pageContext.request.contextPath}/epidemicData/ajax/input",data,function (resp) {--%>
            <%--    console.info(resp)--%>
            <%--});--%>
            //使用ajax提交方式

            $.ajax({
                url:"${pageContext.request.contextPath}/epidemicData/ajax/input",
                type:"POST",
                contentType:"application/json",
                data:JSON.stringify(data),
                dataType:"json",
                success:function (resp) {
                    if (resp.code < 0) {
                        alert(resp.msg);
                    } else {
                        //加载未录入数据
                        fillProvinceToTable(resp.data);
                        alert("提交成功!");
                    }
                }
            })
        } else {
            alert("请检查你的输入,确保输入有效的数值!");
        }
    }

    function loadProvinceList() {
        //清空消息
        $("#msg").empty();
        //获取当前日期框的日期
        const date = $("#dataDate").val();

        //从服务器获取未录入数据的省份列表(get请求),发送date格式数据,在回调函数中处理结果
        $.get("${pageContext.request.contextPath}/province/ajax/noDataList", {date: date}, function (resp) {
            if (resp.code < 0) {
                alert(resp.msg);
            } else {
                //加载未录入数据
                fillProvinceToTable(resp.data);
            }
        }, "json");
    }

    function fillProvinceToTable(array) {
        //清空表格
        const tbody1 = $("#body1");
        tbody1.empty();
        //获取数据
        if (array && array.length > 0) {
            provinces = array;
            console.info(provinces)
            //填充到表格中
            $.each(array, function (index, province) {
                const tr = $("<tr>");
                let td = $("<td>");

//----------------------------------------------------------
                td.text(province.provinceName);
                tr.append(td);
//----------------------------------------------------------
                td = $("<td>");
                td.html('<input type="text" name="affirmed" size="4" maxlength="4" class="form-control" value="0">');
                tr.append(td);
//----------------------------------------------------------
                td = $("<td>");
                td.html('<input type="text" name="suspected" size="4" maxlength="4" class="form-control" value="0">');
                tr.append(td);
//----------------------------------------------------------
                td = $("<td>");
                td.html('<input type="text" name="isolated" size="4" maxlength="4" class="form-control" value="0">');
                tr.append(td);
//----------------------------------------------------------
                td = $("<td>");
                td.html('<input type="text" name="cured" size="4" maxlength="4" class="form-control" value="0">');
                tr.append(td);
//----------------------------------------------------------
                td = $("<td>");
                td.html('<input type="text" name="dead" size="4" maxlength="4" class="form-control" value="0">');
                tr.append(td);

                tbody1.append(tr)
            });

        } else {
            $("#msg").html("所有省份今日数据已录入完成!")
        }
    }
</script>
</body>
</html>
