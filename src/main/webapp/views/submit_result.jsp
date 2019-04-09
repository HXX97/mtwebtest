<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Submit:Result</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/bootstrap-select.min.css">
    <script src="${pageContext.request.contextPath}/statics/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap-select.min.js"></script>

    <script language="JavaScript">
        function logout() {
            if (window.confirm('Are you sure to log out?') == true) {
                window.location.href = '/user/logout'
            }
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

                        <li id="userHome">
                            <a href="/user/status">个人主页</a>
                        </li>

                        <li id="addSys">
                            <a href="/system/new">添加系统</a>
                        </li>

                        <li id="submit" class="active">
                            <a href="#">提交测试</a>
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
                <h4>Message</h4>${msg}
            </div>

        </div>
    </div>

    <div class="row clearfix">
        <div class="col-md-12 column" style="margin:auto">
            <fieldset>
                <legend>评测结果</legend>
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th>System</th>
                        <th>TestSet</th>
                        <th>Track</th>
                        <th>Run Notes</th>
                        <th>Uploaded File</th>
                        <th>BLEU_SBP</th>
                        <th>BLEU_NIST</th>
                        <th>TER</th>
                        <th>METEOR</th>
                        <th>NIST</th>
                        <th>GTM</th>
                        <th>mWER</th>
                        <th>mPER</th>
                        <th>ICT</th>
                        <th>Submit Time</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td><a href="/system/detail/${submission.systemid}">${submission.systemName}</a></td>
                        <td>${submission.testset}</td>
                        <td>${submission.track}</td>
                        <td>${submission.notes}</td>
                        <td><a href="/download/uploads/${submission.file}">${submission.file}</a></td>
                        <td>${submission.BLEU_SBP}</td>
                        <td>${submission.BLEU_NIST}</td>
                        <td>${submission.TER}</td>
                        <td>${submission.METEOR}</td>
                        <td>${submission.NIST}</td>
                        <td>${submission.GTM}</td>
                        <td>${submission.MWER}</td>
                        <td>${submission.MPER}</td>
                        <td>${submission.ICT}</td>
                        <td>${submission.time}</td>
                    </tr>
                    </tbody>
                </table>
            </fieldset>
            <div align="right">
                <button class="btn btn-default" onclick="window.location.href='/user/status'">返回</button>
            </div>
        </div>
    </div>
</div>


</body>
</html>
