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
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
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
        var editBtn = $("<button></button>").addClass("btn btn-primary").append("编辑");
        var deleteBtn = $("<button></button>").addClass("btn btn-danger").append("删除");
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
    // <nav aria-label="Page navigation">
    //     <ul class="pagination">
    //     <li>
    //     <a href="#" aria-label="Previous">
    //     <span aria-hidden="true">&laquo;</span>
    // </a>
    // </li>
    // <li><a href="#">1</a></li>
    // <li><a href="#">2</a></li>
    // <li><a href="#">3</a></li>
    // <li><a href="#">4</a></li>
    // <li><a href="#">5</a></li>
    // <li>
    // <a href="#" aria-label="Next">
    //     <span aria-hidden="true">&raquo;</span>
    // </a>
    // </li>
    // </ul>
    // </nav>
</script>
</body>
</html>
