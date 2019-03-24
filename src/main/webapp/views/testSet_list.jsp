<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Test Sets</title>
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

        function init(){
            var username="${username}";
            if(username!="null"&&username!=""){
                var userDrop = document.getElementById("userDrop");
                userDrop.classList.remove("dropdown");
                document.getElementById("userHome").classList.remove("hidden");
                document.getElementById("addSys").classList.remove("hidden");
                document.getElementById("submit").classList.remove("hidden");
                document.getElementById("history").classList.remove("hidden");

                userDrop.innerHTML='<a href="#" class="dropdown-toggle" data-toggle="dropdown">'+username+'<strong class="caret"></strong></a>\n' +
                    '                            <ul class="dropdown-menu">\n' +
                    '                                <li>\n' +
                    '                                    <a href="/user/edit/'+username+'">个人资料</a>\n' +
                    '                                </li>\n' +
                    '                                <li>\n' +
                    '                                    <a href="javascript:void(0)" onclick="logout()">登出</a>\n' +
                    '                                </li>\n' +
                    '                            </ul>';
            }
        }

        $(document).ready(function(){init()});
    </script>
</head>

<body onload="getLeaderBoard()">
<div class="container-fluid">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <nav class="navbar navbar-default navbar-inverse" role="navigation">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button> <a class="navbar-brand" href="#">HIT MT Evalution</a>
                </div>

                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li>
                            <a href="/">主页</a>
                        </li>
                        <li>
                            <a href="/board">积分榜</a>
                        </li>
                        <li class="active">
                            <a href="#">数据下载</a>
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
                            <a href="/submit/frame" >提交测试</a>
                        </li>

                        <li class="hidden" id="history">
                            <a href="/submit/history">历史提交</a>
                        </li>

                        <li class="dropdown" id="userDrop">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">账户<strong class="caret"></strong></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="/user/login">登录</a>
                                </li>
                                <li>
                                    <a href="javascript:alert('抱歉，注册功能暂未开放!')">注册</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>

            </nav>
            <div class="col-md-4">
                <h4>数据下载</h4>
            </div>
            <div class="col-md-4">
            </div>
            <div class="col-md-4">
            </div>
        </div>
        <div class="col-md-12 column">
            <table class="table table-hover table-striped" id="leaderBoard">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Origin</th>
                    <th>Domain</th>
                    <th>Related Corpora</th>
                    <th>Citation</th>
                    <th>Notes</th>
                    <th>TestSetups</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${requestScope.testSetList}" var="testSet">
                    <tr>
                        <td><a href="">${testSet.name}</a><br/>
                            <a href="/download/testSets/${testSet.srcurl}">download</a></td>
                        <td>${testSet.origin}</td>
                        <td>${testSet.domain}</td>
                        <td>${testSet.related_corpora}</td>
                        <td>${testSet.citation}</td>
                        <td>${testSet.notes}</td>
                        <td>${testSet.setups}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</div>
</body>
</html>
