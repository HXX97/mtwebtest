<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>History</title>
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

        function init() {
            var username = "${username}";
            if (username != "null" && username != "") {
                var userDrop = document.getElementById("userDrop");
                userDrop.classList.remove("dropdown");
                document.getElementById("userHome").classList.remove("hidden");
                document.getElementById("addSys").classList.remove("hidden");
                document.getElementById("submit").classList.remove("hidden");

                userDrop.innerHTML = '<a href="#" class="dropdown-toggle" data-toggle="dropdown">' + username + '<strong class="caret"></strong></a>\n' +
                    '                            <ul class="dropdown-menu">\n' +
                    '                                <li>\n' +
                    '                                    <a href="/user/edit/' + username + '">个人资料</a>\n' +
                    '                                </li>\n' +
                    '                                <li>\n' +
                    '                                    <a href="javascript:void(0)" onclick="logout()">登出</a>\n' +
                    '                                </li>\n' +
                    '                            </ul>';
            }
        }

        function getLeaderBoard() {
            var track = document.getElementById("track").value;
            //var metric = document.getElementById("metric").value;

            var username = "${username}";
            if (username == "") {
                window.alert("登录已超时，请重新登录！");
                window.location.href = "/user/login";
                return
            }
            var data;
            $.ajax(
                {
                    type: 'get',
                    url: '${pageContext.request.contextPath}/submit/history/' + username + '/' + track,
                    success: function (result) {
                        for (var i = 0; i < result.length; i++) {
                            data += '<tr>' +
                                '<td>' + (i + 1) + '</td>' +
                                '<td><a href="/system/detail/' + result[i].systemid + '">' + result[i].systemName + '</td>' +
                                '<td>' + result[i].testset + '</td>' +
                                '<td>' + result[i].notes + '</td>' +
                                '<td>' + result[i].bleu_SBP + '</td>' +
                                '<td>' + result[i].bleu_NIST + '</td>' +
                                '<td>' + result[i].ter + '</td>' +
                                '<td>' + result[i].meteor + '</td>' +
                                '<td>' + result[i].nist + '</td>' +
                                '<td>' + result[i].gtm + '</td>' +
                                '<td>' + result[i].mwer + '</td>' +
                                '<td>' + result[i].mper + '</td>' +
                                '<td>' + result[i].ict + '</td>' +
                                '<td>' + result[i].isConstraint + '</td>' +
                                '<td>' + result[i].time + '</td>' +
                                '<td>' + result[i].state + '</td>' +
                                '</tr>'
                        }
                        //清空上次数据
                        $("#leaderBoard tbody tr:not(:first)").html("");
                        //将查询出来的数据插入
                        $("#leaderBoard #firstTr").after(data);
                    }
                }
            )
        }

        $(document).ready(function () {
            init();
            getLeaderBoard()
        });


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
                        <li class="hidden" id="userHome">
                            <a href="/user/status">个人主页</a>
                        </li>

                        <li class="hidden" id="addSys">
                            <a href="/system/new">添加系统</a>
                        </li>

                        <li class="hidden" id="submit">
                            <a href="/submit/frame">提交测试</a>
                        </li>

                        <li id="history">
                            <a href="#">历史提交</a>
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
        <div class="col-md-4">
            <h4>历史提交</h4>
        </div>
        <div class="col-md-4">
        </div>
        <div class="col-md-4">
            <label for="track">选择任务:</label>
            <select class="selectpicker" id="track" onchange="getLeaderBoard()">
                <option value="CE">CE</option>
                <option value="EC">EC</option>
                <option value="MC">MC</option>
                <option value="TC">TC</option>
                <option value="UC">UC</option>
                <option value="JE">JE</option>
            </select>
        </div>
    </div>
    <div class="row clearfix">
        <div class="col-md-12 column">
            <table class="table table-hover table-striped" id="leaderBoard">
                <thead>
                <tr>
                    <th>Rank</th>
                    <th>System</th>
                    <th>TestSet</th>
                    <th>Run Notes</th>
                    <th>BLEU_SBP</th>
                    <th>BLEU_NIST</th>
                    <th>TER</th>
                    <th>METEOR</th>
                    <th>NIST</th>
                    <th>GTM</th>
                    <th>mWER</th>
                    <th>mPER</th>
                    <th>ICT</th>
                    <th>isConstraint</th>
                    <th>Submit Time</th>
                    <th>State</th>
                </tr>
                </thead>
                <tbody>
                <tr id="firstTr"></tr>
                </tbody>
            </table>
        </div>
    </div>

</div>
</body>
</html>
