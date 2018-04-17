<%--
  Created by IntelliJ IDEA.
  User: 12dong
  Date: 2018/4/12
  Time: 下午8:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>书单列表</title>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
          rel="stylesheet">
    <script src="${APP_PATH}/static/js/jquery-1.11.0.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<div class="row">
    <div class="col-md-12">
        <h1 id="ISBN">管理员 ${ISBN}</h1>
    </div>
</div>

<%--书籍修改模态框--%>
<div class="modal fade" id="bookUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">书籍修改</h4>
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

<%--显示 表格数据--%>
<div class="row">
    <div class="col-md-12">
        <table class="table table-hover" id="Book_table">
            <thead>
            <tr>
                <td>书籍Id</td>
                <td>地点</td>
                <td>状态</td>
                <td>办理事务</td>
                <td>读者Id</td>
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

    var ISBN = '${ISBN}';
    var totalRecord,currentRecord;

    $(function() {
        toPage(1);
    })

    // =============到达某一页面=============
    function toPage(num) {
        $.ajax({
            url:"${APP_PATH}/ExBookQuery/"+ISBN,
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
        $("#Book_table tbody").empty();
        var Books = result.extend.pageInfo.list;
        $.each(Books,function(index,item) {
            //加入单元格
            var bookId = $("<td></td>").append(item.bookId);
            var location = $("<td></td>").append(item.location);
            var status = $("<td></td>").append(item.status);
            var managerId = $("<td></td>").append(item.managerId);
            var readerId = $("<td></td>").append(item.readerId);
            // 为编辑按钮添加自定义 表现当前员工Id
            var updateBtn = $("<button></button>").addClass("btn btn-primary btn-sm update_btn").append("修改");
            updateBtn.attr("bookId",item.bookId);
            var deleteBtn = $("<button></button>").addClass("btn btn-primary btn-sm delete_btn").append("删除");
            deleteBtn.attr("bookId",item.bookId);
            var btnTd = $("<td></td>").append(updateBtn).append(deleteBtn);
            $("<tr></tr>").append(bookId).append(location).append(status).append(managerId).append(readerId).append(btnTd).appendTo("#Book_table tbody");
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
    $(document).con("clicj",".update_btn",function(){

    })
    $(document).on("click",".delete_btn",function () {
        //1.弹出是否确认删除
        var bookId= $(this).attr("bookId");
        if(confirm("确认删除["+bookId+"]吗?")){
            //确认 发送ajax请求
            $.ajax({
                url:"${APP_PATH}/ExBookManager",
                dataType:"json",
                contentType : "application/json; charset=utf-8",
                data:JSON.stringify({
                    bookId:$(this).attr("bookid"),
                    ISBN:ISBN,
                }),
                type:"DELETE",
                success:function (result) {
                    console.log(result);
                    alert("删除成功");
                    if(result.extend.bookClass==false){
                        window.location.href='${APP_PATH}/bookClassManager'
                    }else{
                        toPage(currentRecord);
                    }
                }
            })
        }
    })



</script>

</body>
</html>
