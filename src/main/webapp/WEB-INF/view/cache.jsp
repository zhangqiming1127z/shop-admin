<%--
  Created by IntelliJ IDEA.
  User: zhangqiming
  Date: 2019/7/7
  Time: 14:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>清理缓存</title>
    <jsp:include page="/commons/css.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/nav/nav.jsp"></jsp:include>
<div class="container">
    <div class="row">
        <div class="panel panel-default">
            <div class="panel-heading">
                <button type="button" class="btn btn-danger" onclick="delCache()">清理缓存</button>
            </div>
            <div class="panel-body">
                <label class="checkbox-inline">
                    <input type="checkbox" id="check" name="checkbox"  value="productList" style="margin-top:12px">
                    <button type="button" class="btn btn-primary"  onclick="checked('check')">后台商品表缓存</button>
                </label>
                <label class="checkbox-inline">
                    <input type="checkbox" id="inlineCheckbox2"  name="checkbox" style="margin-top:12px" value="brand">
                    <button type="button" class="btn btn-default"  onclick="checked('inlineCheckbox2')">后台品牌表缓存</button>
                </label>
                <label class="checkbox-inline">
                    <input type="checkbox" id="inlineCheckbox3"  name="checkbox" style="margin-top:12px" value="api/brandList">
                    <button type="button" class="btn btn-success"  onclick="checked('inlineCheckbox3')">前台展示页面缓存</button>
                </label>

            </div>
        </div>
    </div>
</div>
<jsp:include page="/commons/script.jsp"></jsp:include>
<script>


    function checked(id){
        if($("#"+id).get(0).checked){
            $("#"+id).get(0).checked=false;
        }else {
            $("#"+id).get(0).checked=true;
        }
    }
    function delCache() {
        var str="";
       $("input[name='checkbox']:checked").each(function () {
                 str+= $(this).val()+",";
        })
        var s = str.substring(0,str.length-1)
        console.log(s);

        $.ajax({
            url:"delCache",
            data:{"str":str},
            type:"post",
            success:function (data) {
                if (data==200){
                    alert("111111")
                }
            }
        })


    }
</script>
</body>
</html>
