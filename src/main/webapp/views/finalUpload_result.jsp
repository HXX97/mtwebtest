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
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap-select/1.13.8/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap-fileinput/4.5.0/css/fileinput.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-select/1.13.8/js/bootstrap-select.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-fileinput/4.5.0/js/fileinput.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-fileinput/4.5.0/js/locales/zh.min.js"></script>


    <script language="JavaScript">
        function logout() {
            if (window.confirm('Are you sure to log out?') == true) {
                window.location.href = '${pageContext.request.contextPath}/user/logout'
            }
        }

        function checkForm() {
            uploadFile = document.getElementById("uploadFile").value
            if (uploadFile == "") {
                alert("请选择文件");
                return false;
            } else {
                if (!/\.(xml)$/.test(uploadFile)) {
                    alert("文件类型必须为xml");
                    return false;
                }
            }
            return true;
        }

        function init() {

                //document.getElementById("msg").classList.remove("hidden");
                var msgLevel = "${msgLevel}";
                if (msgLevel == 1) {
                    document.getElementById("msg").classList.add("alert-danger");
                } else {
                    document.getElementById("msg").classList.add("alert-success");
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
        <div class="col-md-12">
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
                            <a href="${pageContext.request.contextPath}/">主页</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/board">排行榜</a>
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
                                    <a href="${pageContext.request.contextPath}/about">关于本站</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">

                        <li id="userHome">
                            <a href="${pageContext.request.contextPath}/user/status">个人主页</a>
                        </li>

                        <li id="addSys">
                            <a href="${pageContext.request.contextPath}/system/new">添加系统</a>
                        </li>

                        <li id="submit" >
                            <a href="${pageContext.request.contextPath}/submit/frame">提交测试</a>
                        </li>

                        <li id="history">
                            <a href="${pageContext.request.contextPath}/submit/history">历史提交</a>
                        </li>

                        <li>
                            <a href="${pageContext.request.contextPath}/test_sets/list">数据下载</a>
                        </li>

                        <li class="active">
                            <a href="#">CCMT2019提交入口</a>
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
        <div class="col-md-3 column"></div>
        <div class="col-md-6 column">

            <div class="alert alert-dismissable alert-info " id="msg">

                <h4>上传结果</h4>${uploadResult}
            </div>

            <div align="right">
                <!-- 除了IE,所有浏览器button 的默认type="submit" -->
                <button class="btn btn-default" type="button" onclick="window.location.href='${pageContext.request.contextPath}/upload'">
                    继续提交
                </button>
                <button class="btn btn-primary" type="button" onclick="window.location.href='${pageContext.request.contextPath}/user/status'">返回个人中心</button>

        </div>
        <div class="col-md-3 column"></div>

    </div>



</div>

</body>
</html>
