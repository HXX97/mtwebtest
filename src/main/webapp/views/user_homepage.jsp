<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>User Homepage</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/bootstrap-select.min.css">
    <script src="${pageContext.request.contextPath}/statics/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap-select.min.js"></script>
    <script>
        function logout() {
            if (window.confirm('Are you sure to log out?') == true) {
                window.location.href = '/user/logout'
            }
        }

        function confirmDestroy() {
            return window.confirm('确定要删除吗？这将删除该系统的所有信息，包括提交记录');
        }


        function init() {
            var message = "${msg}";
            if (message != "" && message != "null") {
                document.getElementById("msg").classList.remove("hidden");
                var msgLevel = "${msgLevel}";
                if (msgLevel == 1) {
                    document.getElementById("msg").classList.add("alert-danger");
                } else {
                    document.getElementById("msg").classList.add("alert-success");
                }
            }
        }

        $(document).ready(function () {
            init();
        })

    </script>
</head>
<body>

<div class="container-fluid">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <nav class="navbar navbar-default navbar-inverse" role="navigation">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse"
                            data-target="#bs-example-navbar-collapse-1"><span
                            class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span
                            class="icon-bar"></span><span class="icon-bar"></span></button>
                    <a class="navbar-brand" href="#">CCMT2019 Evalution</a>
                </div>

                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li>
                            <a href="/">主页</a>
                        </li>
                        <li>
                            <a href="/board">积分榜</a>
                        </li>

                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">关于<strong class="caret"></strong></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="http://ccmt2019.jxnu.edu.cn">CCMT 2019</a>
                                </li>
                                <li class="divider">
                                </li>
                                <li>
                                    <a href="/about">关于本站</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">

                        <li id="userHome" class="active">
                            <a href="#">个人主页</a>
                        </li>

                        <li id="addSys">
                            <a href="/system/new">添加系统</a>
                        </li>

                        <li id="submit">
                            <a href="/submit/frame">提交测试</a>
                        </li>

                        <li id="history">
                            <a href="/submit/history">历史提交</a>
                        </li>

                        <li>
                            <a href="/test_sets/list">数据下载</a>
                        </li>


                        <li class="dropdown" id="userDrop">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">${username}<strong
                                    class="caret"></strong></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="/user/edit/${username}">个人资料</a>
                                </li>
                                <li>
                                    <a href="/user/changePWD">修改密码</a>
                                </li>
                                <li>
                                    <a href="javascript:logout()">登出</a>
                                </li>

                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>


    </div>
    <div class="row clearfix">
        <div class="col-md-12 column">

            <div class="alert alert-dismissable hidden" id="msg">
                <button type="button" class="close " data-dismiss="alert" aria-hidden="true">×</button>
                <h4>Notice</h4>${msg}
            </div>

        </div>
    </div>
    <div class="row clearfix">
        <div class="col-md-12 column">
            <fieldset>
                <legend>我的信息</legend>
                <p>用户名:${user.username}</p>
                <p>电子邮件:${user.email}</p>
                <p>单位:${user.affiliation}</p>
                <p>单位/个人网址:${user.web}</p>
            </fieldset>
        </div>
    </div>
    <div class="row clearfix">
        <div class="col-md-12 column">
            <fieldset>
                <legend>我的系统</legend>
                <table class="table table-hover table-striped" id="systemTable">
                    <thead>
                    <tr>
                        <th>Systemid</th>
                        <th>Name</th>
                        <th>Software</th>
                        <%--<th>Source language</th>
                        <th>Target language</th>--%>
                        <th>Citation</th>
                        <th>Website</th>
                        <th>Notes</th>
                        <th>Constraint System</th>
                        <th>Primary System</th>
                        <th>Owner</th>
                        <th colspan="3">Option</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${requestScope.systemList}" var="system">
                        <tr>
                            <td>${system.systemid}</td>
                            <td><a href="/system/detail/${system.systemid}">${system.name}</a></td>
                            <td>${system.software}</td>
                                <%--<td>${system.sourcelang}</td>
                                <td>${system.targetlang}</td>--%>
                            <td>${system.citation}</td>
                            <td>${system.website}</td>
                            <td>${system.notes}</td>
                            <td>${system.isConstraint}</td>
                            <td>${system.isPrimary}</td>
                            <td>${system.owner}</td>
                            <td><a href="/system/detail/${system.systemid}">Detail</a></td>
                            <td><a href="/system/edit/${system.systemid}">Edit</a></td>
                            <td><a href="/system/destroy/${system.systemid}"
                                   onclick="return confirmDestroy()">Destroy</a></td>
                        </tr>
                    </c:forEach>

                    </tbody>
                </table>

                <div align="right" style="margin-bottom: 20px">
                    <button class="btn btn-default" onclick="window.location.href='/system/new'">创建新系统</button>
                    <button class="btn btn-primary" onclick="window.location.href='/submit/frame'">提交测试</button>
                </div>

            </fieldset>
        </div>
    </div>
</div>

</body>
</html>
