<%--
  Created by IntelliJ IDEA.
  User: 10297
  Date: 2019/2/25
  Time: 16:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/bootstrap-select.min.css">
    <script src="${pageContext.request.contextPath}/statics/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap-select.min.js"></script>
    <script language="JavaScript">
        function logout() {
            if (window.confirm('Are you sure to log out?') == true) {
                window.location.href = '${pageContext.request.contextPath}/user/logout'
            }
        }


        $(document).ready(function () {
            setSelectNCheck();
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
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/">通用机器翻译测评平台</a>
                </div>

                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li>
                            <a href="${pageContext.request.contextPath}/">主页</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/board">排行榜</a>
                        </li>

                        <li>
                            <a href="${pageContext.request.contextPath}/about">使用说明</a>
                        </li>

                    </ul>
                    <ul class="nav navbar-nav navbar-right">

                        <li id="userHome">
                            <a href="${pageContext.request.contextPath}/user/status">个人主页</a>
                        </li>

                        <li id="addSys">
                            <a href="${pageContext.request.contextPath}/system/new">添加系统</a>
                        </li>

                        <li id="submit">
                            <a href="${pageContext.request.contextPath}/submit/frame">提交测试</a>
                        </li>

                        <li id="history">
                            <a href="${pageContext.request.contextPath}/submit/history">历史提交</a>
                        </li>

                        <li>
                            <a href="${pageContext.request.contextPath}/test_sets/list">数据下载</a>
                        </li>

                        <li id="upload">
                            <a href="${pageContext.request.contextPath}/upload">CCMT2019提交入口</a>
                        </li>

                        <li class="dropdown" id="userDrop">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">${username}<strong
                                    class="caret"></strong></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="${pageContext.request.contextPath}/user/edit/${username}">个人资料</a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/user/changePWD">修改密码</a>
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
        <div class="col-md-3 column">
        </div>
        <div class="col-md-6 column">
            <fieldset>
                <legend>修改系统信息</legend>
                <form class="form-horizontal" role="form" method="post">
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="name" name="name" value="${system.name}"
                                   required/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <div class="checkbox">
                                <label><input type="checkbox" id="isConstraint" name="isConstraint"/>Check if this is
                                    constraint system</label>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="isPrimary" value="${system.isPrimary}"/>
                    <div class="form-group">
                        <label for="software" class="col-sm-2 control-label">Software</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="software" name="software"
                                   value="${system.software}"/>
                        </div>
                    </div>


                    <input type="hidden" name="sourcelang" value="${system.sourcelang}"/>
                    <input type="hidden" name="targetlang" value="${system.targetlang}"/>


                    <input type="hidden" class="form-control" id="citation" name="citation"
                           value="${system.citation}"/>


                    <input type="hidden" class="form-control" id="website" name="website"
                           value="${system.website}"/>


                    <div class="form-group">
                        <label for="notes" class="col-sm-2 control-label">System Description</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" id="notes" name="notes" rows="5"
                                      style="resize: none">${system.notes}</textarea>
                        </div>

                    </div>

                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10" align="right">
                            <button type="submit" class="btn btn-primary">提交修改</button>
                        </div>
                    </div>
                </form>
            </fieldset>
        </div>
        <div class="col-md-3 column">
        </div>
    </div>

</div>
</body>
</html>
