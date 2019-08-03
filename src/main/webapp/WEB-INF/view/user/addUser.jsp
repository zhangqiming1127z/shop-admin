<%--
  Created by IntelliJ IDEA.
  User: zhangqiming
  Date: 2019/6/20
  Time: 18:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="/commons/css.jsp"></jsp:include>
</head>
<body>
<div style="margin-left: 200px"><h2>用户添加</h2></div>
<div  id="add_div" >
    <form class="form-horizontal" id="addUserForm">
        <div class="form-group">
            <label class="col-sm-2 control-label">用户名</label>
            <div class="col-sm-5">
                <input type="text" class="form-control" id="add_userName" name="username" placeholder="请输入用户名..." onblur="queryName(this.value)" >
            </div>
            <div id="fontId"></div>

        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">用户密码</label>
            <div class="col-sm-5">
                <input type="text" class="form-control" name="password" id="add_userPassWord" placeholder="请输入用户密码...">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">用户真实姓名</label>
            <div class="col-sm-5">
                <input type="text" class="form-control" name="realName" id="add_realName" placeholder="请输入用户真实姓名...">
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
        <div class="form-group">
            <label  class="col-sm-2 control-label">邮箱</label>
            <div class="col-sm-5">
                <input type="text" class="form-control" id="add_mail" placeholder="请输入E-mail...">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">手机号</label>
            <div class="col-sm-5">
                <input type="text" class="form-control" id="add_phone" placeholder="请输入手机号...">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">学历</label>
            <div class="col-sm-5">
                <select class="form-control"  id="add_study">
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
                <select class="form-control" id="add_nation">
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
                <input type="text" class="form-control" id="add_idNumber" placeholder="请输入身份证号...">
            </div>
        </div>
        <div class="form-group" id="add_ssx" >
            <label  class="col-sm-2 control-label">省市县</label>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">详细地址</label>
            <div class="col-sm-5">
                <textarea class="form-control" rows="3" placeholder="请输入详细地址..." id="site"></textarea>
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">用户照片</label>
            <div class="col-sm-5">
               <input type="file" id="photo" name="photo">
               <input type="hidden" id="photourl" >
            </div>
        </div>
    <div style="margin-left: 260px">
         <button style="width:170px" type="button"  id="button" class="btn btn-primary" onclick="add()">添加</button>
         <button style="width:170px" type="reset" class="btn btn-default">重置</button>
    </div>
    </form>

</div>

<jsp:include page="/commons/script.jsp"></jsp:include>
<script>
        $(function(){
            level3Linkage(0);
            $('#add_birthday').datetimepicker({
                autoclose: true,
                minView: "month",
                format: "yyyy-mm-dd",
                language: "zh-CN"
            })
            fileInput();
            authentication();
        })

        function queryName(userName) {
            //首先判断是否为空
            if(userName!=null) {
                $.ajax({
                    url: "<%=request.getContextPath()%>/queryName",
                    data: {userName: userName},
                    success: function (data) {
                        if (data.code == 200) {
                            $("#button").removeAttr("disabled");
                            $("#fontId").html("");

                        } else {
                                $("#button").attr("disabled","disabled");
                            $("#fontId").html("<font style=\"color: red\">用户名已存在</font>");
                        }

                    }
                })
            }
            else{
                $("#button").attr("disabled","disabled");
            }
        }



        function add(){
    var userName= $("#add_userName").val();
    var userPassWord= $("#add_userPassWord").val();
    var realName= $("#add_realName").val();
    var birthday= $("#add_birthday").val();
    var sex= $("[name='add_sex']").val();
    var mail=$("#add_mail").val();
    var phone=$("#add_phone").val();
    var study=$("#add_study").val();
    var nation=$("#add_nation").val();
    var idNumber=$("#add_idNumber").val();
    var photourl=$("#photourl").val();
    var site=$("#site").val();
    var id1 = $($("select[name='selected']")[0]).val();
    var id2 = $($("select[name='selected']")[1]).val();
    var id3 = $($("select[name='selected']")[2]).val();
    var param={};
    param.userName=userName;
    param.userPassWord=userPassWord;
    param.realName=realName;
    param.birthday=birthday;
    param.sex=sex;
    param.photo=photourl;
    param.mail=mail;
    param.phone=phone;
    param.study=study;
    param.nation=nation;
    param.province=id1;
    param.city=id2;
    param.county=id3;
    param.idNumber=idNumber;
    param.site=site;
    $.ajax({
        url:"<%=request.getContextPath()%>/addUser",
        type:"post",
        data:param,
        dataType:"json",
        success:function (data) {
            if (data.code==200){
               location.href="skipJsp?url=user/user"
            }
        }
    })
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
                $("#photourl").val(data.response.data);
            }
        })
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
                    if(data.data.length==0){
                        return "";
                    }
                    var list = data.data;
                    var selectStr = "<div class='col-sm-3'><select name='selected' class='form-control' onchange=\"level3Linkage(this.value,this)\"> <option value='-1'>请选择</option>";
                    for(var i=0;i<list.length;i++){
                        selectStr+="<option value='"+list[i].id+"'>"+list[i].name+"</option>";
                    }
                    selectStr+="</select></div>";
                    $("#add_ssx").append(selectStr);
                }
            }
        })
    }

    function authentication(){
        $("#addUserForm").bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                username: {
                    validators: {
                        notEmpty: {
                            message: '用户名不能为空'
                        },
                        stringLength: {
                            min: 1,
                            max: 30,
                            message: '用户名必须大于1，小于30字符长'
                        },
                        /*remote: {
                            url: 'remote.php',
                            message: 'The username is not available'
                        },*/
                        regexp: {
                            regexp: /^[a-zA-Z0-9_\.]+$/,
                            message: '用户名只能由字母、数字、点和下划线组成'
                        }
                    }
                },
                password: {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        }
                    },
                 regexp: {
                 regexp:/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{8,16}$/,
                 message: '至少8-16个字符，至少1个大写字母，1个小写字母和1个数字，其他可以是任意字符'
                 }
                },
                realName: {
                    validators: {
                        notEmpty: {
                            message: '用户真实姓名不能为空'
                        },
                        stringLength: {
                            min: 1,
                            max: 30,
                            message: '用户真实姓名必须大于1，小于30字符长'
                        },
                        /*remote: {
                            url: 'remote.php',
                            message: 'The username is not available'
                        },*/
                        regexp: {
                            regexp: /^[\u2E80-\u9FFF]+$/,
                            message: '用户真实姓名只能填写中文'
                        }
                    }
                },
                realName: {
                    validators: {
                        notEmpty: {
                            message: '用户真实姓名不能为空'
                        },
                        stringLength: {
                            min: 1,
                            max: 30,
                            message: '用户真实姓名必须大于1，小于30字符长'
                        },
                        /*remote: {
                            url: 'remote.php',
                            message: 'The username is not available'
                        },*/
                        regexp: {
                            regexp: /^[\u2E80-\u9FFF]+$/,
                            message: '用户真实姓名只能填写中文'
                        }
                    }
                },
            }
        })




    }

</script>
</body>
</html>
