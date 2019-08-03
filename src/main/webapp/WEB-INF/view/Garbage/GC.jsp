<%--
  Created by IntelliJ IDEA.
  User: zhangqiming
  Date: 2019/7/5
  Time: 15:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>垃圾回收站</title>
    <jsp:include page="/commons/css.jsp"></jsp:include>
    <style>
        .bgcol {
            background-color:#9d9d9d;
        }
    </style>
</head>
<body>
<jsp:include page="/nav/nav.jsp"></jsp:include>
<div class="container-fluid">
    <div class="row">
        <div style="margin-left:-170px">
            <form class="form-horizontal" id="searchForm">
                <div class="form-group">
                    <label class="col-sm-2 control-label">产品名称</label>
                    <div class="col-sm-2">
                        <input type="text" class="form-control" id="proName" name="proName"   placeholder="输入商品名...">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">产品价格</label>
                    <div class="col-sm-2">
                        <div class="input-group">
                            <input type="text" class="form-control" aria-describedby="basic-addon1" name="minPrice" id="minPrice"
                                   placeholder="输入价格...">
                            <span class="input-group-addon" id="basic-addon1">
                                <li class="glyphicon glyphicon-usd"></li>
                            </span>
                            <input type="text" class="form-control" aria-describedby="basic-addon1" id="maxPrice" name="maxPrice" placeholder="输入价格...">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">时间查询</label>
                    <div class="col-sm-2">
                        <div class="input-group">
                            <input type="text" class="form-control" name="minDate" aria-describedby="basic-addon1" id="minDate"
                                   readonly   placeholder="点击选择时间">
                            <span class="input-group-addon">
                                <li class="glyphicon glyphicon-time"></li>
                            </span>
                            <input type="text" class="form-control" name="maxDate" aria-describedby="basic-addon1" id="maxDate"
                                   readonly    placeholder="点击选择时间">
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label">品牌</label>
                    <div class="col-sm-2">
                        <select class="form-control" id="search_selectId" >
                            <option value="-1">请选择</option>
                        </select>
                        <input type="hidden" name="gc1" id="gc1">
                        <input type="hidden" name="gc2" id="gc2">
                        <input type="hidden" name="gc3" id="gc3">
                    </div>
                </div>
                <div class="form-group" id="querySelect">
                    <label class="col-sm-2 control-label">分类</label>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">是否热销</label>
                    <div class="col-sm-6">
                        <label class="checkbox-inline">
                            <input type="radio" name="query_isHot" value="0">是
                        </label>
                        <label class="checkbox-inline">
                            <input type="radio" name="query_isHot" value="1">否
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">状态</label>
                    <div class="col-sm-6">
                        <label class="checkbox-inline">
                            <input type="radio" name="upOrDownOrDelete" value="1">正常
                        </label>
                        <label class="checkbox-inline">
                            <input type="radio" name="upOrDownOrDelete" value="2">已下架
                        </label>
                    </div>
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
    <button type="button" class="btn btn-Default" onclick="batchDelete()"><li class="glyphicon glyphicon-alert"></li>&nbsp;批量删除</button>
    <button type="button" class="btn btn-Default" onclick="restore()"><li class="glyphicon glyphicon-alert"></li>&nbsp;批量还原</button>
    <table id="gcTable" class="display" style="width:100%">
        <thead>
        <tr>
            <th>选择</th>
            <th>商品名称</th>
            <th>状态</th>
            <th>商品价格</th>
            <th>生产时间</th>
            <th>品牌</th>
            <th>分类</th>
            <th>是否热销</th>
            <th>商品图片</th>

        </tr>
        </thead>
        <tfoot>
        <tr>
            <th>选择</th>
            <th>商品名称</th>
            <th>状态</th>
            <th>商品价格</th>
            <th>生产时间</th>
            <th>品牌</th>
            <th>分类</th>
            <th>是否热销</th>
            <th>商品图片</th>

        </tr>
        </tfoot>
    </table>
</div>

<jsp:include page="/commons/script.jsp"></jsp:include>
<script>
    $(function(){
        initTable();
        classifySelect(0);
        findBrand("search_selectId");
        onclick();
    })

    var selected = [];
    function onclick() {
        $('#gcTable tbody').on('click', 'tr', function () {
            var id = $(this).find('td:eq(0) input').val();
            var index = $.inArray(id, selected);
            if (index === -1) {
                selected.push(id);
                $(this).find('td:eq(0) input').prop('checked', true);
            } else {
                selected.splice(index, 1);
                $(this).find('td:eq(0) input').prop('checked', false);
            }
            $(this).children().toggleClass('bgcol');
        })

    }
    var gcTable;
    function initTable(){
        gcTable = $("#gcTable").DataTable({
            "processing": true,
            "serverSide": true,
            "searching": false,
            "bLengthChange": false,
            "ajax": {
                "url": "<%=request.getContextPath()%>/trashRecycling",
            },
            "rowCallback": function (row, data) {
                if ($.inArray(data.id + "", selected) !== -1) {
                    $(row).find('td:eq(0) input').prop('checked', true);
                    $(row).children().toggleClass('bgcol');
                }
            },
            "columns": [
                {
                    "data": "id", render: function (data, row) {
                        var proId = data;
                        return "<input type='checkbox'  ooo='0' name='checkId' value='" + proId + "'/>"
                    }
                },
                {"data": "productName"},
                {"data": "upOrDownOrDelete",render:function(data){
                        return data==1?"正常":"已下架";
                    }},
                {"data": "productPrice"},
                {"data": "createDate"},
                {"data": "bName"},
                {"data": "typeName"},
                {"data": "ishot",render:function (data) {
                        if(data==1){
                            return "<font color='#2e8b57'>停销</font>"
                        }else if(data==0) {
                            return "<font color='red'>热销</font>"
                        }

                    }},
                {
                    "data": "imgurl", render: function (data, row) {
                        return "<img src='" + data + "'  width='45px' class='img-rounded'/>"
                    }
                },


            ],
            "language": {"url": "js/DataTables/Chinese.json"}
        })

    }
    function restore(id) {
        bootbox.confirm("请确认所选数据是否要还原!", function (result) {
            if (result) {
                var array = [];
                $("input[name='checkId']:checked").each(function () {
                    var checkId = $(this).val();
                    array.push(checkId);
                });
                $.ajax({
                    url: "restore",
                    type: "post",
                    data: {array: array},
                    success: function (data) {
                        gcTable.ajax.reload();
                    }
                })
            }
        })
    }


            function search() {
                var proName = $("#proName").val();
                var minPrice = $("#minPrice").val();
                var maxPrice = $("#maxPrice").val();
                var minDate = $("#minDate").val();
                var maxDate = $("#maxDate").val();
                var bid = $("#search_selectId").val();
                var id1 = $($("select[name='selectName']")[0]).val();
                var id2 = $($("select[name='selectName']")[1]).val();
                var id3 = $($("select[name='selectName']")[2]).val();
                var ishot = $("input[name='query_isHot']:checked").val();
                var upOrDownOrDelete = $("input[name='upOrDownOrDelete']:checked").val();
                var param = {}
                param.proName = proName;
                param.minPrice = minPrice;
                param.maxPrice = maxPrice;
                param.minDate = minDate;
                param.maxDate = maxDate;
                param.b = bid;
                param.gc1 = id1;
                param.gc2 = id2;
                param.gc3 = id3;
                param.ishot = ishot;
                param.upOrDownOrDelete = upOrDownOrDelete;
                proTable.settings()[0].ajax.data = param;
                proTable.ajax.reload();
            }

            function classifySelect(typeId, obj) {
                if(obj){
                    $(obj).parent().nextAll().remove();
                }
                //先通过ajax查出所有父级id
                $.ajax({
                    url: "<%=request.getContextPath()%>/firstType",
                    dataType: "json",
                    data: {"id": typeId},
                    success: function (data) {
                        if (data.code == 200) {
                            if (data.data.length == 0) {
                                return;
                            }
                            //拿到数据
                            var typeList = data.data;
                            //拼接下拉框的div
                            var typeStr = '<div id="query" class="col-md-2"><select name="selectName" class="form-control" onchange="classifySelect(this.value,this)" >' +
                                '<option value="-1">请选择</option>'
                            for (var i = 0; i < typeList.length; i++) {
                                typeStr += '<option value="' + typeList[i].id + '">' + typeList[i].typeName + '</option>'
                            }
                            typeStr += "</select></div>";
                            $("#querySelect").append(typeStr);
                        }
                    }
                })
            }

            function batchDelete() {
                bootbox.confirm("请确认所选数据是否要删除!", function (result) {
                    if (result) {
                        var array = [];
                        $("input[name='checkId']:checked").each(function () {
                            var checkId = $(this).val();
                            array.push(checkId);
                        });
                        $.ajax({
                            url: "<%=request.getContextPath()%>/batchDelete",
                            type: "post",
                            data: {"array": array},
                            dataType: "text",
                            success: function () {
                                search();
                            }
                        })
                    }
                });
            }
            function findBrand(methodId) {
        $.ajax({
            url: "<%=request.getContextPath()%>/findBrand",
            type: "post",
            dataType: "json",
            success: function (data) {
                if (data.code) {
                    var brandData = data.data;
                    for (var i = 0; i < brandData.length; i++) {
                        var opt = "<option value='" + brandData[i].id + "'>" + brandData[i].brandName + "</option>"
                        $("#" + methodId).append(opt);
                    }
                }

            }
        })
    }
</script>
</body>
</html>
