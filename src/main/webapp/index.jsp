<%--
  Created by IntelliJ IDEA.
  User: 12dong
  Date: 2018/4/6
  Time: 上午11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String APP_PATH = request.getContextPath(); %>
<html>
<head>
    <title>Json书籍目录</title>
    <%--web路径问题 不以斜杠 找资源 为当前路径 为基准--%>
    <%--以斜线开始的相对路径找资源 不以当前资源路径为标准 而是以服务器路径为基准（localhost:3306） 需要加上项目名--%>
    <!-- Bootstrap -->
    <link
            href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="${APP_PATH}/static/js/jquery-1.11.0.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script
            src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%--书籍添加模态框--%>
<div class="modal fade" id="bookAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
                        <label for="bookName_add"  class="col-sm-2 control-label">图书名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="name" id="bookName_add" placeholder="bookName">
                            <span></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="bookNum_add"  class="col-sm-2 control-label">图书数量</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="number" id="bookNum_add" placeholder="bookNum">
                            <span></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="bookDetail_add"  class="col-sm-2 control-label">图书信息</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="detail" id="bookDetail_add" placeholder="bookDetail">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">图片Id</label>
                        <%--图片Id--%>
                        <select class="form-control" name="picId" id="Pic_select">

                        </select>
                    </div>





                    <%--<div class="form-group">--%>
                        <%--<div class="col-sm-offset-2 col-sm-10">--%>
                            <%--<button type="submit" class="btn btn-default">Sign in</button>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="book_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<%--======================================书籍修改模态框======================================--%>
<div class="modal fade" id="bookUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myUpdateLabel">图书添加</h4>
            </div>
            <div class="modal-body">
                <%--=====================表单=====================    --%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="bookName_add"  class="col-sm-2 control-label">图书名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="name" id="bookName_update" placeholder="bookName">
                            <span></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="bookNum_add"  class="col-sm-2 control-label">图书数量</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="number" id="bookNum_update" placeholder="bookNum">
                            <span></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="bookDetail_add"  class="col-sm-2 control-label">图书信息</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="detail" id="bookDetail_update" placeholder="bookDetail">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">图片Id</label>
                        <%--图片Id--%>
                        <select class="form-control" name="picId" id="Pic_select">

                        </select>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="book_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>



<%--=============================================================--%>
<%--显示页面 使用bootstrap--%>
<div class="container">
    <%--标题行--%>
    <div class="row">
        <div class="col-md-12">
            <h1>李老板的奶酪和面包</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="book_add_modal_btn">新增</button>
            <button class="btn btn-danger" >删除</button>
        </div>
    </div>
    <%--显示 表格数据--%>

        <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="book_table">
                <thead>
                <tr>
                    <td>Id</td>
                    <td>名字</td>
                    <td>数量</td>
                    <td>描述</td>
                    <td>封面Id</td>
                    <td>封面</td>
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
    // 页面加载完成之后 发送Ajax请求 请求分页数据
    $(function() {
        toPage(1);
    })

    function toPage(num){
        $.ajax({
            url:"${APP_PATH}/ReturnJson",
            data:"pn="+num,
            type:"GET",
            //result服务器相应给浏览器的数据
            success:function (result) {
                console.log(result);
                // 请求成功做两件事
                // 解析json 并显示数据

                build_book_table(result);
                build_page_info(result);
                build_page_nav(result);

                // 解析json 并显示分页信息
            },
            fail:function (result) {
                alert("失败");
            }
        });
    }

    function build_book_table(result) {
        $("#book_table tbody").empty();
        var books = result.extend.pageInfo.list;
        alert("成功执行!");
        $.each(books,function(index,item) {
        //加入单元格
        var bookId = $("<td></td>").append(item.bookId);
        var name = $("<td></td>").append(item.name);
        var number = $("<td></td>").append(item.number);
        var detail = $("<td></td>").append(item.detail);
        var picId = $("<td></td>").append(item.picId);
        var pic = $("<td></td>").append(item.pic.pic);
        // 为编辑按钮添加自定义 表现当前员工Id
        var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append("编辑");
        editBtn.attr("edit_id",item.bookId);
        var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append("删除");
        deleteBtn.attr("delete_id",item.bookId);
        var btnTd = $("<td></td>").append(editBtn).append(deleteBtn);
        // <button class="btn btn-primary">新增</button>
        //         <button class="btn btn-danger">删除</button>
        //append 方法 返回原来的元素 所以能使用链式操作
        $("<tr></tr>").append(bookId).append(name).append(number).append(detail).append(picId)
        .append(pic).append(btnTd).appendTo("#book_table tbody");
        });
    }
    //解析分页信息
    function build_page_info(result){
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"页,共"+result.extend.pageInfo.pages+"页,总共"+result.extend.pageInfo.total+"条");
        totalRecord = result.extend.pageInfo.pages;
        currentRecord = result.extend.pageNum;
    }
    //解析分页条数据
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
        $("#book_add_modal_btn").click(function(){
            // 刷新表单 数据与样式
            reset_form("#bookAddModal form");
            //发出ajax请求 查处PicId信息 显示在下拉列表中
            getPicId("#Pic_select");

            //弹出模态框
            $("#bookAddModal").modal({
                backdrop:"static"
            })
    });
    function reset_form(ele){
        //清空数据
        $(ele)[0].reset();
        //清空样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find("span").text("");

    }
    function getPicId(ele) {
        $.ajax({
            url:"${APP_PATH}/Pic",
            type:"GET",
            success:function (result) {
                console.log(result);
                $(ele).empty();
                $.each(result.extend.Pic,function(index,item){
                    var option = $("<option></option>").append(item.pic).attr("value",item.picId);
                    option.appendTo(ele);
                    //option.appendTo("#Pic_select");
                })
            }
        })

    }

    function validate_add_form() {
        // 拿到数据
        // 使用正则表达式分割

        var bookName = $("#bookName_add").val();
        var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,7}$)/;
        if(!regName.test(bookName)){
            // alert("用户名可以是2-5位中文或3-16英文数字");
            $("#bookName_add").parent().removeClass("has-success has-error");
            $("#bookName_add").next("span").text("");
            $("#bookName_add").parent().addClass("has-error");
            $("#bookName_add").next().text("用户名可以是2-5位中文或3-16英文数字");
            return false;
        }else{
            $("#bookName_add").parent().removeClass("has-success has-error");
            $("#bookName_add").next("span").text("");
            $("#bookName_add").parent().addClass("has-success");
            $("#bookName_add").next("span").text("");
        }
        var bookNum = $("#bookNum_add").val();
        regName = /^[0-9]*$/;
        if(!regName.test(bookNum)){
            // alert("数量必须为数字");
            $("#bookNum_add").parent().removeClass("has-success has-error");
            $("#bookNum_add").next("span").text("");
            $("#bookNum_add").parent().addClass("has-error");
            $("#bookNum_add").next("span").text("数量必须为数字");
            return false;
        }else{
            $("#bookNum_add").parent().removeClass("has-success has-error");
            $("#bookNum_add").next("span").text("");
            $("#bookNum_add").parent().addClass("has-success");
            $("#bookNum_add").next("span").text("");
        }
        return true;

    }
    $("#book_save_btn").click(function () {
        // 先校验信息
        if(!validate_add_form()){
            return false;
        }

        if($(this).attr("ajax-va")=="fail") return;
        // 将填写的表单数据 提交给Controller执行
        $.ajax({
            url:"${APP_PATH}/book",
            type:"POST",
            data: $("#bookAddModal form").serialize(),
            success:function(result){
                alert(result.message);
                if(result.code==100){
                    // 关闭模态框
                    $("#bookAddModal").modal('hide');
                    //到最后一页 显示增加对象
                    toPage(totalRecord);
                }else{
                    console.log(result);
                    // 那个错 显示那个
                    if(underfined != result.extend.errorFields.name){
                        $("#bookName_add").parent().removeClass("has-success has-error");
                        $("#bookName_add").next("span").text("");
                        $("#bookName_add").parent().addClass("has-error");
                        $("#bookName_add").next().text("用户名可以是2-5位中文或3-16英文数字");
                    }
                }

            }

    })
    })


        $("#bookName_add").change(function () {
            // 发送ajax校验是否可用
            var bookName =this.value;
            $.ajax({
                url:"${APP_PATH}/checkBookName",
                data:"name="+bookName,
                type:"POST",
                success:function(result){
                    alert(result.extend);
                    if(result.code==100){
                        $("#bookName_add").parent().removeClass("has-success has-error");
                        $("#bookName_add").next("span").text("");
                        $("#bookName_add").parent().addClass("has-success");
                        $("#bookName_add").next("span").text("用户名可用");
                        $("#book_save_btn").attr("ajax-va","success");
                    }else{
                        $("#bookName_add").parent().removeClass("has-success has-error");
                        $("#bookName_add").next("span").text("");
                        $("#bookName_add").parent().addClass("has-error");
                        $("#bookName_add").next().text(result.extend.va_message);
                        $("#book_save_btn").attr("ajax-va","fail");

                    }
                }
            })
        })

        // 配置修改模态
        $(document).on("click",".edit_btn",function () {
            // alert("花Q");
            //查询员工信息 并显示员工信息
            // 查处部门信息 并显示 部门列表
            getPicId("#bookUpdateModal select");
            getBook($(this).attr("edit_id"));
            $("#book_update_btn").attr("edit_id",$(this).attr("edit_id"));
            $("#bookUpdateModal").modal({
                backdrop:"static"
            })
        });

    function getBook(id){
        $.ajax({
            url:"${APP_PATH}/book/"+id,
            type:"GET",
            success:function(result){
                console.log(result);
                var book = result.extend.book;
                $("#bookName_update").val(book.name);
                $("#bookNum_update").val(book.number);
                $("#bookDetail_update").val(book.detail);
                $("#bookUpdateModal select").val([parseInt(book.picId)]);
            }
        })
    }

    // 点击更新按钮
        $("#book_update_btn").click(function(){
            //表单验证
            // 拿到数据
            // 使用正则表达式分割

            var bookName = $("#bookName_update").val();
            var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,7}$)/;
            if(!regName.test(bookName)){
                // alert("用户名可以是2-5位中文或3-16英文数字");
                $("#bookName_update").parent().removeClass("has-success has-error");
                $("#bookName_update").next("span").text("");
                $("#bookName_update").parent().addClass("has-error");
                $("#bookName_update").next().text("用户名可以是2-5位中文或3-16英文数字");
                return false;
            }else{
                $("#bookName_update").parent().removeClass("has-success has-error");
                $("#bookName_update").next("span").text("");
                $("#bookName_update").parent().addClass("has-success");
                $("#bookName_update").next("span").text("");
            }
            var bookNum = $("#bookNum_update").val();
            regName = /^[0-9]*$/;
            if(!regName.test(bookNum)){
                // alert("数量必须为数字");
                $("#bookNum_update").parent().removeClass("has-success has-error");
                $("#bookNum_update").next("span").text("");
                $("#bookNum_update").parent().addClass("has-error");
                $("#bookNum_update").next("span").text("数量必须为数字");
                return false;
            }else{
                $("#bookNum_update").parent().removeClass("has-success has-error");
                $("#bookNum_update").next("span").text("");
                $("#bookNum_update").parent().addClass("has-success");
                $("#bookNum_update").next("span").text("");
            }

            // 发送Aajx请求
            //PUT方法 tomcat不会封装请求
            $.ajax({
                url : "${APP_PATH}/book/" + $(this).attr("edit_id"),
                type:"PUT",
                data:$("#bookUpdateModal form").serialize(),
                success:function (result) {
                    $("#bookUpdateModal").modal('hide');
                    alert(result.message);
                    // 回到本页面
                    toPage(currentRecord);
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
                    url:"${APP_PATH}/book/"+$(this).attr("delete_id"),
                    type:"DELETE",
                    success:function (result) {
                        console.log(result);
                        alert(result.message);
                        toPage(currentRecord);
                    }
                })
            }
        })
</script>
</body>
</html>
