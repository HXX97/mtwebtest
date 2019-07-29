<%@ page contentType="text/html;charset=UTF-8" pageEncoding="utf-8" language="java" %>
<html>
<head>
    <title>About</title>
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
                document.getElementById("upload").classList.remove("hidden");

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

                        <li class="active">
                            <a href="${pageContext.request.contextPath}/about">使用说明</a>
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

                        <li class="hidden" id="upload">
                            <a href="${pageContext.request.contextPath}/upload">CCMT2019提交入口</a>
                        </li>

                        <li class="dropdown" id="userDrop">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">账户<strong class="caret"></strong></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="${pageContext.request.contextPath}/user/login">登录</a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/user/register">注册</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>

            </nav>
        </div>
    </div>
    <div class="row clearfix" style="margin-bottom: 20px">
        <div class="col-md-3 column"></div>
        <div class="col-md-6 column">
            <fieldset>
                <legend>使用说明</legend>
                <div>
                    <p style="margin:0pt; orphans:0; text-align:center; widows:0"><span
                            style="font-family:黑体; font-size:16pt"></span><span style="font-family:黑体; font-size:16pt">
                通用机器翻译技术测评平台使用说明</span></p>
                    <ol type="1" style="margin:0pt; padding-left:0pt">
                        <li style="font-family:黑体; font-size:15pt; margin:0pt 0pt 0pt 18pt; orphans:0; text-indent:0pt; widows:0">
                            <span style="font-family:黑体; font-size:15pt">关于本评测平台</span></li>
                    </ol>
                    <p style="margin:0pt; orphans:0; text-align:justify; text-indent:24pt; widows:0"><span
                            style="font-family:宋体; font-size:12pt">机器翻译又称自动翻译，是利用计算机把一种自然源语言转变为另一种自然目标语言的过程。机器翻译测评是对机器翻译质量好坏进行评估的过程。本平台旨在提供第</span><span
                            style="font-family:宋体; font-size:12pt">15届全国机器翻译学术会议（CCMT
                2019）的测评服务，通过web网站的形式对各参赛队伍上传的测试文件提供测评结果和积分排名，并将数据上传至数据库。</span></p>
                    <p style="margin:0pt; orphans:0; text-align:justify; text-indent:24pt; widows:0"><span
                            style="font-family:宋体; font-size:12pt">本测试平台实现的主要功能如下：</span></p>
                    <p style="margin:0pt 0pt 0pt 45pt; orphans:0; text-indent:-21pt; widows:0"><span
                            style="font-family:Wingdings; font-size:12pt"></span><span
                            style="font:7.0pt 'Times New Roman'">&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0; </span><span
                            style="font-family:宋体; font-size:12pt">参赛队伍账号管理</span></p>
                    <p style="margin:0pt 0pt 0pt 45pt; orphans:0; text-indent:-21pt; widows:0"><span
                            style="font-family:Wingdings; font-size:12pt"></span><span
                            style="font:7.0pt 'Times New Roman'">&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0; </span><span
                            style="font-family:宋体; font-size:12pt">提供测试集数据下载</span></p>
                    <p style="margin:0pt 0pt 0pt 45pt; orphans:0; text-indent:-21pt; widows:0"><span
                            style="font-family:Wingdings; font-size:12pt"></span><span
                            style="font:7.0pt 'Times New Roman'">&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0; </span><span
                            style="font-family:宋体; font-size:12pt">参赛队伍创建MT系统及提交测试</span></p>
                    <p style="margin:0pt 0pt 0pt 45pt; orphans:0; text-indent:-21pt; widows:0"><span
                            style="font-family:Wingdings; font-size:12pt"></span><span
                            style="font:7.0pt 'Times New Roman'">&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0; </span><span
                            style="font-family:宋体; font-size:12pt">对参赛队伍提交的系统进行自动评价，自动评价包含指标有：BLEU-SBP、BLEU-NIST、TER、METEOR、NIST、GTM、</span><span
                            style="font-family:宋体; font-size:12pt">mWER</span><span
                            style="font-family:宋体; font-size:12pt">、</span><span
                            style="font-family:宋体; font-size:12pt">mPER</span><span
                            style="font-family:宋体; font-size:12pt">以及ICT</span></p>
                    <p style="margin:0pt 0pt 0pt 45pt; orphans:0; text-indent:-21pt; widows:0"><span
                            style="font-family:Wingdings; font-size:12pt"></span><span
                            style="font:7.0pt 'Times New Roman'">&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0; </span><span
                            style="font-family:宋体; font-size:12pt">查看当前各个任务的排名情况及排行榜</span></p>
                    <ol start="2" type="1" style="margin:0pt; padding-left:0pt">
                        <li style="font-family:黑体; font-size:15pt; margin:0pt 0pt 0pt 18pt; orphans:0; text-indent:0pt; widows:0">
                            <span style="font-family:黑体; font-size:15pt">使用步骤</span></li>
                    </ol>
                    <p style="margin:0pt; orphans:0; text-align:justify; text-indent:24pt; widows:0"><span
                            style="font-family:宋体; font-size:12pt">主办方会提供评测平台的账号给各参赛队伍/个人，每支参赛队伍/个人只有一个账号，可自行修改密码及相关信息。每个账户都可以对</span><span
                            style="font-family:宋体; font-size:12pt">各任务</span><span
                            style="font-family:宋体; font-size:12pt">提交评测，以C</span><span
                            style="font-family:宋体; font-size:12pt">E</span><span
                            style="font-family:宋体; font-size:12pt">为例，介绍评测流程：</span></p>
                    <p style="margin:0pt 0pt 0pt 42pt; orphans:0; text-align:justify; text-indent:-18pt; widows:0"><span
                            style="font-family:宋体; font-size:12pt">1）</span><span
                            style="font-family:宋体; font-size:12pt">创建一个用于评测的系统</span></p>
                    <p style="margin:0pt 0pt 0pt 42pt; orphans:0; text-align:justify; widows:0"><span
                            style="font-family:宋体; font-size:12pt">点击创建新系统按钮，进入添加系统</span><span
                            style="font-family:宋体; font-size:12pt">页面，填写系统相关信息，包括：</span><span
                            style="font-family:宋体; font-size:12pt">系统名、所用软件技术、系统描述</span><span
                            style="font-family:宋体; font-size:12pt">等等</span></p>
                    <p style="margin:0pt 0pt 0pt 42pt; orphans:0; text-align:justify; text-indent:-18pt; widows:0"><span
                            style="font-family:宋体; font-size:12pt">2）</span><span
                            style="font-family:宋体; font-size:12pt">选择评测</span><span
                            style="font-family:宋体; font-size:12pt">数据集及系统</span></p>
                    <p style="margin:0pt 0pt 0pt 42pt; orphans:0; text-align:justify; widows:0"><span
                            style="font-family:宋体; font-size:12pt">点击提交评测，进入选择页面，选择评测数据集及用户创建的系统</span></p>
                    <p style="margin:0pt 0pt 0pt 42pt; orphans:0; text-align:justify; text-indent:-18pt; widows:0"><span
                            style="font-family:宋体; font-size:12pt">3）</span><span style="font-family:宋体; font-size:12pt">上传文件</span>
                    </p>
                    <p style="margin:0pt 0pt 0pt 24pt; orphans:0; text-align:justify; text-indent:18pt; widows:0"><span
                            style="font-family:宋体; font-size:12pt">上传所选测试集对应的机器翻译结果，文档格式需按照评测大纲中的说明要求，否则可能导致评测结果异常。</span></p>
                    <p style="margin:0pt 0pt 0pt 42pt; orphans:0; text-align:justify; text-indent:-18pt; widows:0"><span
                            style="font-family:宋体; font-size:12pt">4）</span><span
                            style="font-family:宋体; font-size:12pt">计算评测结果</span></p>
                    <p style="margin:0pt 0pt 0pt 42pt; orphans:0; text-align:justify; widows:0"><span
                            style="font-family:宋体; font-size:12pt">文件上传完毕之后，</span><span
                            style="font-family:宋体; font-size:12pt">后台会自动调用评测工具进行评分，计算过程与所选测试</span><span
                            style="font-family:宋体; font-size:12pt">集大小</span><span
                            style="font-family:宋体; font-size:12pt">有关，用户可在历史记录中查看得分详情。</span></p>
                    <p style="margin:0pt; orphans:0; text-align:justify; widows:0"><span
                            style="font-family:宋体; font-size:12pt">&#xa0;</span></p>
                    <ol start="3" type="1" style="margin:0pt; padding-left:0pt">
                        <li style="font-family:黑体; font-size:15pt; margin:0pt 0pt 0pt 18pt; orphans:0; text-indent:0pt; widows:0">
                            <span style="font-family:黑体; font-size:15pt">注意事项</span></li>
                    </ol>
                    <p style="margin:0pt 0pt 0pt 42pt; orphans:0; text-align:justify; text-indent:-18pt; widows:0"><span
                            style="font-family:宋体; font-size:12pt">1）</span><span
                            style="font-family:宋体; font-size:12pt">用户的个人信息</span><span
                            style="font-family:宋体; font-size:12pt">仅主办</span><span
                            style="font-family:宋体; font-size:12pt">方及用户本账户可见。但用户的单位信息将展示在排行榜的提交结果中，若不填则默认为空，请务必填写。</span></p>
                    <p style="margin:0pt 0pt 0pt 42pt; orphans:0; text-align:justify; text-indent:-18pt; widows:0"><span
                            style="font-family:宋体; font-size:12pt">2）</span><span
                            style="font-family:宋体; font-size:12pt">用户所创建的系统，其详细信息可在排行榜中被所有人查看，包括系统信息、系统提交记录、提交人等。</span></p>
                    <p style="margin:0pt 0pt 0pt 42pt; orphans:0; text-align:justify; text-indent:-18pt; widows:0"><span
                            style="font-family:宋体; font-size:12pt">3）</span><span
                            style="font-family:宋体; font-size:12pt">用户创建的系统会由系统分配系统i</span><span
                            style="font-family:宋体; font-size:12pt">d</span><span
                            style="font-family:宋体; font-size:12pt">，在翻译结果中的</span><span
                            style="font-family:宋体; font-size:12pt">s</span><span
                            style="font-family:宋体; font-size:12pt">ysid</span><span
                            style="font-family:宋体; font-size:12pt">属性填写此i</span><span
                            style="font-family:宋体; font-size:12pt">d</span><span style="font-family:宋体; font-size:12pt">即可。<b>特别注意：sysid为必填，setid必须与src中的setid一致，否则会评测失败。</b></span>
                    </p>
                    <p style="margin:0pt 0pt 0pt 42pt; orphans:0; text-align:justify; text-indent:-18pt; widows:0"><span
                            style="font-family:宋体; font-size:12pt">4）</span><span
                            style="font-family:宋体; font-size:12pt">单个用户可以创建多个系统，每个系统的提交次数、提交任务均不受限制，但对于某个任务，单个系统的多次提交，只取其最好成绩计入排行榜中。</span>
                    </p>
                    <p style="margin:0pt 0pt 0pt 42pt; orphans:0; text-align:justify; text-indent:-18pt; widows:0"><span
                            style="font-family:宋体; font-size:12pt">5）</span><span
                            style="font-family:宋体; font-size:12pt">提交数据格式请务必按照评测要求，文件格式为xml，所提交翻译结果的根元素应为tstset,参考格式如下图：</span>
                    </p>
                    <p style="margin:0pt 0pt 0pt 42pt; orphans:0; text-align:justify; text-indent:-18pt; widows:0">
                        <img src="${pageContext.request.contextPath}/statics/pics/demo.png" width="100%">
                    </p>
                    <%--<p style="margin:0pt 0pt 0pt 42pt; orphans:0; text-align:justify; text-indent:-18pt; widows:0"><span--%>
                            <%--style="font-family:宋体; font-size:12pt">6）</span><span--%>
                            <%--style="font-family:宋体; font-size:12pt">若在使用平台中遇到其它问题，请联系xixinhu97@foxmail.com</span>--%>
                    <%--</p>--%>

                </div>

            </fieldset>
        </div>
        <div class="col-md-3 column"></div>
    </div >
</div>

</body>
</html>
