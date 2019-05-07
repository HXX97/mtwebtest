
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Change Password</title>
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

        function checkForm() {
            old = document.getElementById("old").value;
            newP = document.getElementById("new").value;
            newPAgain = document.getElementById("newAgain").value;
            if(newP!=newPAgain){
                window.alert("两次密码输入不一致！");
                return false;
            }
            return true;
        }

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
                            <a href="${pageContext.request.contextPath}/">主页</a>
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

                        <li class="dropdown" id="userDrop">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">${username}<strong
                                    class="caret"></strong></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="${pageContext.request.contextPath}/user/edit/${username}">个人资料</a>
                                </li>
                                <li>
                                    <a href="#">修改密码</a>
                                </li>
                                <li>
                                    <a href="javascript:logout()">登出</a>
                                </li>

                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>

            <div class="row clearfix">
                <div class="col-md-4 column">
                </div>
                <div class="col-md-4 column">

                    <fieldset>
                        <legend>修改密码</legend>
                        <form class="form-horizontal" role="form" method="post" onsubmit="return checkForm()">
                            <div class="form-group">
                                <label for="old" class="col-sm-4 control-label">旧密码</label>
                                <div class="col-sm-8">
                                    <input type="password" class="form-control" id="old" name="old" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="old" class="col-sm-4 control-label">新密码</label>
                                <div class="col-sm-8">
                                    <input type="password" class="form-control" id="new" name="new" required/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="old" class="col-sm-4 control-label">确认新密码</label>
                                <div class="col-sm-8">
                                    <input type="password" class="form-control" id="newAgain" name="newAgain" required/>
                                </div>
                            </div>


                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10" align="right">
                                    <button type="submit" class="btn btn-primary">提交</button>
                                </div>
                            </div>
                        </form>
                    </fieldset>
                </div>
                <div class="col-md-4 column">

                </div>
            </div>
        </div>

    </div>
</div>

</body>
</html>
