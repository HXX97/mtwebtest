<%--
  Created by IntelliJ IDEA.
  User: 10297
  Date: 2019/2/28
  Time: 1:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Submit:Result</title>
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
        <li><a href="/test_sets/list">测试集</a></li>
        <li><a class="active" href="#">提交测试</a></li>


        <li style="float: right"><a href="javascript:void(0)" onclick="logout()">登出</a></li>
        <li style="float: right"><a href="/user/edit/${username}">修改信息</a></li>
    </ul>
</div>
</body>
</html>
