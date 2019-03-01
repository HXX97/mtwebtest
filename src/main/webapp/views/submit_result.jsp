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
<h2>Submit:Result</h2>
<div>
    <a style="color: red;font-size: small">${msg}</a>
</div>
<div align="center">
    <table class="gridtable" style="margin-top: 20px">
        <tr>
            <th>Time</th>
            <th>System</th>
            <th>TestSet</th>
            <th>Run Notes</th>
            <th>Source language</th>
            <th>Target language</th>
            <th>Uploaded File</th>
            <th>BLEU</th>
            <th>IGNORE BLEU</th>
            <th>TER</th>
            <th>zz BEER2.0</th>
            <th>zzz Character</th>
        </tr>
        <tr>
            <td>${submission.time}</td>
            <td><a href="/system/detail/${submission.systemid}">${submission.systemName}</a></td>
            <td>${submission.testset}</td>
            <td>${submission.notes}</td>
            <td>${submission.srclang}</td>
            <td>${submission.tgtlang}</td>
            <td><a href="/download/uploads/${submission.file}">${submission.file}</a></td>
            <td>${submission.BLEU}</td>
            <td>${submission.IGNORE_BLEU}</td>
            <td>${submission.TER}</td>
            <td>${submission.BEER}</td>
            <td>${submission.charac_ter}</td>
        </tr>
    </table>
</div>
</body>
</html>
