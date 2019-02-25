<%--
  Created by IntelliJ IDEA.
  User: 10297
  Date: 2019/2/23
  Time: 20:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>All Users</title>
</head>
<body>
<table>
    <tr style="width:200px;height:30px">
        <td>用户名</td>
        <td>电子邮箱</td>
        <td>单位</td>
        <td>网站</td>
    </tr>

    <c:forEach items="${requestScope.list}" var="item">
        <tr>
            <td>${item.username}</td>
            <td>${item.email}</td>
            <td>${item.affiliation}</td>
            <td>${item.web}</td>
        </tr>
    </c:forEach>

</table>

</body>
</html>
