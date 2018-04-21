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
    <title>书目管理目录</title>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
          rel="stylesheet">
    <script src="${APP_PATH}/static/js/jquery-1.11.0.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<%--书目添加模态框--%>
<div class="modal fade" id="bookClassAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">书目添加</h4>
            </div>
            <div class="modal-body">
                <%--=====================表单=====================    --%>
                <form class="form-horizontal">

                    <div class="form-group">
                        <label for="ISBN_add"  class="col-sm-2 control-label">ISBN</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="ISBN" id="ISBN_add" placeholder="ISBN">
                            <span></span>
                        </div>
                    </div>

                    <div class="hidden" id="exInformation">
                        <div class="form-group">
                            <label for="bookName_add"  class="col-sm-2 control-label">书名</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="name" id="bookName_add" placeholder="书名">
                                <span></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="authorName_add"  class="col-sm-2 control-label">作者名</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="author" id="authorName_add" placeholder="作者名">
                                <span></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="publishCompanyName_add"  class="col-sm-2 control-label">出版社名</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="publishCompanyName" id="publishCompanyName_add" placeholder="出版社名">
                                <span></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="publishDate_add"  class="col-sm-2 control-label">出版时间</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="publishDate" id="publishDate_add" placeholder="出版时间">
                                <span id="tip">tip:出版时间 形如 yyyy-MM-dd</span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="bookId_add"  class="col-sm-2 control-label">书籍Id</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="bookId" id="bookId_add" placeholder="书籍Id">
                                <span id="location-tip">形如C831</span>
                                <span id="bookId-exinformation"></span>
                            </div>
                        </div>
                    </div>

                    <div>
                        <div class="form-group">
                            <label for="location_add"  class="col-sm-2 control-label">存放位置</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="location" id="location_add" placeholder="存放位置">
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="bookClass_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<%--=========================================================================================================--%>

<div class="row">
    <div class="col-md-12">
        <h1 id="readerId">${readerId}</h1>
    </div>

</div>

<div class="row">
    <div class="col-md-4 col-md-offset-8">
        <button class="btn btn-primary" id="bookClass_add__btn" >新增</button>
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
        window.location.href='${APP_PATH}/ExBookManager/'+$(this).attr("ISBN");
    });


    // ===============================新增点击 模态框弹出事件===============================
        $("#bookClass_add__btn").click(function () {
            reset_form("#bookClassAddModal form");
            $("#bookClassAddModal").modal({
                backdrop:"static"
            })
        });

    function reset_form(ele) {
        $(ele)[0].reset();
    }


    $("#ISBN_add").change(function(){
        var ISBN = $("#ISBN_add").val();
        $.ajax({
            url:"${APP_PATH}/checkBookClass",
            data:"ISBN="+ISBN,
            success:function (result) {
                if(result.extend.exit==true){
                    $("#exInformation").removeClass("hidden");
                    $("#exInformation").addClass("hidden");
                }else{
                    $("#exInformation").removeClass("hidden");
                }
            }
        })


    })
    $("#bookClass_save_btn").click(function () {
        if($("#exInformation").hasClass("hidden")){
                var ISBN = $("#ISBN_add").val();
                var location = $("#location_add").val();
                $.ajax({
                    url:"${APP_PATH}/AddBook",
                    type:"POST",
                    dataType:"json",
                    contentType : "application/json; charset=utf-8",
                    data:JSON.stringify({
                        ISBN:$("#ISBN_add").val(),
                        bookName:$("#bookName_add").val(),
                        authorName:$("#authorName_add").val(),
                        publishCompanyName:$("#publishCompanyName_add").val(),
                        publishDate:$("#publishDate_add").val(),
                    }),
                    success:function (result) {
                        console.log(result);
                        $("#bookClassAddModal").modal('hide');

                    }
                })
        }
        else{
            var ISBN = $("#ISBN_add").val();
            var bookName = $("#bookName_add").val();
            var authorName = $("#authorName_add").val();
            var publishCompanyName = $("#publishCompanyName_add").val();
            var publishDate = $("#publishDate_add").val();
            var bookId = $("#bookId_add").val();
            var location = $("#location_add").val();
            var regName =/^[0-9]{4}[-]{1}[0-9]{1,2}[-]{1}[0-9]{1,2}$/;
            if(!regName.test(publishDate)){
                $("#publishDate_add").parent().removeClass("has-success has-error");
                $("#publishDate_add").next("span").text("");
                $("#publishDate_add").parent().addClass("has-error");
                $("#publishDate_add").next("span").text("日期格式应形如 yyyy-MM-dd");
                return false;
            }else{
                $("#publishDate_add").parent().removeClass("has-success has-error");
                $("#publishDate_add").next("span").text("");
                var str = publishDate.split("-");
                var d = new Date();
                var year = d.getFullYear();
                var month = d.getMonth();
                var day = d.getDate();
                if(year<str[0]){
                    $("#publishDate_add").parent().removeClass("has-success has-error");
                    $("#publishDate_add").next("span").text("");
                    $("#publishDate_add").parent().addClass("has-error");
                    $("#publishDate_add").next("span").text("时间错误-年过界");
                    return false;
                }
                if(month+1<str[1]){
                    $("#publishDate_add").parent().removeClass("has-success has-error");
                    $("#publishDate_add").next("span").text("");
                    $("#publishDate_add").parent().addClass("has-error");
                    $("#publishDate_add").next("span").text("时间错误-月过界");
                    return false;
                }
                if(day<str[2]){
                    $("#publishDate_add").parent().removeClass("has-success has-error");
                    $("#publishDate_add").next("span").text("");
                    $("#publishDate_add").parent().addClass("has-error");
                    $("#publishDate_add").next("span").text("时间错误-日过界");
                    return false;
                }
            }
            alert($("#authorName_add").val());
            $.ajax({
                url:"${APP_PATH}/bookClass",
                type:"POST",
                dataType:"json",
                contentType : "application/json; charset=utf-8",
                data:JSON.stringify({
                    ISBN:$("#ISBN_add").val(),
                    bookName:$("#bookName_add").val(),
                    authorName:$("#authorName_add").val(),
                    publishCompanyName:$("#publishCompanyName_add").val(),
                    publishDate:$("#publishDate_add").val(),
                    bookId:bookId,
                    location:location,
                }),
                success:function (result) {
                    console.log(result);
                    toPage(currentRecord);
                    $("#bookClassAddModal").modal('hide');
                }
            })
        }
    })


</script>
</body>
</html>
