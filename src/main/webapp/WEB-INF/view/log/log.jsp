<%--
  Created by IntelliJ IDEA.
  User: zhangqiming
  Date: 2019/6/19
  Time: 23:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>后台日志</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/DataTables/datatables.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css">
</head>
<body>
<jsp:include page="/nav/nav.jsp"></jsp:include>
<div class="container-fluid">
    <div class="row">
        <form class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-1 control-label">用户名称</label>
                <div class="col-sm-2">
                    <input type="text" class="form-control" id="user" placeholder="输入用户名...">
                </div>

            </div>
            <div class="form-group">
                <label  class="col-sm-1 control-label">状态</label>
                <div class="col-sm-5">
                    <label class="checkbox-inline">
                        <input type="radio" name="status" value="1">成功
                    </label>
                    <label class="checkbox-inline">
                        <input type="radio" name="status" value="0">失败
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-1 control-label">时间查询</label>
                <div class="col-sm-3">
                    <div class="input-group">
                        <input type="text" class="form-control"  name="aaa" aria-describedby="basic-addon1" id="minDate" readonly>
                        <span class="input-group-addon">
                                <li class="glyphicon glyphicon-time"></li>
                            </span>
                        <input type="text" class="form-control" name="aaa" aria-describedby="basic-addon1" id="maxDate" readonly>
                    </div>
                </div>
            </div>



            <div style="margin-left:130px">


                <button type="button" class="btn btn-primary" onclick="search()"><i class="glyphicon glyphicon-search" ></i>搜索</button>
                <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-refresh"></i>重置</button>
            </div>
        </form>
    </div>
    <div class="row" >
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">后台日志</h3>
            </div>

            <table id="logTable" class="display" style="width:100%">
                <thead>
                <tr>
                    <th>用户</th>
                    <th>操作信息</th>
                    <th>时间</th>
                    <th>状态</th>
                    <th>操作内容</th>
                    <th>操作内容</th>
、
                </tr>
                </thead>
                <tfoot>
                <tr>
                    <th>操作用户</th>
                    <th>操作信息</th>
                    <th>操作时间</th>
                    <th>状态</th>
                    <th>操作内容</th>
                    <th>操作内容</th>
                </tr>
                </tfoot>
            </table>

        </div>

    </div>
</div>
<script src="<%=request.getContextPath()%>/js/jquery-3.3.1.js"></script>
<script src="<%=request.getContextPath()%>/js/DataTables/DataTables-1.10.18/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker-master/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="<%=request.getContextPath()%>/js/cookie/jquery.cookie.js"></script>
<script>
    $(function () {
        initTable();
        date();



    })
    var logTable;
    function initTable(){
        logTable = $("#logTable").DataTable({
            "processing": true,
            "serverSide": true,
            "searching": false,
            "bLengthChange": false,
            "ajax": {
                "url": "<%=request.getContextPath()%>/queryLog",
            },
            "columns": [
                {"data": "user"},
                {"data": "info"},
                {"data": "createDate"},
                {"data":"status",render:function (data,row) {
                        if(data==1){
                            return '<span><font style="color: green">成功</font></span>'
                        }else{
                            return '<span><font style="color: red">失败</font></span>'
                        }
                    }},

                {"data":"context"},
                {"data":"content"},

            ],
            "language": {"url": "js/DataTables/Chinese.json"}
        })

    }

    function date() {
        $('#minDate').datetimepicker({
            minView: "month",
            format: "yyyy-mm-dd",
            language: "zh-CN"

        });
        $('#maxDate').datetimepicker({
            minView: "month",
            format: 'yyyy-mm-dd',
            language: 'zh-CN'
        });

    }

    function search() {
        var user = $("#user").val();
        var minDate = $("#minDate").val();
        var maxDate = $("#maxDate").val();
        var status=$("input[name='status']:checked").val();
        var content=$("#content").val();
        var param = {}
        param.user = user;
        param.minDate = minDate;
        param.maxDate = maxDate;
        param.content=content;
        param.status=status;
        logTable.settings()[0].ajax.data = param;
        logTable.ajax.reload();
    }




</script>
</body>
</html>
