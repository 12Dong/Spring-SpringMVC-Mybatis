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
<%--书籍添加模态框--%>
<div class="modal fade" id="UserAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">图书添加</h4>
            </div>
            <div class="modal-body">
                <%--=====================表单=====================    --%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="username_add"  class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="username" id="username_add" placeholder="username">
                            <span></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password_add"  class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" name="password" id="password_add" placeholder="password">
                            <span></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password_confirm"  class="col-sm-2 control-label">密码确认</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" name="password" id="password_confirm" placeholder="password-confirm">
                            <span></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="UserNickName_add"  class="col-sm-2 control-label">用户昵称</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="UserName" id="UserNickName_add" placeholder="用户昵称">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="telephone_add"  class="col-sm-2 control-label">联系方式</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="telephone" id="telephone_add" placeholder="联系方式">
                            <span></span>

                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add"  class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="telephone" id="email_add" placeholder="邮箱">
                            <span></span>

                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="user_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<%--=========================================================================================================--%>

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <h1>
                    大仙尝试登录
                </h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <form>
                    <div class="form-group">
                        <label for="username_input">username</label>
                        <input  class="form-control" id="username_input" placeholder="username">
                        <span></span>

                    </div>
                    <div class="form-group">
                        <label for="password_input">Password</label>
                        <input type="password" class="form-control" id="password_input" placeholder="password">
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

                <div>
                    <button  class="btn btn-default" id="register_btn">注册</button>
                </div>

            </div>
        </div>
    </div>

    <script type="text/javascript">
        //点击新增按钮 淡出模态框
        //点击新增按钮 淡出模态框
        $("#register_btn").click(function(){
            //弹出模态框
            reset_form("#UserAddModal form");
            $("#UserAddModal").modal({
                backdrop:"static"
            })
        });

        function reset_form(ele) {
            $(ele)[0].reset();
        }


        $("#user_save_btn").click(function () {
            if($("#password_add").val()!=$("#password_confirm").val()){
                $("#password_add").parent().removeClass("has-success has-error");
                $("#password_add").next("span").text("");
                $("#password_add").parent().addClass("has-error");
                $("#password_add").next().text("两次密码不同");
                return ;
            }else{
                $("#password_add").parent().removeClass("has-success has-error");
                $("#password_add").next("span").text("");
                $("#password_add").parent().addClass("has-success");
            }
            var telephone = $("#telephone_add").val();
            var regName = /(^[0-9]{11}$)/;
            if(!regName.test(telephone)){
                $("#telephone_add").parent().removeClass("has-success has-error");
                $("#telephone_add").next("span").text("");
                $("#telephone_add").parent().addClass("has-error");
                $("#telephone_add").next().text("联系方式应为11位数字");
                return ;
            }else{
                $("#telephone_add").parent().removeClass("has-success has-error");
                $("#telephone_add").next("span").text("");
                $("#telephone_add").parent().addClass("has-success");
            }

            var email = $("#email_add").val();
            var regName = /(^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$)/;
            if(!regName.test(email)){
                $("#email_add").parent().removeClass("has-success has-error");
                $("#email_add").next("span").text("");
                $("#email_add").parent().addClass("has-error");
                $("#email_add").next().text("邮箱格式出错");
                return ;
            }else{
                $("#email_add").parent().removeClass("has-success has-error");
                $("#email_add").next("span").text("");
                $("#email_add").parent().addClass("has-success");
            }

            $.ajax({
                url:"${APP_PATH}/user",
                type:"PUT",
                dataType:"json",
                contentType : "application/json; charset=utf-8",
                data:JSON.stringify({
                    username:$("#username_add").val(),
                    password:$("#password_add").val(),
                    passwordConfirm:$("#password_confirm").val(),
                    userNickName:$("#UserNickName_add").val(),
                    telephone:$("#telephone_add").val(),
                    email:$("#email_add").val()
                }),
                success:function(result){
                    alert("注册成功");
                    console.log(result);
                    window.location.href='${APP_PATH}/bookClassReader';
                }
            })
        })

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
                url:"${APP_PATH}/UserLogin",
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
                        window.location.href='${APP_PATH}/bookClassReader';
                    }else{
                        alert("用户名密码不匹配");
                    }
                }
            })
        })

    </script>

</body>
</html>
