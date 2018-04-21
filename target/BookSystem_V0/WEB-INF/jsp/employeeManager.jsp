
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String APP_PATH = request.getContextPath(); %>
<html>
<head>
    <title>书籍目录</title>
    <link
            href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script src="${APP_PATH}/static/js/jquery-1.11.0.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%--员工添加模态框--%>
<div class="modal fade" id="employeeAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <%--=====================表单=====================    --%>
                <form class="form-horizontal">

                    <div class="form-group">
                        <label for="employeeName_add"  class="col-sm-2 control-label">员工名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="name" id="employeeName_add" placeholder="EmployeeName">
                            <span></span>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="employee_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<%--=========================================================================================================--%>

<%--======================================员工修改模态框======================================--%>
<div class="modal fade" id="EmployeeUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myUpdateLabel">员工修改</h4>
            </div>
            <div class="modal-body">
                <%--=====================表单=====================    --%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="EmployeeName_add"  class="col-sm-2 control-label">员工民</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="name" id="EmployeeName_update" placeholder="employeeName">
                            <span></span>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="employee_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <%--标题行--%>
    <div class="row">
        <div class="col-md-12">
            <h1>大邪神的员工管理</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary" id="employee_add_modal_btn">新增</button>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <input type="text" class="form-control" id="employeeName_query" placeholder="员工名字" aria-describedby="basic-addon1">
            </div>
            <div class="col-md-4">
                <button class="btn btn-primary" id="employee_find_modal_btn" >查询</button>
            </div>

        </div>

    </div>
    <%--显示 表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="employee_table">
                <thead>
                    <tr>
                        <td>Id</td>
                        <td>名字</td>
                        <td>操作</td>

                    </tr>
                </thead>
                <tbody >
                </tbody>
            </table>
        </div>
    </div>
        <%--显示分页信息--%>
        <div class="row">
            <%--分页文字信息--%>
            <div class="col-md-6" id="page_info_area">
            </div>
            <%--分页条信息--%>
            <div class="col-md-6" id="page_nav_area">

            </div>
        </div>
</div>
<script type="text/javascript">
    var totalRecord,currentRecord;
    $(function() {
        toPage(1);
    })


    $("#employee_find_modal_btn").click(function () {
        $.ajax({
            url:"${APP_PATH}/employeeQuery",
            data: "name="+$("#employeeName_query").val(),
            type:"GET",
            success:function(result){
                alert(result);
                console.log(result);
                build_book_table(result);
                build_page_nav(result);
                build_page_info(result);
            }
        })
    })
// =============到达某一页面=============
    function toPage(num) {
        $.ajax({
            url:"${APP_PATH}/employee",
            data:"pn="+num,
            type:"GET",
            success:function (result) {
                console.log(result);
                build_book_table(result);
                build_page_nav(result);
                build_page_info(result);
            }
        })
    }
// =============构造页面表单=============
    function build_book_table(result) {
        $("#employee_table tbody").empty();
        var employees = result.extend.pageInfo.list;
        alert("成功执行!");
        $.each(employees,function(index,item) {
            //加入单元格
            var employeeId = $("<td></td>").append(item.managerId);
            var employeeName = $("<td></td>").append(item.name);
            // 为编辑按钮添加自定义 表现当前员工Id
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append("编辑");
            editBtn.attr("edit_id",item.managerId);
            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append("删除");
            deleteBtn.attr("delete_id",item.managerId);
            var btnTd = $("<td></td>").append(editBtn).append(deleteBtn);
            $("<tr></tr>").append(employeeId).append(employeeName).append(btnTd).appendTo("#employee_table tbody");
        });
    }
    //====================解析分页信息====================
    function build_page_info(result){
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"页,共"+result.extend.pageInfo.pages+"页,总共"+result.extend.pageInfo.total+"条");
        totalRecord = result.extend.pageInfo.pages;
        currentRecord = result.extend.pageInfo.pageNum;
    }

    //====================解析分页条数据====================
    function build_page_nav(result){
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPage = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        firstPage.click(function () {
            toPage(1);
        });
        var lastPage = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        lastPage.click(function () {
            toPage(result.extend.pageInfo.pages);
        })
        var prePage = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage==false) prePage.addClass("disabled");
        else prePage.click(function () {
            toPage(result.extend.pageInfo.pageNum-1);
        })
        var nextPage = $("<li></li>").append($("<a></a>").append("&raquo;"));
        if(result.extend.pageInfo.hasNextPage==false) nextPage.addClass("disabled");
        else nextPage.click(function () {
            toPage(result.extend.pageInfo.pageNum+1);
        });
        ul.append(firstPage).append(prePage);
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href", "#"));
            if(item==result.extend.pageInfo.pageNum) numLi.addClass("active");
            else numLi.click(function () {
                toPage(item);
            })
            ul.append(numLi);
        })
        ul.append(nextPage).append(lastPage);
        var nav = $("<nav></nav>").append(ul);
        <%--${"#page_nav_area"}.append(nav);--%>
        nav.appendTo("#page_nav_area");

    }


    //点击新增按钮 淡出模态框
    $("#employee_add_modal_btn").click(function(){
        //弹出模态框
        reset_form("#employeeAddModal form");
        $("#employeeAddModal").modal({
            backdrop:"static"
        })
    });

    function reset_form(ele) {
        $(ele)[0].reset();
    }

    // ================增加新员工点击保存事件================
    $("#employee_save_btn").click(function () {
        // 先校验信息
        var employeeName = $("#employeeName_add").val();
        var regName = /(^[a-zA-Z]{3,16}$)|(^[\u2E80-\u9FFF]{2,7}$)/;
        if(!regName.test(employeeName)) {
            $("#employeeName_add").parent().removeClass("has-success has-error");
            $("#employeeName_add").next("span").text("");
            $("#employeeName_add").parent().addClass("has-error");
            $("#employeeName_add").next().text("用户名可以是2-7位中文或3-16英文");
            return;
        }

        if($(this).attr("ajax-va")=="fail") return;
        // 将填写的表单数据 提交给Controller执行
        $.ajax({
            url:"${APP_PATH}/employee",
            type:"POST",
            data: $("#employeeAddModal form").serialize(),
            success:function(result){
                alert(result.message);
                if(result.code==100){
                    // 关闭模态框
                    $("#employeeAddModal").modal('hide');
                    //到最后一页 显示增加对象
                    toPage(totalRecord);
                }else{
                    console.log(result);
                    // 那个错 显示那个
                    if(underfined != result.extend.errorFields.name){
                        $("#employeeName_add").parent().removeClass("has-success has-error");
                        $("#employeeName_add").next("span").text("");
                        $("#employeeName_add").parent().addClass("has-error");
                        $("#employeeffName_add").next().text("用户名可以是2-7位中文或3-16英文");
                    }
                }

            }

        })
        })
// ================员工修改================
    // 配置修改模态
    $(document).on("click",".edit_btn",function () {
        alert("花Q");
        //查询员工信息 并显示员工信息
        $("#employee_update_btn").attr("edit_id",$(this).attr("edit_id"));
        $("#EmployeeUpdateModal").modal({
            backdrop:"static"
        })
    });

    $("#employee_update_btn").click(function(){
        //表单验证
        // 拿到数据
        // 使用正则表达式分割

        var employeeName = $("#employeeName_update").val();
        var regName = /(^[a-zA-Z]{3,16}$)|(^[\u2E80-\u9FFF]{2,7}$)/;
        if(!regName.test(employeeName)){
            // alert("用户名可以是2-5位中文或3-16英文数字");
            $("#employeeName_update").parent().removeClass("has-success has-error");
            $("#employeeName_update").next("span").text("");
            $("#employeeName_update").parent().addClass("has-error");
            $("#employeeName_update").next().text("用户名可以是2-7位中文或3-16英文数字");
            return false;
        }else{
            $("#employeeName_update").parent().removeClass("has-success has-error");
            $("#employeeName_update").next("span").text("");
            $("#employeeName_update").parent().addClass("has-success");
            $("#employeeName_update").next("span").text("");
        }

        // 发送Aajx请求
        //PUT方法 tomcat不会封装请求
        $.ajax({
            url : "${APP_PATH}/employee/" + $(this).attr("edit_id"),
            type:"PUT",
            data:$("#EmployeeUpdateModal form").serialize(),
            success:function (result) {
                // 回到本页面
                toPage(currentRecord);
                $("#EmployeeUpdateModal").modal('hide');


            }
        })
    })
    // 单个删除

    $(document).on("click",".delete_btn",function () {
        //1.弹出是否确认删除
        var name=$(this).parents("tr").find("td:eq(1)").text()
        if(confirm("确认删除["+name+"]吗?")){
            //确认 发送ajax请求
            $.ajax({
                url:"${APP_PATH}/employee/"+$(this).attr("delete_id"),
                type:"DELETE",
                success:function (result) {
                    console.log(result);
                    if(result.code==100){
                        toPage(currentRecord);
                        alert("成功删除");
                    }else{
                        alert("不能删除可能会造成死账");
                    }
                }
            })
        }
    })



</script>
</div>
</body>
</html>
