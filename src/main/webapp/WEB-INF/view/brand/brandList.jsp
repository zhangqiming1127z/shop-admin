<%--
  Created by IntelliJ IDEA.
  User: zhangqiming
  Date: 2019/6/12
  Time: 22:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>类型展示</title>
   <jsp:include page="/commons/css.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/nav/nav.jsp"></jsp:include>
<!-- 列表展示div-->
<div class="container-fluid">
<div class="row">
    <div class="panel panel-default">
        <div class="panel-heading">
           <b>品牌展示</b>
            <span style="margin-left:400px"><button type="button"  class="btn btn-default" onclick="Add()">添加品牌</button></span>
        </div>
        <table id="brandTable" class="table table-striped">
            <thead>
            <tr>
                <th>类型名称</th>
                <th>创建时间</th>
                <th>LOGO</th>
                <th>是否推荐</th>
                <th>操作</th>
            </tr>
            </thead>
        </table>
    </div>
</div>
</div>

<!-- 添加div-->
<div id="addForm" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label  class="col-sm-2 control-label">类型名称</label>
            <div class="col-sm-6">
                <input type="text" class="form-control"  id="add_brandName" placeholder="请输入类型名称..">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">创建时间</label>
            <div class="col-sm-6">
                <input type="text" class="form-control"  id="add_createTime" placeholder="点击选择创建时间..">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">排序</label>
            <div class="col-sm-6">
                <input type="text" class="form-control"  id="add_sort" placeholder="从小到大排..">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">商品图片:</label>
            <div class="col-sm-6">
                <input type="file" class="form-control"  name="photo"  id="photo">
                <input type="hidden" class="form-control"  id="imgurl" >
            </div>
        </div>
    </form>
</div>
<!-- 修改div-->
<div id="updateForm" style="display: none">
    <form class="form-horizontal">
        <input type="hidden" id="id">
        <div class="form-group">
            <label  class="col-sm-2 control-label">类型名称</label>
            <div class="col-sm-6">
                <input type="text" class="form-control"  id="update_brandName" >
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">创建时间</label>
            <div class="col-sm-6">
                <input type="text" class="form-control"  id="update_createTime" >
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">排序</label>
            <div class="col-sm-6">
                <input type="text" class="form-control"  id="a_sort" placeholder="从小到大排..">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">商品图片:</label>
            <div class="col-sm-6">
                <input type="file" class="form-control"  name="photo"  id="photoo">
                <input type="hidden" class="form-control"    id="imgurll" >
            </div>
        </div>
    </form>
</div>
<jsp:include page="/commons/script.jsp"></jsp:include>
<script>
    var brandTable;
    var addBrandDiv;
    var updateBrandDiv;
    $(function(){

        //备份添加div
        addBrandDiv = $("#addForm").html();
       updateBrandDiv = $("#updateForm").html();
        //初始化数据
        brandTable= $("#brandTable").DataTable({
            "bLengthChange": false,
            "processing": true,
            "serverSide": true,
            "searching" : false,
            "ajax":{
                "url":"<%=request.getContextPath()%>/queryBrandList",
                "type":"post",
                "data":{}
            },
            "columns":[
                {"data":"brandName"},
                {"data":"createTime"},
                {"data":"imgurl",render: function (data){
                        return "<img src='"+data+"'  width='45px' class='img-rounded' />"
                    }},
                {"data":"recommend",render:function (data,type,row) {
                    var id = row.id;
                    return data==1?"<button type=\"button\" class=\"btn btn-primary\" onclick=\"recommend('"+data+"','"+id+"');\">推荐</button>":"<button type=\"button\" class=\"btn btn-default\" onclick=\"recommend('"+data+"','"+id+"');\">推荐</button>"

                    }},
                {render:function (data,type,row,meta) {
                        var brandId=row.id;
                        return   '<div class="btn-group" role="group">'+
                            '<button type="button" class="btn btn-primary" onclick="updateBrand(\''+brandId+'\')"><i class="glyphicon glyphicon-pencil"></i>修改</button>'+
                            '<button type="button" class="btn btn-default" onclick="deleteBrand(\''+brandId+'\')"><i class="glyphicon glyphicon-trash"></i>删除</button></div>'}},
            ],
            "language":{"url":"js/DataTables/Chinese.json"}
        })
    })






    var addConfirm;
    function Add(){
        fileInput();
         addConfirm=  bootbox.confirm({
            title: "添加类型",
            message:$("#addForm form"),
            buttons: {
                confirm: {
                    label: '<i class="fa fa-check"></i> 确认'
                },
                cancel: {
                    label: '<i class="fa fa-times"></i>取消'
                }
            },
            callback: function (result) {
                if (result){
                    var add_brandName=$("#add_brandName",addConfirm).val();
                    var add_createTime=$("#add_createTime",addConfirm).val();
                    var add_imgurl=$("#imgurl",addConfirm).val();
                    var sort = $("#add_sort",addConfirm).val();

                    var params={};
                    params.brandName=add_brandName;
                    params.createTime=add_createTime;
                    params.imgurl=add_imgurl;
                    params.sort=sort;
                    $.ajax({
                        url:"<%=request.getContextPath()%>/addBrand",
                        type:"post",
                        data:params,
                        dataType:"json",
                        success:function (data) {
                            if (data.code==200){
                                brandTable.ajax.reload();
                            }
                        },
                    })
                }
            }
        });
        dateFormat();
        $("#addForm").html(addBrandDiv);

    }
    //是否推荐点击事件
    function recommend(recommendId,id){
       var rid = recommendId==1?"0":"1";
       $.ajax({
           url:"updateRecommend",
           data:{"id":id,"rid":rid},
           success:function (data) {
               if (data.code==200){
                   brandTable.ajax.reload();
               }
           }
       })
    }



    function fileInput() {
        var imgurl = $("#imgurl").val();
        var previewArr = [];
        previewArr.push(imgurl);
        $("#photo").fileinput({
            language: 'zh',
            allowedPreviewMimeTypes: ['jpg', 'png', 'gif'],
            initialPreview: previewArr,
            initialPreviewAsData: true,
            showPreview: true,
            showUpload: true, //是否显示上传按钮,跟随文本框的那个
            showRemove: false, //显示移除按钮,跟随文本框的那个
            showCaption: false,//是否显示标题,就是那个文本框
            dropZoneEnabled: false,
            uploadAsync:true,
            uploadUrl: "<%=request.getContextPath()%>/uploadInput",
        }).on("fileuploaded", function (event, data, previewId, index) {
            if (data != null && data.response.code == 200) {
                $("#imgurl",addConfirm).val(data.response.data);
            }

        })
    }


    function deleteBrand(id) {
        bootbox.confirm("确定要删除该条类型信息吗!", function(result){
            if (result){
                $.ajax({
                    url:"<%=request.getContextPath()%>/deleteBrand",
                    type:"post",
                    data:{id:id},
                    dataType:"json",
                    success:function (data) {
                        brandTable.ajax.reload();
                    }

                })
            }
        });
    }
    var updateConfirm;
    function updateBrand(id) {
        $.ajax({
            url:"<%=request.getContextPath()%>/findBrandById",
            type:"post",
            data:{id:id},
            dataType:"json",
            async:true,
            success:function(data){
                var Brand=data.data;
                $("#id").val(Brand.id);
                $("#update_brandName").val(Brand.brandName);
                $("#update_createTime").val(Brand.createTime);
                $("#imgurll").val(Brand.imgurl);
                $("#a_sort").val(Brand.sort);
                fileInput2();
               updateConfirm=  bootbox.confirm({
                    title: "类型修改",
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
                        if (result){
                           var id= $("#id",updateConfirm).val();
                            var name=$("#update_brandName",updateConfirm).val();
                            var time=$("#update_createTime",updateConfirm).val();
                            var imgurl=$("#imgurll",updateConfirm).val();
                            var a_sort=$("#a_sort",updateConfirm).val();
                            var brandParam={};
                            brandParam.id=id;
                            brandParam.brandName=name;
                            brandParam.createTime=time;
                            brandParam.imgurl=imgurl;
                            brandParam.sort=a_sort;
                            $.ajax({
                                url:"<%=request.getContextPath()%>/updateBrand",
                                type:"post",
                                data:brandParam,
                                dataType:"json",
                                success:function(data){
                                    if (data.code="200"){
                                        proTable.ajax.reload();

                                    }
                                }
                            })
                        }

                    }

                });

                dateFormat();
                $("#updateForm ").html(updateBrandDiv);
            }
        })


    }

    function dateFormat() {
        $('#add_createTime').datetimepicker({
            autoclose: true,
            maxView: "month",
            minView: "month",
            format: "yyyy",
            language:"zh-CN"

        });
        $('#update_createTime').datetimepicker({
            autoclose: true,
            maxView: "month",
            minView: "month",
            format: "yyyy",
            language:"zh-CN"
        });

    }
    function fileInput2() {
        var imgurll = $("#imgurll").val();
        var previewArr = [];
        previewArr.push(imgurll);
        $("#photoo").fileinput({
            async:true,
            language: 'zh',
            allowedPreviewMimeTypes: ['jpg', 'png', 'gif'],
            initialPreview: previewArr,
            initialPreviewAsData: true,
            showPreview: true,
            showUpload: true, //是否显示上传按钮,跟随文本框的那个
            showRemove: false, //显示移除按钮,跟随文本框的那个
            showCaption: false,//是否显示标题,就是那个文本框
            dropZoneEnabled:false,
            uploadUrl: "<%=request.getContextPath()%>/uploadInput",
        }).on("fileuploaded", function (event, data, previewId, index) {
            $("#imgurll",updateConfirm).val(data.response.data);
            if (data != null && data.response.code == 200) {
                $("#imgurll",updateConfirm).val(data.response.data);
                $("#imgurll").val(data.response.data);
            }

        })
    }
</script>
</body>
</html>
