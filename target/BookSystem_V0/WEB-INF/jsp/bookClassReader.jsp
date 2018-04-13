<%--
  Created by IntelliJ IDEA.
  User: 12dong
  Date: 2018/4/11
  Time: 下午10:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
    <title>书目目录</title>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script src="${APP_PATH}/static/js/jquery-1.11.0.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="row">
        <div class="col-md-12">
            <h1 id="readerId">${readerId}</h1>
        </div>
    </div>
    <div class="row">
    </div>
    <div class="row">
        <div class="col-md-3">
            <input type="text" class="form-control" id="bookName_query" placeholder="书目名" aria-describedby="basic-addon1">
        </div>
        <div class="col-md-3">
            <input type="text" class="form-control" id="authorName_query" placeholder="作者名" aria-describedby="basic-addon1">
        </div>
        <div class="col-md-3">
            <input type="text" class="form-control" id="publishCompanyName_query" placeholder="出版社名" aria-describedby="basic-addon1">
        </div>
        <div class="col-md-3">
            <button class="btn btn-primary" id="bookClass_find_modal_btn" >查询</button>
        </div>

    </div>
    <%--显示 表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="bookClass_table">
                <thead>
                <tr>
                    <td>ISBN</td>
                    <td>书目名</td>
                    <td>作者</td>
                    <td>出版社</td>
                    <td>出版时间</td>
                    <td>数量</td>
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

    <script type="text/javascript">
        var totalRecord,currentRecord;
        var readIder = document.getElementById("readerId").innerText

        $(function() {
            toPage(1);
        })

        // =============到达某一页面=============
        function toPage(num) {
            $.ajax({
                url:"${APP_PATH}/bookClass",
                data:"pn="+num,
                type:"GET",
                success:function (result) {
                    alert("成功执行");
                    console.log(result);
                    build_book_table(result);
                    build_page_nav(result);
                    build_page_info(result);
                }
            })
        }



        // =============构造页面表单=============
        function build_book_table(result) {
            $("#bookClass_table tbody").empty();
            var bookClasses = result.extend.pageInfo.list;
            $.each(bookClasses,function(index,item) {
                //加入单元格
                var isbn = $("<td></td>").append(item.isbn);
                var bookName = $("<td></td>").append(item.bookName);
                var authorName = $("<td></td>").append(item.author);
                var publishCompanyName = $("<td></td>").append(item.publishCompany);
                var publishDate = $("<td></td>").append(item.publishDate);
                var bookNum = $("<td></td>").append(item.bookNum);
                // 为编辑按钮添加自定义 表现当前员工Id
                var moreInformationBtn = $("<button></button>").addClass("btn btn-primary btn-sm Book_btn").append("详细");
                moreInformationBtn.attr("isbn",item.isbn);
                var btnTd = $("<td></td>").append(moreInformationBtn);
                $("<tr></tr>").append(isbn).append(bookName).append(authorName).append(publishCompanyName).append(publishDate).append(bookNum).append(btnTd).appendTo("#bookClass_table tbody");
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
        function build_page_nav(result) {
            $("#page_nav_area").empty();
            var ul = $("<ul></ul>").addClass("pagination");
            var firstPage = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
            firstPage.click(function () {
                toPage(1);
            });
            var lastPage = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
            lastPage.click(function () {
                toPage(result.extend.pageInfo.pages);
            })
            var prePage = $("<li></li>").append($("<a></a>").append("&laquo;"));
            if (result.extend.pageInfo.hasPreviousPage == false) prePage.addClass("disabled");
            else prePage.click(function () {
                toPage(result.extend.pageInfo.pageNum - 1);
            })
            var nextPage = $("<li></li>").append($("<a></a>").append("&raquo;"));
            if (result.extend.pageInfo.hasNextPage == false) nextPage.addClass("disabled");
            else nextPage.click(function () {
                toPage(result.extend.pageInfo.pageNum + 1);
            });
            ul.append(firstPage).append(prePage);
            $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
                var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href", "#"));
                if (item == result.extend.pageInfo.pageNum) numLi.addClass("active");
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

        $("#bookClass_find_modal_btn").click(function () {
            $.ajax({
                url:"${APP_PATH}/bookClassQuery",
                dataType:"json",
                contentType : "application/json; charset=utf-8",
                data:JSON.stringify({
                    bookName:$("#bookName_query").val(),
                    authorName:$("#authorName_query").val(),
                    publishCompanyName:$("#publishCompanyName_query").val(),
                    }),
                type:"POST",
                success:function(result){
                    alert(result);
                    console.log(result);
                    build_book_table(result);
                    build_page_nav(result);
                    build_page_info(result);
                }
        })
        })


        // 页面转向用事件
        $(document).on("click",".Book_btn",function () {
            window.location.href='${APP_PATH}/ExBook/'+$(this).attr("ISBN");
        });

    </script>
</body>
</html>
