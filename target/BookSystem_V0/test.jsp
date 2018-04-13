<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>JSTL fmt:formatNumber Tag - www.yiibai.com</title>
</head>
<body>
<h3>Number Format:</h3>
<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<fmt:formatDate  value="${now}" type="both" pattern="yyyy.MM.dd HH:mm:ss" /><br/>
</body>
</html>