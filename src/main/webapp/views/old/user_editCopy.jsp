<%--
  Created by IntelliJ IDEA.
  User: 10297
  Date: 2019/2/25
  Time: 10:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Profile</title>
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
        <li><a href="/user/status">主页</a></li>
        <li><a href="/system/new">添加系统</a></li>
        <li><a href="/system/user_list">系统列表</a></li>
        <li><a href="/test_sets/list">测试集</a> </li>
        <li><a href="/submit/frame">提交测试</a></li>

        <li style="float: right"><a href="javascript:void(0)" onclick="logout()">登出</a>
        <li style="float:right"><a class="active" href="/user/edit/${username}">修改信息</a></li>
    </ul>
</div>

<form method="post">
    <div align="center">
        <table class="gridtable" style="margin-top: 50px">
            <tr>
                <th>Username</th>
                <th>Email</th>
                <th>Affiliation</th>
                <th>Web</th>
            </tr>
            <tr>
                <td>${user.username}</td>
                <td><input type="text" name="email" value="${user.email}"
                           style="border:none" /></td>
                <td><input type="text" name="affiliation" value="${user.affiliation}"
                           style="border:none" /></td>
                <td><input type="text" name="web"
                           value="${user.web}" style="border:none" /></td>
            </tr>
        </table>
    </div>

    <div  align="right">
        <input type="submit" value="Save" style="marigin-top:10px;height:30px"/>
        <input type="button" name="Submit"
               onclick="javascript:history.back(-1);" value="Back"
               style="margin-right: 10%; margin-top: 10px; width: 60px; height: 30px">
    </div>
</form>

</body>
</html>
