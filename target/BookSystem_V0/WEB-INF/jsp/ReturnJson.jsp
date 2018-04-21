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
            <table class="table table-hover" >
                <tr>
                    <td>Id</td>
                    <td>名字</td>
                    <td>数量</td>
                    <td>描述</td>
                    <td>封面Id</td>
                    <td>封面</td>
                    <td>操作</td>
                </tr>

                <c:forEach items="${pageInfo.list}" var="book">

                    <tr>
                        <td>${book.bookId}</td>
                        <td>${book.name}</td>
                        <td>${book.number}</td>
                        <td>${book.detail}</td>
                        <td>${book.picId}</td>
                        <td>${book.pic.pic}</td>
                        <td>
                            <button class="btn-danger btn-sm">编辑</button>
                            <button class="btn-primary btn-sm">删除</button>
                        </td>
                    </tr>

                </c:forEach>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6">
            当前第${pageInfo.pageNum}页,共${pageInfo.pages}页,总共${pageInfo.total}条
        </div>
        <%--分页条信息--%>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="${APP_PATH}/Newlist?pn=1">首页</a></li>

                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="${APP_PATH}/Newlist?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>



                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                        <c:if test="${page_Num==pageInfo.pageNum}">
                            <li class="active"><a href="#">${page_Num}</a></li>
                        </c:if>
                        <c:if test="${page_Num!=pageInfo.pageNum}">
                            <li><a href="${APP_PATH}/Newlist?pn=${page_Num}">${page_Num}</a></li>
                        </c:if>

                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="${APP_PATH}/Newlist?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li><a href="${APP_PATH}/Newlist?pn=${pageInfo.pages}">末页</a></li>

                </ul>
            </nav>
        </div>
    </div>

</div>
</body>
</html>
