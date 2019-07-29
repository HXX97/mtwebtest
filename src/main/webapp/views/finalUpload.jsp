<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Upload</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap-select/1.13.8/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap-fileinput/4.5.0/css/fileinput.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-select/1.13.8/js/bootstrap-select.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-fileinput/4.5.0/js/fileinput.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-fileinput/4.5.0/js/locales/zh.min.js"></script>


    <script language="JavaScript">
        function logout() {
            if (window.confirm('Are you sure to log out?') == true) {
                window.location.href = '${pageContext.request.contextPath}/user/logout'
            }
        }

        function checkForm() {
            uploadFile = document.getElementById("uploadFile").value
            if (uploadFile == "") {
                alert("请选择文件");
                return false;
            } else {
                if (!/\.(zip)$/.test(uploadFile)) {
                    alert("文件类型必须为zip");
                    return false;
                }
            }
            trackselector = document.getElementById("track").value
            if(trackselector=null||trackselector==""){
                alert("请选择任务");
                return false;
            }
            return true;
        }

        function init() {
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

                        <li>
                            <a href="${pageContext.request.contextPath}/about">使用说明</a>
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

                        <li class="active">
                            <a href="#">CCMT2019提交入口</a>
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

        <div class="col-md-3"></div>
        <div class="col-md-6 column">
            <fieldset>
                <legend>CCMT2019提交入口</legend>
                <form class="form-horizontal" action="${pageContext.request.contextPath}/upload" role="form" method="post"
                      enctype="multipart/form-data" onsubmit="return checkForm()">
                    <label for="uploadHistory">已成功上传的文件：</label>
                    <div id="uploadHistory">
                        <table class="table table-hover table-striped" id="systemTable">
                            <thead>
                            <tr>
                                <th>FileName</th>
                                <th>track</th>
                                <th>Upload Time</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${recordList}" var="record">
                                <tr>
                                    <td>${record.fileName}</td>
                                    <td>${record.track}</td>
                                    <td>${record.time}</td>
                                </tr>
                            </c:forEach>

                            </tbody>
                        </table>

                    </div>

                    <label for="instruction">上传说明:</label>
                    <div id="instruction">
                        1)对于所有的任务，请将要提交的文件打包成一个zip，只接受zip提交。<b>zip文件名格式:CCMT2019_XXX_**.zip。文件名不得包含中文</b>
                        CCMT2019_XXX是用户的登录账号，**是所参加的任务代号。<br/>
                        2)每个参赛账号在每个任务下<b>只能成功提交一次</b>，格式检查失败不计次数，请谨慎提交，确保提交文件内容、格式正确<br/>
                        3)对于翻译任务，xml文件名格式为<b>项目代号-评测语料年份-参评单位代号-主/对比系统-参评系统代号</b>，
                        如ce-2019-hit-primary-a.xml/ce-2019-hit-contrast-b.xml。<br/>
                        文件名模式中主/对比系统-参评系统代号必须以英文字母顺序排序，顺序中包含主及对比系统，例如：主系统为a，则对比系统从b开始。<br/>
                        4)翻译任务提交的文件需通过<b>格式检查</b>，格式检查不通过需要修改格式后重新提交。以下提交文件格式作为参考，具体请参照评测大纲要求。
                        <img src="${pageContext.request.contextPath}/statics/pics/demo4Upload.png" width="100%"><br>
                        <%--5)对于QE任务，<b>文件名遵循下表要求</b>。(（其中：项目代号以ce-qe为例，参评单位代号以ict为例）)
                        <img src="${pageContext.request.contextPath}/statics/pics/qeillustration.png" width="100%"/><br>
                        6)QE任务未做格式检查，请确保格式正确。<br>--%>

                    </div>
                    <label for="track">选择任务:</label>
                    <select class="selectpicker" id="track" name="track">
                        <%--<option value="CE">CE</option>--%>
                        <%--<option value="EC">EC</option>--%>
                        <%--<option value="MC">MC</option>--%>
                        <%--<option value="TC">TC</option>--%>
                        <%--<option value="UC">UC</option>--%>
                        <%--<option value="JE">JE</option>
                        <option value="CE-QEW">CE-QEW</option>
                            <option value="CE-QES">CE-QES</option>
                        <option value="EC-QEW">EC-QEW</option>
                            <option value="EC-QES">EC-QES</option>--%>
                    </select>
                    <p>

                        <label for="uploadFile">选择文件: </label>
                        <input type="file" class="file" name="uploadFile" id="uploadFile" required
                               data-show-preview="false" accept="application/zip">

                    </p>

                    <div align="right">
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
