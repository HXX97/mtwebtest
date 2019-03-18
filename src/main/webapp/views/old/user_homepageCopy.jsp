<%--
  Created by IntelliJ IDEA.
  User: 10297
  Date: 2019/2/24
  Time: 13:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>HomePage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/statics/css/local.css"/>
    <script language="JavaScript">
        function logout() {
            if(window.confirm('Are you sure to log out?')==true){
                window.location.href ='/user/logout'
            }
        }
    </script>
</head>
<body>
<div>
    <ul>
        <li><a class="active" href="/user/status">主页</a></li>
        <li><a href="/system/new">添加系统</a></li>
        <li><a href="/system/user_list">系统列表</a></li>
        <li><a href="/test_sets/list">测试集</a> </li>
        <li><a href="/submit/frame">提交测试</a> </li>

        <li style="float: right"><a href="javascript:void(0)" onclick="logout()">登出</a>
        <li style="float:right"><a href="/user/edit/${username}">修改信息</a></li>
    </ul>
</div>
<div>
    <a id="msg" style="color: red;font-size: small" >${msg}</a>
</div>
<h2>Welcome to HIT MT Eval Web!</h2>
Hello ${username},look at what you can do:<br/>
<div>
    <p><a href="/user/edit/${username}">Edit Profile</a></p>
    <p><a href="/system/new">Create/Edit systems</a></p>
    <p><a href="">Submit a system run</a></p>
    <p><a href="/user/logout">Logout</a></p>
</div>



</body>
</html>
