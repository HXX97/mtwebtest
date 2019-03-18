<%--
  Created by IntelliJ IDEA.
  User: 10297
  Date: 2019/2/25
  Time: 22:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>System List</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/statics/css/local.css"/>
    <script language="JavaScript">
        function logout() {
            if (window.confirm('Are you sure to log out?') == true) {
                window.location.href = '/user/logout'
            }
        }

        function redirectCreate() {
            window.location.href = '/system/new'
        }

        function getBack(){
            window.location.href='/user/status'
        }

    </script>
</head>
<body>
<div>
    <ul>
        <li><a href="/user/status">主页</a></li>
        <li><a href="/system/new">添加系统</a></li>
        <li><a class="active" href="/system/user_list">系统列表</a></li>
        <li><a href="/test_sets/list">测试集</a> </li>
        <li><a href="/submit/frame">提交测试</a></li>

        <li style="float: right"><a href="javascript:void(0)" onclick="logout()">登出</a></li>
        <li style="float:right"><a href="/user/edit/${username}">修改信息</a></li>
    </ul>
</div>
<div>
    <div style="width: 90%">
        <h2 >System List</h2>
        <a style="color: red;font-size: small" >${msg}</a>
    </div>

    <div align="center">

        <table class="gridtable" style="margin-top: 20px">

            <tr>
                <th>Systemid</th>
                <th>Name</th>
                <th>Software</th>
                <th>Source language</th>
                <th>Target language</th>
                <th>Citation</th>
                <th>Website</th>
                <th>Notes</th>
                <th>Constraint System</th>
                <th>Primary System</th>
                <th>Owner</th>
                <th colspan="3">Option</th>
            </tr>
            <c:forEach items="${requestScope.systemList}" var="system">
                <tr>
                    <td>${system.systemid}</td>
                    <td><a href="/system/detail/${system.systemid}">${system.name}</a></td>
                    <td>${system.software}</td>
                    <td>${system.sourcelang}</td>
                    <td>${system.targetlang}</td>
                    <td>${system.citation}</td>
                    <td>${system.website}</td>
                    <td>${system.notes}</td>
                    <td>${system.isConstraint}</td>
                    <td>${system.isPrimary}</td>
                    <td>${system.owner}</td>
                    <td><a href="/system/detail/${system.systemid}">Detail</a></td>
                    <td><a href="/system/edit/${system.systemid}">Edit</a></td>
                    <td><a href="/system/destroy/${system.systemid}">Destory</a></td>
                </tr>
            </c:forEach>
        </table>
        <div style="margin-top: 10px;width: 80%" align="right">

            <%--<input type="button" style="margin-right: 10px;width: 100px" onclick="redirectCreate()" value="Create"/>
            <input type="button" style="width: 100px" onclick="getBack()" value="Back"/>--%>
            <a href="/system/new" style="margin-right: 10px"><button >Create</button></a>
            <a href="/user/status"><button>Back</button></a>
        </div>
    </div>
</div>


</body>
</html>
