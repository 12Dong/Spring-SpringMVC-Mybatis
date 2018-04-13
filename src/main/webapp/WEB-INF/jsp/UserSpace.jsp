<%--
  Created by IntelliJ IDEA.
  User: 12dong
  Date: 2018/4/13
  Time: 下午4:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <title>用户空间</title>
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

        <%--显示 表格数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="readerQuery_table">
                    <thead>
                    <tr>
                        <td>BookId</td>
                        <td>状态</td>
                        <td>书名</td>
                        <td>操作</td>
                    </tr>
                    </thead>
                    <tbody >
                    </tbody>
                </table>
            </div>
        </div>


        <script type="text/javascript">
            var totalRecord,currentRecord;
            var readerId = document.getElementById("readerId").innerText;

            $(function() {
                toPage(1);
            })

            // =============到达某一页面=============
            function toPage(num) {
                $.ajax({
                    url:"${APP_PATH}/readerQueryRendBook",
                    data: "readerId="+readerId,
                    type:"GET",
                    success:function (result) {
                        alert("成功执行");
                        console.log(result);
                        build_book_table(result);
                    }
                })
            }



            // =============构造页面表单=============
            function build_book_table(result) {
                $("#readerQuery_table tbody").empty();
                var books = result.extend.list;
                $.each(books,function(index,item) {
                    //加入单元格
                    var bookId = $("<td></td>").append(item.bookId);
                    var bookName = $("<td></td>").append(item.bookClass.bookName);
                    var status = $("<td></td>").append(item.status);
                    // 为编辑按钮添加自定义 表现当前员工Id
                    var returnBtn = $("<button></button>").addClass("btn btn-primary btn-sm return_btn").append("还书");
                    returnBtn.attr("bookId",item.bookId);
                    var btnTd = $("<td></td>").append(returnBtn);
                    $("<tr></tr>").append(bookId).append(bookName).append(status).append(btnTd).appendTo("#readerQuery_table tbody");
                });
            }
        </script>
</body>
</html>
