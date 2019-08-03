<%--
  Created by IntelliJ IDEA.
  User: zhangqiming
  Date: 2019/6/27
  Time: 12:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"><span class="glyphicon glyphicon-leaf">&nbsp;</span>飞狐科技</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav" id="ul">
                <li class="active" id="id_1"><a href="skipJsp?url=product/proList#1" onclick="createCookie(this)">商品管理</a></li>
                <li id="id_2"><a href="<%=request.getContextPath()%>/skipJsp?url=user/user#2" onclick="createCookie(this)">用户管理<span class="sr-only">(current)</span></a></li>
                <li id="id_3"><a href="<%=request.getContextPath()%>/skipJsp?url=log/log#3" onclick="createCookie(this)">日志管理</a></li>
                <li id="id_4"><a href="<%=request.getContextPath()%>/skipJsp?url=brand/brandList#4" onclick="createCookie(this)">品牌管理</a></li>
                <li id="id_5"><a href="<%=request.getContextPath()%>/skipJsp?url=classify/proclass#5" onclick="createCookie(this)">分类管理</a></li>
                <li id="id_6"><a href="<%=request.getContextPath()%>/skipJsp?url=area/area#6" onclick="createCookie(this)">地区管理</a></li>
                <li id="id_9"><a href="<%=request.getContextPath()%>/skipJsp?url=member/memberList#9" onclick="createCookie(this)">会员管理</a></li>
                <li id="id_7"><a href="<%=request.getContextPath()%>/skipJsp?url=Garbage/GC#7" onclick="createCookie(this)">回收站</a></li>
                <li id="id_8"><a href="<%=request.getContextPath()%>/skipJsp?url=cache#8" onclick="createCookie(this)">清理缓存</a></li>

            </ul>
            </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">欢迎${user.realName}
                    <c:if test="${!empty user.loginTime}">
                        ,上次登录<fmt:formatDate value="${user.loginTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                    </c:if>
                </a></li>
                <li><a href="#" onclick="offUser()">注销</a></li>
            </ul>
        </div>
    </div>

</nav>
<script src="<%=request.getContextPath()%>/js/jquery-3.3.1.js"></script>
<script src="<%=request.getContextPath()%>/js/cookie.js"></script>
<script>
    $(function(){
       /* var cookie1 = document.cookie;
        $("#ul li").each(function () {
            if( $(this).text()===cookie1){
                $(this).siblings().removeClass("active");
                $(this).addClass("active");
            }else {
                return;
            }
        })*/
        nav();
    })
    //cookie 保存nav状态
   /* function createCookie(obj){
        var text = $(obj).parent().text();
        document.cookie=text;
        $(obj).parent().siblings().removeClass("active");
        $(obj).parent().addClass("active");
    }*/


    function nav(){
        var hash = location.hash;
        var s = hash.substring(1);
        if(s.length>0){
        $("#id_"+s).siblings().removeClass("active");
        $("#id_"+s).addClass("active");
        }
    }

    function clearAllCookie() {

    }
    //注销用户
    function offUser() {
        $.ajax({
            url: "offUser",
            success: function (data) {
                if (data.code == 200) {
                    document.cookie="userInfo=; expires=Thu, 01 Jan 1970 00:00:00 GMT\";";
                    location.href = "/";
                }
            }
        })
    }
</script>