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
                window.location.href = '${pageContext.request.contextPath}/user/logout'
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

                        <li id="addSys" class="active">
                            <a href="#">添加系统</a>
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

                        <li id="upload">
                            <a href="${pageContext.request.contextPath}/upload">CCMT2019提交入口</a>
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
        <div class="col-md-3 column">
        </div>
        <div class="col-md-6 column">

            <fieldset>
                <legend>新建系统</legend>
                <form class="form-horizontal" role="form" method="post">
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="name" name="name" required/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <div class="checkbox">
                                <label><input type="checkbox" id="isConstraint" name="isConstraint"/>Check if this is constraint system</label>
                            </div>
                        </div>
                    </div>
<%--                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <div class="checkbox">
                                <label><input type="checkbox" id="isPrimary" name="isPrimary"/>是否为主提交系统</label>
                            </div>
                        </div>
                    </div>--%>
                    <input type="hidden" name="isPrimary" value="true"/>

                    <div class="form-group">
                        <label for="software" class="col-sm-2 control-label">Software</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="software" name="software"/>
                        </div>
                    </div>
                    <%--                    <div class="form-group">
                                            <label for="sourceLang" class="col-sm-2 control-label">源语言</label>
                                            <div class="col-sm-10">
                                                <select class="selectpicker" id="sourceLang" name="sourcelang">
                                                    <option value="zh">Chinese</option>
                                                    <option value="en">English</option>
                                                    <option value="mn">Mongolian</option>
                                                    <option value="jp">Japanese</option>
                                                    <option value="ti">Tibetan</option>
                                                    <option value="uy">Uyghur</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="targetLang" class="col-sm-2 control-label">目标语言</label>
                                            <div class="col-sm-10">
                                                <select class="selectpicker" id="targetLang" name="targetlang">
                                                    <option value="zh">Chinese</option>
                                                    <option value="en">English</option>
                                                    <option value="mn">Mongolian</option>
                                                    <option value="jp">Japanese</option>
                                                    <option value="ti">Tibetan</option>
                                                    <option value="uy">Uyghur</option>
                                                </select>
                                            </div>
                                        </div>--%>

                    <input type="hidden" name="sourcelang" value="zh"/>
                    <input type="hidden" name="targetlang" value="en"/>


                    <div class="form-group">
                        <label for="citation" class="col-sm-2 control-label">Citation</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="citation" name="citation"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="website" class="col-sm-2 control-label">Web</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="website" name="website"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="notes" class="col-sm-2 control-label">System Description</label>
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
                        单个用户的系统名不可重复。
                    </li>
                    <li>
                        受限训练是指只可以使用评测组织方指定范围的数据进行训练。
                    </li>
                    <li>
                        单个系统的多次提交，只会将最好成绩记入排行榜。
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

</body>
</html>
