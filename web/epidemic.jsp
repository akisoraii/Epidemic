<%--
  Created by IntelliJ IDEA.
  User: akisora
  Date: 2020/10/14
  Time: 17:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>疫情信息</title>
    <style type="text/css">
        #body1 {
            background-color: #10A1B5;
        }
    </style>
    <jsp:include page="template/bootstrap_common.jsp"></jsp:include>
</head>
<body id="body1">
<div class="container">
    <div class="row"><a href="login.jsp" class="btn btn-primary col-md-1 col-md-offset-11">登录</a></div>
    <div class="row" class="col-md-12" style="margin-bottom: 5px;background-color: #ffffff">
        <div id="myMap" style="height: 600px">

        </div>
    </div>
    <div class="row" style="height: 400px;overflow: auto;margin-bottom: 5px">
        <div class="col-md-16" style="background-color: #ffffff;">
            <table class="table table-bordered table-hover table-striped">
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
                <tbody id="tbody1">
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div id="myCharts" style="height: 500px;background-color: #ffffff">

            </div>
        </div>
    </div>
</div>
<jsp:include page="template/footer.jsp"></jsp:include>
<script type="text/javascript" src="${pageContext.request.contextPath}/echarts/echarts.js"></script>
<script type="text/javascript">
    $(function () {
        //发送请求获取最新数据
        $.get("${pageContext.request.contextPath}/epidemicData/ajax/lastestData", {}, function (resp) {
            if (resp.code < 0) {
                alert(resp.msg);
            } else {
                fillToTable(resp.data);
                fillToChart(resp.data);
                fillToMap(resp.data);
            }
        }, "json");

        //定义给表格填充数据函数
        const fillToTable = function (epidemics) {
            const tbody1 = $("#tbody1");
            tbody1.empty();
            $.each(epidemics, function (index, epidemic) {
                let tr = $("<tr>");
                let td = $("<td>");
                //省份名称
                td.text(epidemic.provinceName);
                tr.append(td);
                //确诊人数
                td = $("<td>");
                td.html("" + epidemic.affirmedTotal + "<span class='small'>" + " (+" + epidemic.affirmed + ")" + "</span>");
                tr.append(td);
                //疑似人数
                td = $("<td>");
                td.html("" + epidemic.suspectedTotal + "<span class='small'>" + " (+" + epidemic.suspected + ")" + "</span>");
                tr.append(td);
                //隔离人数
                td = $("<td>");
                td.html("" + epidemic.isolatedTotal + "<span class='small'>" + " (+" + epidemic.isolated + ")" + "</span>");
                tr.append(td);
                //治愈人数
                td = $("<td>");
                td.html("" + epidemic.curedTotal + "<span class='small'>" + " (+" + epidemic.cured + ")" + "</span>");
                tr.append(td);
                //死亡人数
                td = $("<td>");
                td.html("" + epidemic.deadTotal + "<span class='small'>" + " (+" + epidemic.dead + ")" + "</span>");
                tr.append(td);

                //将每一行数据添加到tbody1中
                tbody1.append(tr);
            });
        };
        //初始化图表
        const myCharts = echarts.init($("#myCharts").get(0));
        const option = {
            title: {
                text: '全国疫情柱状图',
                subtext: '2020-02-28'
            },
            // 提示框
            tooltip: {
                trigger: 'axis'
            },
            grid: {
                //是否显示网格
                show: true
            },
            // 图例，单击后可隐藏对应的系列
            legend: {
                data: ['2020-02-28']
            },
            xAxis: {
                data: []
            },
            yAxis: {},
            //series值是一个数组
            series: [
                {
                    type: 'bar',
                    name: '2020-02-28',
                    data: []
                }
            ]
        };
        myCharts.setOption(option);

        //将服务器端返回的数据设置到图表上
        const fillToChart = function (epidemics) {
            const provinceNames = [];
            const affirmedTotal = [];
            $.each(epidemics, function (index, epidemic) {
                provinceNames.push(epidemic.provinceName);
                affirmedTotal.push(epidemic.affirmedTotal);
            });
            myCharts.setOption({
                xAxis: {
                    data: provinceNames
                },
                series: [
                    {
                        //和xAxis.data定义的类目对应的数值
                        data: affirmedTotal
                    }
                ]
            });
        };
        //获取地图json数据,显示中国地图
        let myMap = null;
        $.getJSON("${pageContext.request.contextPath}/echarts/china.json", {}, function (chinaJson) {
            echarts.registerMap("china", chinaJson);
            myMap = echarts.init($("#myMap").get(0));
            const option = {
                title: {
                    text: "2020-02-28 全国疫情分布图"
                },
                legend: {
                    data: ["累计确诊人数"]
                },
                tooltip: {},
                visualMap: {
                    type: 'piecewise',
                    min: 0,
                    max: 10000,
                    splitList:
                        [{
                            start: 1000,
                            end: 10000
                        }, {
                            start: 500,
                            end: 1000
                        }, {
                            start: 100,
                            end: 500
                        }, {
                            start: 0,
                            end: 100
                        }],
                    textStyle:
                        {
                            color: 'orange'
                        }
                },
                series: [
                    {
                        name: '累计确诊人数',
                        type: 'map',
                        mapType: 'china',
                        data: []
                    }
                ]
            };
            myMap.setOption(option);
        }, "json");
        //将数据填充到地图中
        function fillToMap(epidemics) {
            const data = [];
            $.each(epidemics, function (index, epidemic) {
                const obj = {};
                obj.name = epidemic.provinceName;
                obj.value = epidemic.affirmedTotal;
                data.push(obj);
            });
            setTimeout(function () {
                myMap.setOption({
                    series: [
                        {
                            name: '累计确诊人数',
                            data: data
                        }
                    ]
                });
            },50)
        }
        //延时加载地图
        function fillToMapDelay(time,epidemics) {
            setTimeout(function () {
                fillToMap(epidemics);
            },time);

        }
    });
</script>
</body>
</html>
