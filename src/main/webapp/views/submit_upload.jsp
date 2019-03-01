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
    <title>Submit:Upload</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/statics/css/local.css"/>
    <script language="JavaScript">
        function logout() {
            if (window.confirm('Are you sure to log out?') == true) {
                window.location.href = '/user/logout'
            }
        }

        function checkForm() {
            if(document.getElementById("uploadFile").value=="")
                return false;
            else
                return true;
        }
    </script>
    <style type="text/css">
        p {
            margin: 10px;
        }
    </style>
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
<h2>Submit:Upload</h2>
<div>
    <form method="post" enctype="multipart/form-data" onsubmit="checkForm()">
        <p><a style="color: red;font-size: small">${msg}</a></p>
        <p>Test Set: ${setName}</p>
        <p>System: ${sysName}</p>
        <p>Source Language: ${srcLangFull}</p>
        <p>Target Language: ${tgtLangFull}</p>
        <p>
            <label for="uploadFile">Choose File: </label>
            <input type="file" name="uploadFile" id="uploadFile">
        </p>
        <p>
            <label for="notes">Notes: </label>
            <textarea name="notes" id="notes" cols="30" rows="10"></textarea>
        </p>
        <input type="hidden" name="setId" value="${setId}">
        <input type="hidden" name="sysId" value="${sysId}">
        <input type="hidden" name="srcLang" value="${srcLang}">
        <input type="hidden" name="tgtLang" value="${tgtLang}">

        <input type="submit" value="Upload">
    </form>
</div>

</body>
</html>
