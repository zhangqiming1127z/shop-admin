<%--
  Created by IntelliJ IDEA.
  User: zhangqiming
  Date: 2019/6/16
  Time: 19:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录界面</title>
   <jsp:include page="/commons/css.jsp"></jsp:include>
</head>
<body>

<div class="container">
    <br>
    <br>
    <br>
    <br>
    <div id="row">

        <div class="col-md-2"></div>
        <div class="col-md-10">
           <div><img src="/js/logo.jpg"></div>
            <form class="form-horizontal" id="abc">
                <div class="form-group">
                    <label  class="col-sm-2 control-label">用户名</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" name="userName"  id="userName" placeholder="请输入用户名...">
                    </div>
                </div>
                 <div class="form-group">
                    <label  class="col-sm-2 control-label">用户密码</label>
                    <div class="col-sm-4">
                        <input type="password" class="form-control" name="password" id="userPassWord" placeholder="请输入用户密码...">
                    </div>
                </div>

                <div class="form-group">
                    <div style="margin-left: 170px"><button type="button" class="btn btn-primary" onclick="login()" style="width:289px">登录</button></div>
                </div>
            </form>
        </div>
    </div>
</div>


<jsp:include page="/commons/script.jsp"></jsp:include>
<script>

    $(function () {
        $("#abc").bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                userName: {
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
                    }
                }
            }
        })

    })
        function login() {
            var userName=$("#userName").val();
            var psd=$("#userPassWord").val();
            var userPassWord=$.md5(psd);

            $.ajax({
                url:"<%=request.getContextPath()%>/userLogin",
                type:"post",
                data:{"userName":userName,
                      "userPassWord":userPassWord,

                },
                success:function (data) {
                  if(data.code==200){

                      location.href="skipJsp?url=product/proList";
                  }else {
                      alert(data.mag);
                  }
                    }
            })
        }



</script>
</body>
</html>
