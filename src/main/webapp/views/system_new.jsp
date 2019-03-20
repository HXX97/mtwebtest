<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>New System</title>
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
                            <a href="/test_sets/list">数据下载</a>
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

                        <li id="addSys" class="active">
                            <a href="#">添加系统</a>
                        </li>

                        <li id="submit">
                            <a href="/submit/frame">提交测试</a>
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
        <div class="col-md-3 column">
        </div>
        <div class="col-md-6 column">

            <fieldset>
                <legend>新建系统</legend>
                <form class="form-horizontal" role="form" method="post">
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">系统名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="name" name="name" required/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <div class="checkbox">
                                <label><input type="checkbox" id="isConstraint" name="isConstraint"/>是否为受约束系统</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <div class="checkbox">
                                <label><input type="checkbox" id="isPrimary" name="isPrimary"/>是否为主提交系统</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="software" class="col-sm-2 control-label">所用框架</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="software" name="software"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="sourceLang" class="col-sm-2 control-label">源语言</label>
                        <div class="col-sm-10">
                            <select class="selectpicker" id="sourceLang" name="sourcelang">
                                <option value="CS">CS</option>
                                <option value="EN">EN</option>
                                <option value="MG">MG</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="targetLang" class="col-sm-2 control-label">目标语言</label>
                        <div class="col-sm-10">
                            <select class="selectpicker" id="targetLang" name="targetlang">
                                <option value="CS">CS</option>
                                <option value="EN">EN</option>
                                <option value="MG">MG</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="citation" class="col-sm-2 control-label">引用</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="citation" name="citation"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="website" class="col-sm-2 control-label">网址</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="website" name="website"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="notes" class="col-sm-2 control-label">备注</label>
                        <div class="col-sm-10">
                            <%--<input type="text" class="form-control" id="notes" name="notes"/>--%>
                            <textarea class="form-control" id="notes" name="notes" rows="5"
                                      style="resize: none"></textarea>
                        </div>

                    </div>


                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10" align="right">
                            <button type="submit" class="btn btn-primary">创建系统</button>
                        </div>
                    </div>
                </form>
            </fieldset>
        </div>
        <div class="col-md-3 column">
            <div class="alert alert-dismissable alert-info" id="msg">
                <button type="button" class="close " data-dismiss="alert" aria-hidden="true">×</button>
                <h4>提示</h4>
                <ul>
                    <li>
                        Primary systems will be selected for human evaluation, and described in the overview paper.
                        Other
                        systems will not. Systems submitted after the deadline may also be excluded.
                    </li>
                    <li>
                        The system name will be used to refer to the system in the overview.
                    </li>
                    <li>
                        The system name will be used to refer to the system in the overview.
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

</body>
</html>
