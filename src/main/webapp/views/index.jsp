<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Home</title>
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
                window.location.href = '${pageContext.request.contextPath}/user/logout'
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
                document.getElementById("history").classList.remove("hidden");
                document.getElementById("downTest").classList.remove("hidden");

                userDrop.innerHTML = '<a href="#" class="dropdown-toggle" data-toggle="dropdown">' + username + '<strong class="caret"></strong></a>\n' +
                    '                            <ul class="dropdown-menu">\n' +
                    '                                <li>\n' +
                    '                                    <a href="${pageContext.request.contextPath}/user/edit/' + username + '">个人资料</a>\n' +
                    '                                </li>\n' +'<li>\n' +
                    '                                    <a href="${pageContext.request.contextPath}/user/changePWD">修改密码</a>\n' +
                    '                                </li>'+
                    '                                <li>\n' +
                    '                                    <a href="javascript:void(0)" onclick="logout()">登出</a>\n' +
                    '                                </li>\n' +
                    '                            </ul>';
            }
        }

        $(document).ready(function () {
            init()
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
                        <li class="active">
                            <a href="#">主页</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/board">积分榜</a>
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

                        <li class="hidden" id="userHome">
                            <a href="${pageContext.request.contextPath}/user/status">个人主页</a>
                        </li>

                        <li class="hidden" id="addSys">
                            <a href="${pageContext.request.contextPath}/system/new">添加系统</a>
                        </li>

                        <li class="hidden" id="submit">
                            <a href="${pageContext.request.contextPath}/submit/frame">提交测试</a>
                        </li>

                        <li class="hidden" id="history">
                            <a href="${pageContext.request.contextPath}/submit/history">历史提交</a>
                        </li>

                        <li class="hidden" id="downTest">
                            <a href="${pageContext.request.contextPath}/test_sets/list">数据下载</a>
                        </li>


                        <li class="dropdown" id="userDrop">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">账户<strong class="caret"></strong></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="${pageContext.request.contextPath}/user/login">登录</a>
                                </li>
                                <li>
                                    <a href="javascript:alert('抱歉，注册功能暂未开放!')">注册</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>

            </nav>
            <div class="jumbotron">
                <h2>
                    欢迎来到CCMT2019机器翻译评测网站！
                </h2>
                <p>
                    本站提供第十五届全国机器翻译学术会议(CCMT 2019)的评测服务，各参赛队伍需使用主办方提供的账户登录，并提交评测相关信息。所有任务的评测结果将在本站的积分榜展示，请各参赛队伍注意。
                </p>
                <p>
                    <a class="btn btn-primary btn-large" href="http://ccmt2019.jxnu.edu.cn">了解更多</a>
                </p>
            </div>
            <h3>最新消息</h3>
        </div>
    </div>
    <div class="row clearfix">
        <div class="col-md-4 column">
            <h2>
                评测任务
            </h2>
            <p>
                CCMT 2019机器翻译评测包括：<br>
                增加了语音翻译任务，由百度公司提供支持；<br>
                翻译质量估计任务中增加了词汇级质量评估，由阿里翻译提供支持；<br>
                翻译质量估计任务中现有的句子级质量评估进一步扩大了数据集的规模，仍由北京语智云帆科技有限公司提供支持。<br>
                其余翻译任务与CWMT2018保持一致，包括由CCMT与WMT2019合作组织的汉英、英汉新闻领域的翻译评测；维汉*、蒙汉、藏汉的翻译评测；以及专利领域的日、汉、英多语言翻译评测等。<br>
                （*该项目训练数据相对2018年减少了部分训练数据）

            </p>
            <p>
                <a class="btn" href="http://ccmt2019.jxnu.edu.cn">了解更多 »</a>
            </p>
        </div>
        <div class="col-md-4 column">
            <h2>
                评测数据
            </h2>
            <p>
                本次评测由主办方提供全部训练、开发、测试集数据，数据格式情况参见<a href="#">附件二</a>，数据详细情况请参见<a href="#">附件五</a>。<br>
                关于数据使用的要求，请参见后续系统要求部分。
            </p>
            <p>
                <a class="btn" href="http://ccmt2019.jxnu.edu.cn">了解更多 »</a>
            </p>
        </div>
        <div class="col-md-4 column">
            <h2>
                评测时间
            </h2>
            <p>
                第十五届全国机器翻译学术会议（CCMT 2019）将于2019年9月27日至29日在中国江西举行。根据惯例，本次会议将继续组织统一的机器翻译评测。
            </p>
            <p>
                <a class="btn" href="http://ccmt2019.jxnu.edu.cn">了解更多 »</a>
            </p>
        </div>
    </div>
</div>
</body>
</html>
