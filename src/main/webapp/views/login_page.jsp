<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Login</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/bootstrap-select.min.css">
    <script src="${pageContext.request.contextPath}/statics/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap-select.min.js"></script>
    <script>

        function checkForm(){

            var username = document.getElementById("username").value;

            //用户名正则，3到16位（字母，数字，下划线）
            var uPattern = /^[a-zA-Z0-9_]{3,16}$/;
            //输出 true

            if(!uPattern.test(username)){
                window.alert("用户名格式不正确！只能包括字母数字和下划线，长度3-16位");
                return false;
            }
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
    <style>
        fieldset {
            padding: .35em .625em .75em;
            margin: 0 2px;
            border: 1px solid silver;
        }

        legend {
            padding: .5em;
            border: 0;
            width: auto;
            margin-bottom: 0px;
        }
    </style>
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
                        <li class="dropdown">
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
        </div>
        <div class="col-md-12 column">
            <div class="alert alert-dismissable hidden" id="msg">
                <button type="button" class="close " data-dismiss="alert" aria-hidden="true">×</button>
                <h4>Notice</h4>${msg}
            </div>
        </div>
    </div>
    <div class="row clearfix" style="margin-top: 5%">
        <div class="col-md-4 column">
        </div>
        <div class="col-md-4 column">
            <fieldset>
                <legend>用户登录
                </legend>
                <form class="form-horizontal" role="form" method="post" onsubmit="return checkForm()">
                    <div class="form-group">
                        <label for="username" class="col-sm-2 control-label">账号</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="username" name="username" required/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="password" name="password" required/>
                            <a id="errorMsg" href="javascript:void(0)" style="color: red">${errorMsg}</a>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <div class="checkbox">
                                <label><input type="checkbox"/>记住密码</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10" align="right">
                            <button type="submit" class="btn btn-default">登录</button>
                        </div>
                    </div>
                </form>
            </fieldset>
        </div>
        <div class="col-md-4 column">
        </div>
    </div>
</div>

</body>
</html>
