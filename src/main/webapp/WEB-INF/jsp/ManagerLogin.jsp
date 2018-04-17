<%--
  Created by IntelliJ IDEA.
  User: 12dong
  Date: 2018/4/14
  Time: 上午9:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String APP_PATH = request.getContextPath(); %>
<html>
<head>
    <title>登录</title>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
          rel="stylesheet">
    <script src="${APP_PATH}/static/js/jquery-1.11.0.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <h1>
                12Dong尝试登录
            </h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <form>
                <div class="form-group">
                    <label for="managerUsername_input">username</label>
                    <input  class="form-control" id="managerUsername_input" placeholder="username">
                    <span></span>

                </div>
                <div class="form-group">
                    <label for="managerUsernamePassword_input">Password</label>
                    <input type="password" class="form-control" id="managerUsernamePassword_input" placeholder="password">
                    <span></span>

                </div>
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <div>
                <button  class="btn btn-default" id="login_btn">登录</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">


    function reset_form(ele) {
        $(ele)[0].reset();
    }

    $("#login_btn").click(function () {

        if($("#username_input").val()=='')
        {
            $("#username_input").parent().removeClass("has-success has-error");
            $("#username_input").next("span").text("");
            $("#username_input").parent().addClass("has-error");
            $("#username_input").next().text("用户名为空");
            return;
        }else{
            $("#username_input").parent().removeClass("has-success has-error");
            $("#username_input").next("span").text("");
            $("#username_input").parent().addClass("has-success");
        }

        if($("#password_input").val()=='')
        {
            $("#password_input").parent().removeClass("has-success has-error");
            $("#password_input").next("span").text("");
            $("#password_input").parent().addClass("has-error");
            $("#password_input").next().text("密码为空");
            return;
        }else{
            $("#password_input").parent().removeClass("has-success has-error");
            $("#password_input").next("span").text("");
            $("#password_input").parent().addClass("has-success");
        }

        $.ajax({
            url:"${APP_PATH}/ManagerLogin",
            type:"POST",
            dataType:"json",
            contentType : "application/json; charset=utf-8",
            data:JSON.stringify({
                username:$("#username_input").val(),
                password:$("#password_input").val(),
            }),
            success:function (result) {
                console.log(result);
                if(result.code==100){
                    window.location.href='${APP_PATH}/bookClassManager';
                }else{
                    alert("用户名密码不匹配");
                }
            }
        })
    })

</script>

</body>
</html>
