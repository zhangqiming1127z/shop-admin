<%--
  Created by IntelliJ IDEA.
  User: zhangqiming
  Date: 2019/7/10
  Time: 23:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>会员管理</title>
    <jsp:include page="/commons/css.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/nav/nav.jsp"></jsp:include>
<div class="container-fluid">
    <div class="row">
        <div style="margin-left:-170px">
            <form class="form-horizontal" id="searchForm">
                <div class="form-group">
                    <label class="col-sm-2 control-label">会员名称</label>
                    <div class="col-sm-2">
                        <input type="text" class="form-control" id="mName"    placeholder="查询会员名...">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">生日查询</label>
                    <div class="col-sm-2">
                        <div class="input-group">
                            <input type="text" class="form-control" aria-describedby="basic-addon1" id="minDate"
                                   readonly   placeholder="点击选择时间">
                            <span class="input-group-addon">
                                <li class="glyphicon glyphicon-time"></li>
                            </span>
                            <input type="text" class="form-control" aria-describedby="basic-addon1" id="maxDate"
                                   readonly    placeholder="点击选择时间">
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label  class="col-sm-2 control-label">激活/禁用</label>
                    <div class="col-sm-6">
                        <label class="checkbox-inline">
                            <input type="radio" name="isforbidden" value="0">激活
                        </label>
                        <label class="checkbox-inline">
                            <input type="radio" name="isforbidden" value="1">禁用
                        </label>
                    </div>
                </div>
                <div class="form-group" id="select">
                    <label  class="col-sm-2 control-label">地区</label>
                </div>
                <div style="margin-left:300px">
                    <button type="button" class="btn btn-primary" onclick="search()" style="width:120px"><i
                            class="glyphicon glyphicon-search"></i>搜索
                    </button>
                    <button type="reset" class="btn btn-default"  style="width:120px"><i class="glyphicon glyphicon-refresh"></i>重置</button>
                </div>
            </form>
        </div>
    </div>
    <div class="panel panel-Default">
        <!-- Default panel contents -->
        <div class="panel-heading">
            <span style="margin-right:280px"><b>会员信息</b></span>
        </div>
        <!-- Table -->
        <table id="memberTalbe" class="display" style="width:100%">
            <thead>
            <tr>
                <th>选择</th>
                <th>会员名称</th>
                <th>真实姓名</th>
                <th>生日</th>
                <th>手机号</th>
                <th>邮箱</th>
                <th>地区</th>
                <th>禁用/激活</th>
            </tr>
            </thead>
            <tfoot>
            <tr>
                <th>选择</th>
                <th>会员名称</th>
                <th>真实姓名</th>
                <th>生日</th>
                <th>手机号</th>
                <th>邮箱</th>
                <th>地区</th>
                <th>禁用/激活</th>
            </tr>
            </tfoot>
        </table>
    </div>

</div>

<div>
</div>
<jsp:include page="/commons/script.jsp"></jsp:include>

<script>

    $(function () {
        initTable();
        findAreaById(0);
    })
    var memberTalbe;
    function initTable() {
        memberTalbe = $("#memberTalbe").DataTable({
            "processing": true,
            "serverSide": true,
            "searching": false,
            "bLengthChange": false,
            "ajax": {
                "url":"<%=request.getContextPath()%>/findMember",
            },
            "columns": [
                {
                    "data": "id", render: function (data, row) {
                        return "<input type='checkbox'    value='" + data + "'/>"
                    }
                },
                {"data": "userName"},
                {"data": "realName"},
                {"data": "birthday"},
                {"data": "phoneNumber"},
                {"data": "mail"},
                {"data": "aname"},
                {"data":"isforbidden",render:function (data,type,row) {
                        var id = row.id;
                        return data==1?"<button type=\"button\" class=\"btn btn-primary\" onclick=\"isforbidden('"+data+"','"+id+"');\">禁用</button>":"<button type=\"button\" class=\"btn btn-default\" onclick=\"isforbidden('"+data+"','"+id+"');\">激活</button>"

                    }},
            ],
            "language": {"url": "js/DataTables/Chinese.json"}
        })

    }
    function search() {
        var mName = $("#mName").val();
        var minDate = $("#minDate").val();
        var maxDate = $("#maxDate").val();
        var dq1 = $("select[name='selectId']")[0].value;
        var dq2 = $("select[name='selectId']")[1].value;
        var dq3 = $("select[name='selectId']")[2].value;
        var isforbidden = $("inpit[name='isforbidden']:checked").val();
        var param = {}
        param.userName = mName;
        param.minbirthday = minDate;
        param.maxbirthday = maxDate;
        param.dq1 = dq1;
        param.dq2 = dq2;
        param.dq3 = dq3;
        param.isforbidden=isforbidden;
        memberTalbe.settings()[0].ajax.data = param;
        memberTalbe.ajax.reload();
    }

    function isforbidden(isforbiddenId,id){
        var fid = isforbiddenId==1?"0":"1";
        $.ajax({
            url:"updateisforbidden",
            data:{"id":id,"fid":fid},
            success:function (data) {
                if (data.code==200){
                    memberTalbe.ajax.reload();
                }
            }
        })
    }


    function findAreaById(id,obj){
        if(obj){
            $(obj).parent().nextAll().remove();
        }
        $.ajax({
            url:"findAreaById",
            type:"post",
            data:{"id":id},
            success:function (data) {
                if (data.code==200){
                    console.log(data.data)
                    var areaList= data.data;
                    if (areaList.length==0) {
                        return;
                    }
                    var str= "<div class='col-md-2'><select name='selectId' class='form-control' onchange='findAreaById(this.value,this)'><option value='-1'>请选择</option>";
                    for(var i=0;i<areaList.length;i++){
                        str+="<option value='"+areaList[i].id+"'>"+areaList[i].name+"</option>";
                    }
                    str+=" </select></div>";
                    $("#select").append(str);
                }
            }

        })
    }
</script>
</body>
</html>
