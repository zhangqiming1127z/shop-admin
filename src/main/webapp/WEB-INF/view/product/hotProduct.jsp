<%--
  Created by IntelliJ IDEA.
  User: zhangqiming
  Date: 2019/7/11
  Time: 14:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>热销商品</title>
    <jsp:include page="/commons/css.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/nav/nav.jsp"></jsp:include>
<div class="container-fluid">
    <div class="page-header">
        <div><img src="img/head.jpg" style="width:300px;height:120px;margin-top:-29px"></div>
    </div>


    <div id="data" class="row">

    </div>
</div>
<div id="product" style="display: none;">
    <div class='col-sm-4 col-md-3' style="text-align: center">
        <div class='thumbnail'>
            <div style="margin-left:90px"><img src='##img##' class='img-responsive'
                                               style="height:200px"></div>
            <div class='caption'>
                <h3>##proName##</h3>
                <p>￥##price##.00元</p>
                <p><a href="#" class="btn btn-primary" role="button">购买</a> <a href="#" class="btn btn-default"
                                                                               role="button"><span
                        class='glyphicon glyphicon-shopping-cart'></span>&nbsp;加入购物车</a></p>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/commons/script.jsp"></jsp:include>
<script>
    $(function () {
        initProduct();
    })
    function initProduct() {
        $.ajax({
            url: "getHotProduct",
            type: "post",
            success: function (result) {
                if (result.code == 200) {
                    var productList = result.data;
                    if (productList != null) {
                        for (var i = 0; i < productList.length; i++) {
                            var showDiv = $("#product").html();
                            var s = showDiv.replace(/##proName##/g, productList[i].proName);
                            var s1 = s.replace(/##price##/g, productList[i].price);
                            var s2 = s1.replace(/##img##/g, productList[i].imgurl);
                            $("#data").append(s2);
                        }
                    }

                }
            }
        })
    }
</script>
</body>
</html>
