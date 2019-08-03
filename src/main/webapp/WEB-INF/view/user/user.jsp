<%--
  Created by IntelliJ IDEA.
  User: zhangqiming
  Date: 2019/6/16
  Time: 21:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/DataTables/datatables.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/js/fileinput/css/fileinput.min.css">
</head>
<body>
<jsp:include page="/nav/nav.jsp"></jsp:include>
<div style="margin-left:40px">
    <button type="button" class="btn btn-primary" onclick="addUser()">添加用户</button>
</div>

<div class="container-fluid">
    <div class="row">
        <form class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-1 control-label">用户名称</label>
                <div class="col-sm-2">
                    <input type="text" class="form-control" id="q_userName" placeholder="输入用户名...">
                </div>

            </div>
            <div class="form-group">
                <label class="col-sm-1 control-label">真实姓名</label>
                <div class="col-sm-2">
                    <input type="text" class="form-control" id="userName" placeholder="输入用户名...">
                </div>

            </div>

            <div class="form-group">
                <label  class="col-sm-1 control-label">生日查询</label>
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
            <div class="form-group"  id="query">
                <label  class="col-sm-1 control-label">省市县</label>
            </div>


            <div style="margin-left:130px">
                <button type="button" class="btn btn-primary" onclick="search()"><i class="glyphicon glyphicon-search" ></i>搜索</button>
                <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-refresh"></i>重置</button>
            </div>
        </form>
    </div>
    <div class="row">
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-heading">用户表展示</div>
                    <div class="panel-body">
                        <table id="userTable" class="display" style="width:100%">
                            <thead>
                            <tr>
                                <th>照片</th>
                                <th>用户名</th>
                                <th>密码</th>
                                <th>真实姓名</th>
                                <th>生日</th>
                                <th>性别</th>
                                <th>手机号</th>
                                <th>邮箱</th>
                                <th>学历</th>
                                <th>民族</th>
                                <th>身份证号</th>
                                <th>省/市/县</th>
                                <th>详细住址</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tfoot>
                            <tr>
                                <th>照片</th>
                                <th>用户名</th>
                                <th>密码</th>
                                <th>真实姓名</th>
                                <th>生日</th>
                                <th>性别</th>
                                <th>手机号</th>
                                <th>邮箱</th>
                                <th>学历</th>
                                <th>民族</th>
                                <th>身份证号</th>
                                <th>省/市/县</th>
                                <th>详细住址</th>
                                <th>操作</th>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<div  id="add_div" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">用户名</label>
            <div class="col-sm-5">
                <input type="text" class="form-control" id="add_userName" placeholder="请输入用户名..." onblur="queryName(this.value)" >
            </div>
            <div id="fontId"  style="display: none"><font style="color: red">用户名已存在</font></div>

        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">用户密码</label>
            <div class="col-sm-5">
                <input type="text" class="form-control" id="add_userPassWord" placeholder="请输入用户密码...">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">用户真实姓名</label>
            <div class="col-sm-5">
                <input type="text" class="form-control" id="add_realName" placeholder="请输入用户真实姓名...">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">用户性别</label>
            <div class="col-sm-5">
                <label class="checkbox-inline">
                    <input type="radio" name="add_sex" value="1">男
                </label>
                <label class="checkbox-inline">
                    <input type="radio" name="add_sex" value="1">女
                </label>
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">用户生日</label>
            <div class="col-sm-5">
                <input type="text" class="form-control" id="add_birthday" placeholder="点击选择用户生日...">
            </div>
        </div>
    </form>
</div>
<div  id="update_div" style="display: none">
    <form class="form-horizontal">
        <input type="hidden" id="id">
        <div class="form-group">
            <label class="col-sm-2 control-label">用户名</label>
            <div class="col-sm-5">
                <input type="text" class="form-control" id="update_userName" placeholder="请输入用户名..." onblur="queryName(this.value)">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">用户密码</label>
            <div class="col-sm-5">
                <input type="text" class="form-control" id="update_userPassWord" placeholder="请输入用户密码...">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">用户真实姓名</label>
            <div class="col-sm-5">
                <input type="text" class="form-control" id="update_realName" placeholder="请输入用户真实姓名...">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">用户性别</label>
            <div class="col-sm-5">
                <label class="checkbox-inline">
                    <input type="radio" name="update_sex" value="1">男
                </label>
                <label class="checkbox-inline">
                    <input type="radio" name="update_sex" value="2">女
                </label>
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">用户生日</label>
            <div class="col-sm-5">
                <input type="text" class="form-control" id="update_birthday" placeholder="点击选择用户生日...">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">邮箱</label>
            <div class="col-sm-5">
                <input type="text" class="form-control" id="mail" placeholder="请输入E-mail...">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">手机号</label>
            <div class="col-sm-5">
                <input type="text" class="form-control" id="phone" placeholder="请输入手机号...">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">学历</label>
            <div class="col-sm-5">
                <select class="form-control"  id="study">
                    <option value="-1">请选择</option>
                    <option value="1">博士</option>
                    <option value="2">硕士</option>
                    <option value="3">大学</option>
                    <option value="4">大专</option>
                    <option value="5">中专</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">民族</label>
            <div class="col-sm-5">
                <select class="form-control" id="nation">
                    <option value="-1">请选择</option>
                    <option value="1">汉族</option>
                    <option value="2">回族</option>
                    <option value="3">维吾尔族</option>
                    <option value="4">朝鲜族</option>
                    <option value="5">苗族</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">身份证号</label>
            <div class="col-sm-5">
                <input type="text" class="form-control" id="idNumber" placeholder="请输入身份证号...">
            </div>
        </div>
        <div class="form-group" id="selectSsx">
            <label  class="col-sm-2 control-label">省市县</label>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">详细地址</label>
            <div class="col-sm-5">
                <textarea class="form-control" id="site" rows="3" placeholder="请输入详细地址..."></textarea>
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">用户照片</label>
            <div class="col-sm-5">
                <input type="file" id="photo" name="photo">
                <input type="text" id="photourl" >
            </div>
        </div>
    </form>
</div>
<script src="<%=request.getContextPath()%>/js/jquery-3.3.1.js"></script>
<script src="<%=request.getContextPath()%>/js/DataTables/DataTables-1.10.18/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-datetimepicker-master/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/js/box/bootbox.min.js"></script>
<script src="<%=request.getContextPath()%>/js/box/bootbox.locales.min.js"></script>
<script src="<%=request.getContextPath()%>/js/fileinput/js/fileinput.min.js"></script>
<script src="<%=request.getContextPath()%>/js/fileinput/js/locales/zh.js"></script>

<script>
    var addDiv;
    var updateDiv;
    $(function(){
        //初始化分页表格
        initUserTable();
        addDiv=$("#add_div").html();
        updateDiv=$("#update_div").html();
        dateFormat();
        level3Linkage(0);
    })




    
    var  userTable;
    function initUserTable(){
       userTable = $("#userTable").DataTable({
            "processing": true,
            "serverSide": true,
            "searching": false,
            "bLengthChange": false,
            "ajax": {
                "url": "<%=request.getContextPath()%>/queryUser",
            },

            "columns": [
                {"data": "photo",render:function (data) {
                    return "<img src='<%=request.getContextPath()%>/"+data+"' width='30px'>"
                    }},
                {"data": "userName"},
                {"data": "userPassWord"},
                {"data": "realName"},
                {"data":"birthday"},
                {"data":"sex"},
                {"data":"phone"},
                {"data":"mail"},
                {"data":"study"},
                {"data":"nation"},
                {"data":"idNumber"},
                {"data":"areaName"},
                {"data":"site"},
                {
                    "data": "id", render: function (data, row) {
                        return '<div class="btn-group" role="group">' +
                            '<button type="button" class="btn btn-primary" onclick="updateUser(\'' + data + '\')"><i class="glyphicon glyphicon-pencil"></i>修改</button>' +
                            '<button type="button" class="btn btn-default" onclick="deleteUser(\'' + data + '\')"><i class="glyphicon glyphicon-trash"></i>删除</button></div>'
                    }
                },
            ],
            "language": {"url": "js/DataTables/Chinese.json"}
        })

    }
    function deleteUser(id){
        bootbox.confirm("您确认要删除该用户信息吗？", function(result){
            if (id!=null){
                $.ajax({
                    url:"<%=request.getContextPath()%>/deleteUser",
                    type:"post",
                    data:{"id":id},
                    dataType:"json",
                    success:function (data) {
                            if (data.code==200){
                                userTable.ajax.reload();
                            }
                    }
                })
            }
        });

    }

    function addUser(){
        location.href="<%=request.getContextPath()%>/skipJsp?url=user/addUser"
    }
    var update_box;
    function updateUser(id){
        fileInput();
        $.ajax({
            url:"<%=request.getContextPath()%>/findUserById",
            type:"post",
            data:{"id":id},
            dataType:"json",
            success:function (data) {
                if (data.code==200){
                    $("#update_userName").val(data.data.userName);
                    $("#update_realName").val(data.data.realName);
                    $("#update_birthday").val(data.data.birthday);
                    $("#mail").val(data.data.mail);
                    $("#phoneurl").val(data.data.phone);
                    $("#study").val(data.data.study);
                    $("#nation").val(data.data.nation);
                    $("#idNumber").val(data.data.idNumber);
                    $("#site").val(data.data.site);
                    $("[name='update_sex']").each(function () {
                        if($(this).val()==data.data.sex){
                            this.checked=true;
                        }
                    })
                    $("#update_userPassWord").val(data.data.userPassWord);
                    $("#id").val(data.data.id);
                    $("#selectSsx",update_box).append("<label id='updateLabel' class=\"col-sm-5 control-label\">"+data.data.areaName+"</label>");
                    $("#selectSsx",update_box).append(" <button type=\"button\" class=\"btn btn-primary\" onclick='edit(\""+data.data.areaName+"\");'><span class='glyphicon glyphicon-edit'></span><span id='edit_Text'>编辑</span></button>")
                   update_box= bootbox.confirm({
                        title: "添加操作",
                        message:$("#update_div form"),
                        buttons: {
                            cancel: {
                                label: '<i class="fa fa-times"></i>取消'
                            },
                            confirm: {
                                label: '<i class="fa fa-check"></i> 保存'
                            }
                        },
                        callback: function (result) {
                            if (result){
                                var userName= $("#update_userName",update_box).val();
                                var userPassWord= $("#update_userPassWord",update_box).val();
                                var realName= $("#update_realName",update_box).val();
                                var birthday= $("#update_birthday",update_box).val();
                                var sex= $("[name='update_sex']",update_box).val();
                                var id= $("#id",update_box).val();
                                var mail=$("#mail",update_box).val();
                                var phone=$("#phone",update_box).val();
                                var study=$("#study",update_box).val();
                                var nation=$("#nation",update_box).val();
                                var idNumber=$("#idNumber",update_box).val();
                                var photourl=$("#photourl",update_box).val();
                                var id1;
                                var id2;
                                var id3;
                                if(flag==0){
                                    id1=data.data.province;
                                    id2=data.data.city;
                                    id3=data.data.county;
                                }else {
                                     id1 = $($("select[name='selectArea']",update_box)[0]).val();
                                     id2 = $($("select[name='selectArea']",update_box)[1]).val();
                                     id3 = $($("select[name='selectArea']",update_box)[2]).val();
                                }
                                var site = $("#site",update_box);
                                var param={};
                                param.userName=userName;
                                param.userPassWord=userPassWord;
                                param.realName=realName;
                                param.birthday=birthday;
                                param.sex=sex;
                                param.id=id;
                                param.mail=mail;
                                param.phone=phone;
                                param.study=study;
                                param.nation=nation;
                                param.idNumber=idNumber;
                                param.photourl=photourl;
                                param.province=id1;
                                param.city=id2;
                                param.county=id3;
                                param.site=site;
                                $.ajax({
                                    url:"<%=request.getContextPath()%>/updateUser",
                                    type:"post",
                                    data:param,
                                    dataType:"json",
                                    success:function (data) {
                                        if (data.code==200){
                                            userTable.ajax.reload();
                                        }
                                    }
                                })
                            }

                        }

                    });
                    update();
                    flag=0;
                    $("#update_div").html(updateDiv);
                }
            }
        })
    }
    function search(){
        var userName = $("#q_userName").val();
        var minDate = $("#minDate").val();
        var maxDate = $("#maxDate").val();
        var realName=$("#userName").val();
        var id1 = $($("select[name='query']")[0]).val();
        var id2 = $($("select[name='query']")[1]).val();
        var id3 = $($("select[name='query']")[2]).val();
        var param = {}
        param.userName = userName;
        param.minDate=minDate;
        param.maxDate=maxDate;
        param.realName=realName;
        param.province=id1;
        param.city=id2;
        param.county=id3;
        userTable.settings()[0].ajax.data = param;
        userTable.ajax.reload();

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

    function update(){
        $('#update_birthday').datetimepicker({
            autoclose:true,
            minView: "month",
            format: 'yyyy-mm-dd',
            language: 'zh-CN'
        });
    }

    function level3Linkage(pid,obj) {
        if(obj){
            $(obj).parent().nextAll().remove();
        }
        $.ajax({
            url:"<%=request.getContextPath()%>/threeArea",
            data:{"pid":pid},
            type:"post",
            success:function (data) {
                if(data.code==200){
                    var list = data.data;
                    if (data.data.length == 0) {
                        return;
                    }
                    var selectStr = "<div class='col-sm-3'><select name=\"query\" class='form-control' onchange=\"level3Linkage(this.value,this)\">" +
                        "<option value='-1'>请选择</option>";
                    for(var i=0;i<list.length;i++){
                        selectStr+="<option value='"+list[i].id+"'>"+list[i].name+"</option>";
                    }
                    selectStr+="</select></div>";
                    $("#query").append(selectStr);
                }
            }
        })
    }
    function level3Linkage_(pid,obj) {
        if(obj){
            $(obj).parent().nextAll().remove();
        }
        $.ajax({
            url:"<%=request.getContextPath()%>/threeArea",
            data:{"pid":pid},
            type:"post",
            success:function (data) {
                if(data.code==200){
                    var list = data.data;
                    if (data.data.length == 0) {
                        return;
                    }
                    var selectStr = "<div class='col-sm-3'><select name=\"selectArea\" class='form-control' onchange=\"level3Linkage_(this.value,this)\">" +
                        "<option value='-1'>请选择</option>";
                    for(var i=0;i<list.length;i++){
                        selectStr+="<option value='"+list[i].id+"'>"+list[i].name+"</option>";
                    }
                    selectStr+="</select></div>";
                    $("#selectSsx",update_box).append(selectStr);
                }
            }
        })
    }
    var flag=0;
    function edit(typeName){
        if(flag==0){
            $("#edit_Text").html("取消编辑");
            level3Linkage_(0);
            $("#updateLabel").remove();
            flag=1;
        }
        else {
            $("#selectSsx div").remove();
            $("#edit_Text").html("编辑");
            $("#selectSsx",update_box).append("<label id='updateLabel' class=\"col-sm-5 control-label\">"+typeName+"</label>")
            flag=0;
        }

    }
    function fileInput() {
        var photourl = $("#photourl").val();
        var previewArr = [];
        previewArr.push(photourl);
        $("#photo").fileinput({
            language: 'zh',
            allowedPreviewMimeTypes: ['jpg', 'png', 'gif'],
            initialPreview: previewArr,
            initialPreviewAsData: true,
            showUpload: true, //是否显示上传按钮,跟随文本框的那个
            showRemove: false, //显示移除按钮,跟随文本框的那个
            showCaption:false,//是否显示标题,就是那个文本框
            dropZoneEnabled: false,
            uploadUrl: "<%=request.getContextPath()%>/uploadInput",
        }).on("fileuploaded", function (event, data, previewId, index) {
            if (data != null && data.response.code == 200) {
                $("#photourl",update_box).val(data.response.data);
            }
        })
    }
</script>
</body>
</html>
