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
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap-select/1.13.8/css/bootstrap-select.min.css" >
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap-fileinput/4.5.0/css/fileinput.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-select/1.13.8/js/bootstrap-select.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-fileinput/4.5.0/js/fileinput.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-fileinput/4.5.0/js/locales/zh.min.js"></script>



    <script language="JavaScript">
        function logout() {
            if (window.confirm('Are you sure to log out?') == true) {
                window.location.href = '/user/logout'
            }
        }

        function checkForm() {
            if (document.getElementById("uploadFile").value == "")
                return false;
            else
                return true;
        }

        function init() {
            var message = "${msg}";

            if (message != "" && message != "null") {
                document.getElementById("msg").classList.remove("hidden");
                var msgLevel = "${msgLevel}";
                if(msgLevel==1){
                    document.getElementById("msg").classList.add("alert-danger");
                }else{
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
        <div class="col-md-12">
            <nav class="navbar navbar-default navbar-inverse" role="navigation">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse"
                            data-target="#bs-example-navbar-collapse-1"><span
                            class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span
                            class="icon-bar"></span><span class="icon-bar"></span></button>
                    <a class="navbar-brand" href="#">HIT MT Evalution</a>
                </div>

                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li>
                            <a href="/">主页</a>
                        </li>
                        <li>
                            <a href="/board">积分榜</a>
                        </li>
                        <li>
                            <a href="/test_sets/list">相关资料下载</a>
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

            <div class="alert alert-dismissable alert-info hidden" id="msg">
                <button type="button" class="close " data-dismiss="alert" aria-hidden="true">×</button>
                <h4>Message</h4>${msg}
            </div>

        </div>
    </div>

    <div class="row clearfix">

        <div class="col-md-3"></div>
        <div class="col-md-6 column">
            <fieldset>
                <legend>上传文件</legend>
                <form class="form-horizontal" action="/submit/upload" role="form" method="post" enctype="multipart/form-data" onsubmit="checkForm()">
                    <p>测试集: ${setName}</p>
                    <p>系统: ${sysName}</p>
                    <p>源语言: ${srcLangFull}</p>
                    <p>目标语言: ${tgtLangFull}</p>
                    <p>任务: ${track}</p>
                    <p>

                        <label for="uploadFile">选择文件: </label>
                        <input type="file" class="file" name="uploadFile" id="uploadFile" required
                               data-show-preview="false">

                    </p>
                    <p>
                        <label for="notes">备注: </label>
                        <textarea name="notes" id="notes" class="form-control" rows="5" style="resize: none"></textarea>
                    </p>
                    <input type="hidden" name="setId" value="${setId}">
                    <input type="hidden" name="sysId" value="${sysId}">
                    <input type="hidden" name="srcLang" value="${srcLang}">
                    <input type="hidden" name="tgtLang" value="${tgtLang}">
                    <input type="hidden" name="track" value="${track}">

                    <div align="right">

                    <button class="btn btn-default" onclick="javascript:window.history.back()">返回上一步</button>
                        <button type="submit" class="btn btn-primary">上传</button>
                    </div>
                </form>
            </fieldset>
        </div>
        <div class="col-md-3 column"></div>

    </div>

</div>

</body>
</html>
