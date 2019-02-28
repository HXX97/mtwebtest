<%--
  Created by IntelliJ IDEA.
  User: 10297
  Date: 2019/2/28
  Time: 0:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Test Set Lists</title>
    <title>System List</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/statics/css/local.css"/>
    <script language="JavaScript">
        function logout() {
            if (window.confirm('Are you sure to log out?') == true) {
                window.location.href = '/user/logout'
            }
        }
    </script>
</head>
<body>
<div>
    <ul>
        <li><a href="/user/status">主页</a></li>
        <li><a href="/system/new">添加系统</a></li>
        <li><a href="/system/user_list">系统列表</a></li>
        <li><a class="active" href="/test_sets/list">测试集</a> </li>
        <li><a href="/submit/frame">提交测试</a></li>

        <li style="float: right"><a href="javascript:void(0)" onclick="logout()">登出</a></li>
        <li style="float:right"><a href="/user/edit/${username}">修改信息</a></li>
    </ul>
</div>
<div>
    <div style="width: 90%">
        <h2>Test Set List</h2>
        <%--<a style="color: red;font-size: small">${msg}</a>--%>
    </div>

    <div align="center">

        <table class="gridtable" style="margin-top: 20px">

            <tr>
                <th>Name</th>
                <th>Origin</th>
                <th>Domain</th>
                <th>Related Corpora</th>
                <th>Citation</th>
                <th>Notes</th>
                <th>TestSetups</th>
            </tr>
            <c:forEach items="${requestScope.testSetList}" var="testSet">
                <tr>
                    <td>${testSet.name}</td>
                    <td>${testSet.origin}</td>
                    <td>${testSet.domain}</td>
                    <td>${testSet.related_corpora}</td>
                    <td>${testSet.citation}</td>
                    <td>${testSet.notes}</td>
                    <td>${testSet.setups}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>

</body>
</html>
