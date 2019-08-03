<%--
  Created by IntelliJ IDEA.
  User: zhangqiming
  Date: 2019/6/11
  Time: 18:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>商品展示页面</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/DataTables/datatables.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css"
          type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/fileinput/css/fileinput.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/yanzheng/css/bootstrapValidator.min.css">
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
    <div class="panel panel-Default">
        <!-- Default panel contents -->
        <div class="panel-heading">
            <span style="margin-right:280px"><b>商品信息展示</b></span>
                <button type="button" class="btn btn-Default" onclick="toAdd()"><li class="glyphicon glyphicon-edit"></li>&nbsp;添加商品</button>
                <button type="button" class="btn btn-Default" onclick="ExportExcel()"><li class="glyphicon glyphicon-folder-open"></li>&nbsp;导出Excel</button>
                <button type="button" class="btn btn-Default" onclick="ImportExcel()"><li class="glyphicon glyphicon-circle-arrow-up"></li>&nbsp;导入Excel</button>
                <button type="button" class="btn btn-Default" onclick="exportPDF()"><li class="glyphicon glyphicon-send"></li>&nbsp;导出PDF</button>
                <button type="button" class="btn btn-Default" onclick="exportWord()"><li class="glyphicon glyphicon-globe"></li>&nbsp;导出Word</button>
                <button type="button" class="btn btn-Default" onclick="batchDelete()"><li class="glyphicon glyphicon-alert"></li>&nbsp;批量删除</button>
        </div>
        <!-- Table -->
        <table id="proTable" class="display" style="width:100%">
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
                <th>操作</th>
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
                <th>操作</th>
            </tr>
            </tfoot>
        </table>
    </div>

</div>

<div>
</div>
<!--添加Div开始-->
<div id="addForm" style="display: none">
    <form class="form-horizontal" id="add_Form">
        <div class="form-group">
            <label class="col-sm-2 control-label">产品名称</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="add_proName" name="proName" placeholder="请输入商品名称..">
            </div>
        </div>
        <div class="form-group" id="selectAdd">
            <label class="col-sm-2 control-label">分类</label>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">品牌</label>
            <div class="col-sm-6">
                <select class="form-control" id="selectId">
                    <option value="-1">请选择</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">商品价格</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" name="price" id="add_price" placeholder="请输入商品价格..">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">出厂日期</label>
            <div class="col-sm-6">
                <input type="text" readonly class="form-control" id="add_createDate" placeholder="点击选择商品日期..">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">主图:</label>
            <div class="col-md-6" >
                <input type="file" class="form-control" name="photo" id="photo">
                <input type="text" class="form-control" id="imgurl">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">子图:</label>
            <div class="col-md-6">
                <input type="file" class="form-control" name="file" id="file" multiple >
                <input type="hidden" class="form-control" id="imgpath">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">是否热销</label>
            <div class="col-sm-6">
                <label class="checkbox-inline">
                    <input type="radio" name="add_isHot" value="0">是
                </label>
                <label class="checkbox-inline">
                    <input type="radio" name="add_isHot" value="1">否
                </label>
            </div>
        </div>
    </form>
</div>
<!--添加Div结束-->


<!--修改Div开始-->
<div id="updateForm" style="display: none">
    <form class="form-horizontal">
        <input type="hidden" id="proId">
        <div class="form-group">
            <label class="col-sm-2 control-label">产品名称</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="update_proName">
            </div>
        </div>

        <div class="form-group" id="updateDivType">
            <label class="col-sm-2 control-label">分类</label>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">品牌</label>
            <div class="col-sm-6">
                <select class="form-control" id="update_selectId">
                    <option value="-1">==========请选择===========</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">商品价格</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="update_price">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">出厂日期</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="update_createDate">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">主图:</label>
            <div class="col-md-6" >
                <input type="file" class="form-control" name="photo" id="update_photo">
                <input type="text" class="form-control" id="update_imgurl">
                <input type="text" class="form-control" id="update_imgurlt">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">是否热销</label>
            <div class="col-sm-6">
                <label class="checkbox-inline">
                    <input type="radio" name="update_isHot" value="0">是
                </label>
                <label class="checkbox-inline">
                    <input type="radio" name="update_isHot" value="1">否
                </label>
            </div>
        </div>
    </form>
</div>
<!--修改Div结束-->


<!--导入excelDiv开始-->
<div id="ExcelForm" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">导入Excel</label>
            <div class="col-sm-6">
                <input type="file" class="form-control" id="excel" name="excel">
                <input type="hidden" class="form-control" id="excelurl" name="excelurl">
            </div>
        </div>
    </form>

</div>
<!--导入excelDiv结束-->
<script src="<%=request.getContextPath()%>/js/jquery-3.3.1.js"></script>
<script src="<%=request.getContextPath()%>/js/DataTables/DataTables-1.10.18/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker-master/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/js/box/bootbox.min.js"></script>
<script src="<%=request.getContextPath()%>/js/box/bootbox.locales.min.js"></script>
<script src="<%=request.getContextPath()%>/js/fileinput/js/fileinput.min.js"></script>
<script src="<%=request.getContextPath()%>/js/fileinput/js/locales/zh.js"></script>
<script src="<%=request.getContextPath()%>/js/yanzheng/js/bootstrapValidator.min.js"></script>

<script type="text/javascript">
    var proTable;
    var addProbuctDiv;
    var updateProductDiv;
    var selected = [];
    var ExcelForm;
    var updateConfirm;
    var addConfirm;
    $(function () {
        //初始化分页数据
        initTable();
        onclick();
        //初始化下拉框
        findBrand("search_selectId");
        findBrand("selectId");
        findBrand("update_selectId");
        //初始化添加弹框的时间插件
        dateFormat();
        //备份添加页面
        addProbuctDiv = $("#addForm").html();
        updateProductDiv = $("#updateForm").html();
        ExcelForm = $("#ExcelForm").html();
        classifySelect(0);
        //添加表单验证
        authentication();
        query_authentication();
    })


    function exportWord(){
        var gc1= $($("select[name=selectName]")[0]).val();
        var gc2=$($("select[name=selectName]")[1]).val();
        var gc3=$($("select[name=selectName]")[2]).val();
        $("#gc1").val(gc1);
        $("#gc2").val(gc2);
        $("#gc3").val(gc3);
        var v_word = document.getElementById("searchForm");
        //设置action属性
        v_word.action="<%=request.getContextPath()%>/word";
        v_word.method="post";
        v_word.submit()
    }

    //导出pdf
    function exportPDF(){
        var gc1= $($("select[name=selectName]")[0]).val();
        var gc2=$($("select[name=selectName]")[1]).val();
        var gc3=$($("select[name=selectName]")[2]).val();
        $("#gc1").val(gc1);
        $("#gc2").val(gc2);
        $("#gc3").val(gc3);
        var v_pdfById = document.getElementById("searchForm");
        //设置action属性
        v_pdfById.action="<%=request.getContextPath()%>/exportPDF";
        v_pdfById.method="post";
        v_pdfById.submit()
    }
    //修改的编辑事件
    var flag = 0;
    function edit(typeName){
        if(flag==0){
            $("#edit_Text").html("取消编辑");
            classify("updateDivType",0);
            $("#updateLabel").remove();
            flag=1;
        }
        else {
            $("#updateDivType div").remove();
            $("#edit_Text").html("编辑");
            $("#updateDivType",updateConfirm).append("<label id='updateLabel' class=\"col-sm-5 control-label\">"+typeName+"</label>")
            flag=0;
        }

    }
    //三及联动-查询
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
    //三及联动-修改  添加
    function classify(selectAppend,typeId, obj) {
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
                    var typeStr = '<div id="updateZDiv" class="col-md-3"><select name="selectName" class="form-control" onchange="classify(\''+selectAppend+'\',this.value,this)" >' +
                        '<option value="-1">请选择</option>'
                    for (var i = 0; i < typeList.length; i++) {
                        typeStr += '<option value="' + typeList[i].id + '">' + typeList[i].typeName + '</option>'
                    }
                    typeStr += "</select></div>";
                    if(selectAppend=="selectAdd"){
                        $("#"+selectAppend,addConfirm).append(typeStr);
                    }else if(selectAppend=="updateDivType"){
                        $("#"+selectAppend,updateConfirm).append(typeStr);
                    }else {
                        $("#"+selectAppend).append(typeStr);
                    }

                }
            }
        })
    }

    //导入Excel
    file
    function ImportExcel() {
        var s = {
            language: "zh",
            uploadUrl: "<%=request.getContextPath()%>/uploadFile",
            showUpload: false,
            showRemove: false,
            showUpload: true, //是否显示上传按钮,跟随文本框的那个
            showRemove: false, //显示移除按钮,跟随文本框的那个
            showCaption:false,//是否显示标题,就是那个文本框
            dropZoneEnabled: false,
            allowedFileExtensions: ['xls', 'xlsx']
        };
        $("#excel").fileinput(s).on("fileuploaded", function (a, b, c, d) {
            var data = b.response;
            if (data.code == 200) {
                console.log(data.data)
                $("#excelurl", file).val(data.data);
            }
        })
         file = bootbox.confirm({
             title: "导入Excel",
             message: $("#ExcelForm form"),
             buttons: {
                 cancel: {
                     label: '<i class="fa fa-times"></i> 取消'
                 },
                 confirm: {
                     label: '<i class="fa fa-check"></i> 确定'
                 }
             },
             callback: function (result) {
                 if (result) {
                     $.ajax({
                         url: "<%=request.getContextPath() %>/leadExcel",
                         type: "post",
                         data: {
                             path: $("#excelurl", file).val(),
                         },
                         dataType: "json",
                         success: function (result) {
                             if (result.code == 200) {
                                 search();
                             }
                         }
                     });
                 }
                 $("#ExcelForm").html(ExcelForm);
             }

         })
    }

                //动态导出Excel
                function ExportExcel() {
                    var v_Excel = document.getElementById("searchForm");
                    //设置action属性
                    v_Excel.action = "<%=request.getContextPath() %>/exportExcel";
                    v_Excel.method = "post";
                    v_Excel.submit()
                }

                //初始化分页表格
                function initTable() {
                    proTable = $("#proTable").DataTable({
                        "processing": true,
                        "serverSide": true,
                        "searching": false,
                        "bLengthChange": false,
                        "ajax": {
                            "url": "<%=request.getContextPath()%>/queryProduct",
                            "async": false,
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

                            {
                                render: function (data, type, row, meta) {
                                    var proId = row.id;
                                    var upIds = row.upOrDownOrDelete;
                                    var upOrDownStr="";
                                    var className="";
                                    var upId="";
                                    if (upIds==1){
                                        upOrDownStr="下架";
                                        className="btn btn-default";
                                        upId=2;
                                    }else {
                                        upOrDownStr="上架"
                                        className="btn btn-primary";
                                        upId=1;

                                    }
                                    return '<div class="btn-group" role="group">' +
                                        '<button type="button" class="btn btn-primary" onclick="updatePro(\'' + proId + '\')"><i class="glyphicon glyphicon-pencil"></i>修改</button>' +
                                        '<button type="button" class="btn btn-default" onclick="deletePro(\'' + proId + '\')"><i class="glyphicon glyphicon-trash"></i>删除</button>' +
                                        '<button type="button" class="'+className+'" onclick="upOrDown(\'' + proId + '\',\''+upId+'\')"><i class="glyphicon glyphicon-sort"></i>'+upOrDownStr+'</button></div>';
                                }               
                            },
                        ],  
                        "language": {"url": "js/DataTables/Chinese.json"}
                    })

                }

                function upOrDown(id,upId){
                    window.event.stopPropagation();
                    $.ajax({
                        url:"<%=request.getContextPath()%>/upOrDown",
                        type:"post",
                        data:{id:id,
                              upId:upId,
                        },
                        success:function (result) {
                            if (result.code==200){
                                search();
                            }
                        }
                    })
                }

                //搜索
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
                    param.ishot=ishot;
                    param.upOrDownOrDelete=upOrDownOrDelete;
                    proTable.settings()[0].ajax.data = param;
                    proTable.ajax.reload();
                }

                //删除产品
                function deletePro(id) {
                    window.event.stopPropagation();
                    bootbox.confirm("确定要删除该条商品信息吗!", function (result) {
                        if (result) {
                            $.ajax({
                                url: "<%=request.getContextPath()%>/deletePro",
                                type: "post",
                                data: {id: id},
                                dataType: "text",
                                success: function (data) {
                                    search();
                                }
                            })
                        }
                    });
                }

                //修改商品
                function updatePro(id) {
                    window.event.stopPropagation();
                    $.ajax({
                        url: "<%=request.getContextPath()%>/getById",
                        type: "post",
                        data: {id: id},
                        async: true,
                        dataType: "json",
                        success: function (data) {
                            var proData = data.data;
                            $("#proId").val(proData.id);
                            $("#update_proName").val(proData.proName);
                            $("#update_selectId").val(proData.b);
                            $("#update_price").val(proData.price);
                            $("#update_createDate").val(proData.createDate);
                            $("#update_imgurl").val(proData.imgurl);
                            $("input[name='update_isHot']").each(function () {
                                if(this.value==proData.ishot){
                                    this.checked=true;
                                }
                            })
                            fileInputUpdate();
                            updateConfirm = bootbox.confirm({
                                title: "商品修改页面",
                                message: $("#updateForm form"),
                                buttons: {
                                    cancel: {
                                        label: '<i class="fa fa-times"></i> 取消'
                                    },
                                    confirm: {
                                        label: '<i class="fa fa-check"></i> 确认'
                                    }
                                },
                                callback: function (result) {
                                    if (result) {
                                        var id = $("#proId", updateConfirm).val();
                                        var proName = $("#update_proName", updateConfirm).val();
                                        var price = $("#update_price", updateConfirm).val();
                                        var createDate = $("#update_createDate", updateConfirm).val();
                                        var bid = $("#update_selectId", updateConfirm).val();
                                        var gc1;
                                        var gc2;
                                        var gc3;
                                        if (flag == 0) {
                                            gc1 = proData.gc1;
                                            gc2 = proData.gc2;
                                            gc3 = proData.gc3;
                                        } else {
                                            gc1 = $("select[name='selectName']", updateConfirm)[0].value;
                                            gc2 = $("select[name='selectName']", updateConfirm)[1].value;
                                            gc3 = $("select[name='selectName']", updateConfirm)[2].value;
                                        }
                                        var isHot = $("input[name='update_isHot']:checked",updateConfirm).val();
                                        var update_imgurlt = $("#update_imgurlt",updateConfirm).val();
                                        var update_imgurl = $("#update_imgurl",updateConfirm).val();
                                        var proParam = {};
                                        proParam.id = id;
                                        proParam.proName = proName;
                                        proParam.price = price;
                                        proParam.createDate = createDate;
                                        proParam["brand.id"] = bid;
                                        proParam.gc1 = gc1;
                                        proParam.gc2 = gc2;
                                        proParam.gc3 = gc3;
                                        proParam.ishot = isHot;
                                        proParam.newImgageUrl=update_imgurlt;
                                        proParam.imgurl=update_imgurl;
                                        $.ajax({
                                            url: "updatePro",
                                            type: "post",
                                            data: proParam,
                                            dataType: "json",
                                            success: function (data) {
                                                if (data.code = "200") {
                                                    proTable.draw(false);
                                                }
                                            }
                                        })
                                    }
                                }
                            });
                            $("#updateDivType", updateConfirm).append("<label id='updateLabel' class=\"col-sm-5 control-label\">" + proData.typeName + "</label>");
                            $("#updateDivType", updateConfirm).append(" <button type=\"button\" class=\"btn btn-primary\" onclick='edit(\"" + proData.typeName + "\");'><span class='glyphicon glyphicon-edit'></span><span id='edit_Text'>编辑</span></button>")
                            dateFormatUpdate();
                            $("#updateForm").html(updateProductDiv);
                            flag = 0;
                            findBrand("update_selectId");
                        }
                    })
                }
                //添加商品
                function toAdd() {
                    var addHtml = $("#addForm form");
                    fileInput2();
                    fileInput();
                    addConfirm = bootbox.confirm({
                        title: "<span class='glyphicon glyphicon-globe'></span>&nbsp;添加商品",
                        message: addHtml,
                        buttons: {
                            confirm: {
                                label: '<i class="fa fa-check"></i> 确认'
                            },
                            cancel: {
                                label: '<i class="fa fa-times"></i>取消'
                            }
                        },
                        callback: function (result) {
                            if (result) {
                                var add_proName = $("#add_proName", addConfirm).val();
                                var add_price = $("#add_price", addConfirm).val();
                                var add_createDate = $("#add_createDate", addConfirm).val();
                                var selectId = $("#selectId", addConfirm).val();
                                var imgurl = $("#imgurl", addConfirm).val();
                                var gc1 = $("select[name='selectName']", addConfirm)[0].value;
                                var gc2 = $("select[name='selectName']", addConfirm)[1].value;
                                var gc3 = $("select[name='selectName']", addConfirm)[2].value;
                                var imgpath = $("#imgpath", addConfirm).val();
                                var isHot = $("input[name='add_isHot']:checked",addConfirm).val();
                                var params = {};
                                params.proName = add_proName;
                                params.price = add_price;
                                params.createDate = add_createDate;
                                params["brand.id"] = selectId;
                                params.imgurl = imgurl;
                                params.gc1 = gc1;
                                params.gc2 = gc2;
                                params.gc3 = gc3;
                                params.sonimg = imgpath;
                                params.ishot=isHot;
                                $.ajax({
                                    url: "<%=request.getContextPath()%>/addProduct",
                                    type: "post",
                                    data: params,
                                    dataType: "json",
                                    success: function (data) {
                                        if (data.code == "200") {
                                            proTable.ajax.reload();
                                        }
                                    },
                                    error: function () {

                                    }
                                })
                            }
                        }
                    });
                    authentication();
                    dateFormatAdd();
                    $("#addForm").html(addProbuctDiv);
                    classify("selectAdd", 0);
                    findBrand("selectId");
                }

                //给tr赋点击事件
                function onclick() {
                    $('#proTable tbody').on('click', 'tr', function () {
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

                function dateFormat() {
                    $('#minDate').datetimepicker({
                        autoclose:true,
                        minView: "month",
                        format: "yyyy-mm-dd",
                        language: "zh-CN"

                    });
                    $('#maxDate').datetimepicker({
                        autoclose:true,
                        minView: "month",
                        format: 'yyyy-mm-dd',
                        language: 'zh-CN'
                    });

                }

                function dateFormatAdd() {
                    $('#add_createDate').datetimepicker({
                        autoclose:true,
                        minView: "month",
                        format: 'yyyy-mm-dd',
                        language: 'zh-CN'
                    });


                }

                function dateFormatUpdate() {
                    $('#update_createDate').datetimepicker({
                        autoclose:true,
                        minView: "month",
                        format: 'yyyy-mm-dd',
                        language: 'zh-CN'
                    });
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

                //主图上传
                function fileInput() {
                    $("#photo").fileinput({
                        language: 'zh',
                        allowedPreviewMimeTypes: ['jpg', 'png', 'gif'],
                        showPreview: true,
                        showUpload: true, //是否显示上传按钮,跟随文本框的那个
                        showRemove: false, //显示移除按钮,跟随文本框的那个
                        showCaption: false,//是否显示标题,就是那个文本框
                        dropZoneEnabled: false,
                        uploadUrl: "<%=request.getContextPath()%>/uploadInput",
                    }).on("fileuploaded", function (event, data, previewId, index) {
                        if (data != null && data.response.code == 200) {
                            $("#imgurl",addConfirm).val(data.response.data);
                        }

                    })
                }

    function fileInputUpdate() {
        var update_imgurl = $("#update_imgurl").val();
        var previewArr = [];
        previewArr.push(update_imgurl);
        $("#update_photo").fileinput({
            language: 'zh',
            initialPreview: previewArr,
            initialPreviewAsData: true,
            allowedPreviewMimeTypes: ['jpg', 'png', 'gif'],
            showPreview: true,
            showUpload: true, //是否显示上传按钮,跟随文本框的那个
            showRemove: false, //显示移除按钮,跟随文本框的那个
            showCaption: false,//是否显示标题,就是那个文本框
            dropZoneEnabled: false,
            uploadUrl: "<%=request.getContextPath()%>/uploadInput",
        }).on("fileuploaded", function (event, data, previewId, index) {
            if (data != null && data.response.code == 200) {
                $("#update_imgurlt",updateConfirm).val(data.response.data);
            }

        })
    }

                //子图上传
                var arr = [];

                function fileInput2() {
                    var imgpath = $("#imgpath").val();
                    var previewArr = [];
                    previewArr.push(imgpath);
                    $("#file").fileinput({
                        language: 'zh',
                        allowedPreviewMimeTypes: ['jpg', 'png', 'gif'],
                        initialPreview: previewArr,
                        initialPreviewAsData: true,
                        uploadAsync: true,
                        maxFileCount: 5,
                        browseOnZoneClick: true,
                        showUpload: true, //是否显示上传按钮,跟随文本框的那个
                        showRemove: false, //显示移除按钮,跟随文本框的那个
                        showCaption: false,//是否显示标题,就是那个文本框
                        dropZoneEnabled: false,
                        msgFoldersNotAllowed: true,
                        uploadUrl: "<%=request.getContextPath()%>/uploadInputZ",
                    }).on("fileuploaded", function (event, data, previewId, index) {
                        if (data != null && data.response.code == 200) {
                            arr.push(data.response.data);
                        }
                        $("#imgpath", addConfirm).val(arr);
                    })
                }
                function authentication(){
                    $("#add_Form").bootstrapValidator({
                        feedbackIcons: {
                            valid: 'glyphicon glyphicon-ok',
                            invalid: 'glyphicon glyphicon-remove',
                            validating: 'glyphicon glyphicon-refresh'
                        },
                        fields: {

                            price: {
                                validators: {
                                    notEmpty: {
                                        message: '价格不能为空'
                                    },
                                    regexp:{
                                        regexp:/(^[1-9]\d*(\.\d{1,2})?$)|(^0(\.\d{1,2})?$)/,
                                        message:'请输入正确的产品价格:整数或者保留两位小数',
                                    }
                                },

                            }
                        }
                    })
                }
                function query_authentication(){
                    $("#searchForm").bootstrapValidator({
                        feedbackIcons: {
                            valid: 'glyphicon glyphicon-ok',
                            invalid: 'glyphicon glyphicon-remove',
                            validating: 'glyphicon glyphicon-refresh'
                        },
                        fields: {

                            minPrice: {
                                validators: {
                                    notEmpty: {
                                        message: '价格不能为空'
                                    },
                                    regexp:{
                                        regexp:/(^[1-9]\d*(\.\d{1,2})?$)|(^0(\.\d{1,2})?$)/,
                                        message:'请输入正确的产品价格:整数或者保留两位小数',
                                    }
                                },

                            },
                            maxPrice: {
                                validators: {
                                    notEmpty: {
                                        message: '价格不能为空'
                                    },
                                    regexp:{
                                        regexp:/(^[1-9]\d*(\.\d{1,2})?$)|(^0(\.\d{1,2})?$)/,
                                        message:'请输入正确的产品价格:整数或者保留两位小数',
                                    }
                                },

                            }
                        }
                    })
                }
            function updateishot(id){

                        $.ajax({
                            url:"updateIsHot",
                            data:{id:id},
                            success:function(data){
                                if(data.code==200){
                                    search();
                                }
                            }
                        })

            }
            function updateishot2(id){
                $.ajax({
                    url:"updateIsHot2",
                    data:{id:id},
                    success:function(data){
                        if(data.code==200){
                            search();
                        }
                    }
                })
            }
</script>


</body>
</html>
