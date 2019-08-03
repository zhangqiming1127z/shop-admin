<%--
  Created by IntelliJ IDEA.
  User: zhangqiming
  Date: 2019/6/20
  Time: 19:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>主页</title>
    <link href="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css">
</head>
<body>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"><span class="glyphicon glyphicon-star-empty"></span>郑州飞狐</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">校园风采<span class="sr-only">(current)</span></a></li>
                <li><a href="#">师资团队</a></li>
                <li><a href="#">明星学员</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">后台管理<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="skipJsp?url=product/proList">商品后台</a></li>
                        <li><a href="skipJsp?url=user/user">用户后台</a></li>
                        <li><a href="skipJsp?url=log">日志后台</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="#">Separated link</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="#">One more separated link</a></li>
                    </ul>
                </li>
            </ul>


            </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">欢迎${user.realName}
                    <c:if test="${!empty user.loginTime}">
                        ,上次登录<fmt:formatDate value="${user.loginTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                    </c:if>
                   </a></li>
                <li><a href="#" onclick="zhuxiao()">注销</a></li>
            </ul>
        </div>
    </div>

</nav>
<script src="<%=request.getContextPath()%>/js/jquery-3.3.1.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script>


</script>
</body>
</html>
