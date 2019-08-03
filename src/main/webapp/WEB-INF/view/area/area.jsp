<%--
  Created by IntelliJ IDEA.
  User: zhangqiming
  Date: 2019/6/25
  Time: 14:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>地区管理</title>
    <link href="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="<%=request.getContextPath()%>/js/zts/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="/nav/nav.jsp"></jsp:include>
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading">
            <span>地区管理</span>
        </div>

        <div class="panel-body">
            <ul id="areaZtree" class="ztree"></ul>
        </div>
        <div class="panel-footer">
            <button type="button" class="btn btn-default" onclick="addZtree()">添加地区</button>
            <button type="button" class="btn btn-default" onclick="updateZtree()">修改地区</button>
            <button type="button" class="btn btn-default" onclick="deleteZtree()">删除</button></div>
    </div>
</div>
<div id="updateDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">选中地区</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="up_region" readonly>
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">地区名</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="up_netherlands" placeholder="输入要修改的地区名...">
            </div>
        </div>
    </form>

</div>
<div id="addDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">选中地区</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="region" readonly>
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">地区名</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="netherlands" placeholder="输入要修改的地区名...">
            </div>
        </div>
    </form>

</div>
<script src="<%=request.getContextPath()%>/js/jquery-3.3.1.min.js"></script>
<script src="<%=request.getContextPath()%>/js/zts/js/jquery.ztree.core.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/js/zts/js/jquery.ztree.excheck.min.js"></script>
<script src="<%=request.getContextPath()%>/js/box/bootbox.min.js"></script>
<script src="<%=request.getContextPath()%>/js/box/bootbox.locales.min.js"></script>
<script>
    var addDIV;
    $(function () {
        initZtree();
       addDIV= $("#addDiv").html();
    })
    var setting={
        data: {
            simpleData: {
                enable: true, // 简单数据模式
                pIdKey: "pId",
                idKey: "id",
            }
        }
    }
         //初始化ztree
         var areaZtree;
         function initZtree(){
         $.ajax({
            url:"<%=request.getContextPath()%>/queryArea",
            type:"post",
            dataType:"json",
            success:function (data) {
                var area=data.data;
                areaZtree=$.fn.zTree.init($("#areaZtree"),setting,area);
            }
        })
    }


    var ztreebox;
    function addZtree(){
        var treeObj = $.fn.zTree.getZTreeObj("areaZtree");
        var areaZtree = treeObj.getSelectedNodes()[0];
        $("#region").val(areaZtree.name);
        ztreebox =bootbox.confirm({
            title: "管理商品类型",
            message:$("#addDiv form"),
            buttons: {
                cancel: {
                    label: '<i class="fa fa-times"></i> 取消'
                },
                confirm: {
                    label: '<i class="fa fa-check"></i> 确认'
                }
            },
            callback: function (result) {
                if(result){
                    var areaName=$("#netherlands",ztreebox).val();

                    var param={};
                    param.name=areaName;
                    param.id=areaZtree.id;
                    $.ajax({
                        url:"<%=request.getContextPath()%>/addArea",
                        type:"post",
                        data:param,
                        success:function (data) {
                            if (data.code==200){
                                var treeObj = $.fn.zTree.getZTreeObj("areaZtree");
                                treeObj.addNodes(areaZtree,data.data);
                            }
                        }
                    })
                }
            }
        });
        $("#addDiv").html(addDIV);
    }



         function deleteZtree(){
        var treeObj = $.fn.zTree.getZTreeObj("areaZtree");
        var typeId = treeObj.getSelectedNodes()[0].id;
        $.ajax({
            url:"<%=request.getContextPath()%>/deleteArea",
            type:"post",
            data:{id:typeId},
            success:function (data) {
                if(data.code==200){
                    var treeObj = $.fn.zTree.getZTreeObj("areaZtree");
                    var nodes = treeObj.getSelectedNodes();
                    for (var i=0, l=nodes.length; i < l; i++) {
                        treeObj.removeNode(nodes[i]);
                    }
                }
            }
        })
    }

    function updateZtree(){
        var treeObj = $.fn.zTree.getZTreeObj("areaZtree");
        var typeId = treeObj.getSelectedNodes()[0].id;
        var Name = treeObj.getSelectedNodes()[0].name;
        $("#up_region").val(Name);
        var ztreebox2=bootbox.confirm({
            title: "管理商品地区-修改",
            message:$("#updateDiv form"),
            buttons: {
                cancel: {
                    label: '<i class="fa fa-times"></i> 取消'
                },
                confirm: {
                    label: '<i class="fa fa-check"></i> 确认'
                }
            },
            callback: function (result) {
                if(result){
                    var areaName=$("#up_netherlands",ztreebox2).val();
                    var param={};
                    param.name=areaName;
                    param.id=typeId;
                    $.ajax({
                        url:"<%=request.getContextPath()%>/updateArea",
                        type:"post",
                        data:param,
                        success:function (data) {
                            if (data.code==200){
                                var treeObj = $.fn.zTree.getZTreeObj("areaZtree");
                                var nodes = treeObj.getSelectedNodes();
                                if(nodes.length>0){
                                    nodes[0].name=areaName;
                                    treeObj.updateNode(nodes[0]);
                                }
                            }
                        }
                    })
                }
            }
        });
        $("#updateDiv").html(updateDiv);
    }


</script>
</body>
</html>
