<%--
  Created by IntelliJ IDEA.
  User: zhangqiming
  Date: 2019/6/20
  Time: 21:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="<%=request.getContextPath()%>/js/zts/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="/nav/nav.jsp"></jsp:include>
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading">
                <span>分类管理</span>
        </div>

        <div class="panel-body">
            <ul id="proZtree" class="ztree"></ul>
        </div>
        <div class="panel-footer">
            <button type="button" class="btn btn-default" onclick="addZtree()">添加类型</button>
            <button type="button" class="btn btn-default" onclick="updateZtree()">修改类型</button>
            <button type="button" class="btn btn-default" onclick="deleteZtree()">删除</button></div>
    </div>
</div>

<div id="addDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">添加在</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="Fname" readonly>
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">类型</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="Zname" placeholder="输入要添加的类型...">
            </div>
        </div>
    </form>

</div>
<div id="updateDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">选中名称</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="Xname" readonly>
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">类型</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="Lname" placeholder="输入要修改的类型...">
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
            var addDiv;
            var updateDiv;
            $(function () {
                //初始化树
                productClass();
                addDiv= $("#addDiv").html();
                updateDiv= $("#updateDiv").html();
            })
        //商品分类ztree
        var setting={
            data: {
                simpleData: {
                    enable: true, // 简单数据模式
                    pIdKey: "pId",
                    idKey: "id",
                }
            }
        }
            var proClassZtree;
         function productClass(){
             $.ajax({
                 url:"<%=request.getContextPath()%>/queryProClass",
                 type:"post",
                 dataType:"json",
                 success:function (data) {
                     var proType=data.data;
                     proClassZtree=$.fn.zTree.init($("#proZtree"),setting,proType);
                 }
             })
         }
         //添加ztree
         function addZtree(){
             var treeObj = $.fn.zTree.getZTreeObj("proZtree");
             var typeId = treeObj.getSelectedNodes()[0];
             $("#Fname").val(typeId.name);
             var ztreebox=bootbox.confirm({
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
                        var tName=$("#Zname",ztreebox).val();
                        var param={};
                        param.typeName=tName;
                        param.id=typeId.id;
                        $.ajax({
                            url:"<%=request.getContextPath()%>/addType",
                            type:"post",
                            data:param,
                            success:function (data) {
                                    if (data.code==200){
                                        var treeObj = $.fn.zTree.getZTreeObj("proZtree");

                                         treeObj.addNodes(typeId,data.data);
                                    }
                            }
                        })
                    }
                 }
             });
             $("#addDiv").html(addDiv);
         }

         function deleteZtree(){
             var treeObj = $.fn.zTree.getZTreeObj("proZtree");
             var typeId = treeObj.getSelectedNodes()[0].id;
             $.ajax({
                 url:"<%=request.getContextPath()%>/deleteZtree",
                 type:"post",
                 data:{id:typeId},
                 success:function (data) {
                   if(data.code==200){
                       var treeObj = $.fn.zTree.getZTreeObj("proZtree");
                       var nodes = treeObj.getSelectedNodes();
                       for (var i=0, l=nodes.length; i < l; i++) {
                           treeObj.removeNode(nodes[i]);
                       }
                   }
                 }
             })
         }

            /**
             * 修改ztree
             */
            function updateZtree(){
                var treeObj = $.fn.zTree.getZTreeObj("proZtree");
                var typeId = treeObj.getSelectedNodes()[0].id;
                var typeName = treeObj.getSelectedNodes()[0].name;
                $("#Xname").val(typeName);
                var ztreebox2=bootbox.confirm({
                    title: "管理商品类型-修改",
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
                            var tName=$("#Lname",ztreebox2).val();
                            var param={};
                            param.typeName=tName;
                            param.id=typeId;
                            $.ajax({
                                url:"<%=request.getContextPath()%>/updateType",
                                type:"post",
                                data:param,
                                success:function (data) {
                                    if (data.code==200){
                                        var treeObj = $.fn.zTree.getZTreeObj("proZtree");
                                        var nodes = treeObj.getSelectedNodes();
                                        if(nodes.length>0){
                                            nodes[0].name=tName;
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
