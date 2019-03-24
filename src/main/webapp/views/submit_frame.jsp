<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Submit:Frame</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/bootstrap-select.min.css">
    <script src="${pageContext.request.contextPath}/statics/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/statics/js/bootstrap-select.min.js"></script>

    <script language="JavaScript">
        function logout() {
            if (window.confirm('Are you sure to log out?') == true) {
                window.location.href = '/user/logout'
            }
        }

        function checkForm() {
            var setSrcLang, setTgtLang, sysSrcLang, sysTgtLang, track;
            var chooseSet = document.getElementsByName("chooseSet");
            for (var i = 0; i < chooseSet.length; i++) {
                if (chooseSet[i].checked == true) {
                    document.getElementById("setId").value = chooseSet[i].value;
                    break;
                }
            }

            if (i == chooseSet.length) {
                alert("You have not chosen a Test Set!");
                return false;
            }
            var obj = document.getElementsByName("setSrcLang");
            setSrcLang = obj[i].options[obj[i].selectedIndex].value;
            obj = document.getElementsByName("setTgtLang");
            setTgtLang = obj[i].options[obj[i].selectedIndex].value;
            obj = document.getElementsByName("setTrack");
            track = obj[i].options[obj[i].selectedIndex].value;

            var chooseSys = document.getElementsByName("chooseSys");
            for (var j = 0; j < chooseSys.length; j++) {
                if (chooseSys[j].checked == true) {
                    document.getElementById("sysId").value = chooseSys[j].value;
                    break;
                }
            }
            if (j == chooseSys.length) {
                alert("You have not chosen a system!");
                return false;
            }

            obj = document.getElementsByName("sysSrcLang");
            sysSrcLang = obj[j].textContent;
            obj = document.getElementsByName("sysTgtLang");
            sysTgtLang = obj[j].textContent;

            if (setSrcLang != sysSrcLang || setTgtLang != sysTgtLang) {
                alert("Language mismatch!");
                return false;
            } else {
                document.getElementById("srcLang").value = setSrcLang;
                document.getElementById("tgtLang").value = setTgtLang;
                document.getElementById("track").value = track;
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

                        <li id="addSys">
                            <a href="/system/new">添加系统</a>
                        </li>

                        <li id="submit" class="active">
                            <a href="#">提交测试</a>
                        </li>

                        <li id="history">
                            <a href="/submit/history">历史提交</a>
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
            <form class="form-horizontal" role="form" method="post" onsubmit="return checkForm()">

                <fieldset>
                    <legend>选择测试集</legend>
                    <table class="table table-hover table-striped">
                        <thead>
                        <tr>
                            <th></th>
                            <th>Name</th>
                            <th>Origin</th>
                            <th>Domain</th>
                            <th>Citation</th>
                            <th>Notes</th>
                            <th>Source Language</th>
                            <th>Target Language</th>
                            <th>Track</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.testSetList}" var="testSet">
                            <tr name="setRow">
                                <td><input type="radio" name="chooseSet" value="${testSet.testsetid}"></td>
                                <td>${testSet.name}</td>
                                <td>${testSet.origin}</td>
                                <td>${testSet.domain}</td>
                                <td>${testSet.citation}</td>
                                <td>${testSet.notes}</td>
                                <td><select class="selectpicker" name="setSrcLang">
                                    <option value="CS">CS</option>
                                    <option value="EN">EN</option>
                                    <option value="MG">MG</option>
                                </select></td>
                                <td><select class="selectpicker" name="setTgtLang">
                                    <option value="CS">CS</option>
                                    <option value="EN">EN</option>
                                    <option value="MG">MG</option>
                                </select></td>
                                <td><select class="selectpicker" name="setTrack">
                                    <option value="CE">CE</option>
                                    <option value="EC">EC</option>
                                    <option value="MC">MC</option>
                                    <option value="TC">TC</option>
                                    <option value="UC">UC</option>
                                    <option value="JE">JE</option>
                                </select></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </fieldset>

                <fieldset>
                    <legend>选择您的系统</legend>
                    <table class="table table-hover table-striped" id="systemTable">
                        <thead>
                        <tr>
                            <th></th>
                            <th>Name</th>
                            <th>Software</th>
                            <th>Source Language</th>
                            <th>Target Language</th>
                            <th>Citation</th>
                            <th>Notes</th>
                            <th>Constraint System</th>
                            <th>Primary System</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach items="${requestScope.systemList}" var="system">
                            <tr name="sysRow">
                                <td><input type="radio" name="chooseSys" value="${system.systemid}"></td>
                                <td>${system.name}</td>
                                <td>${system.software}</td>
                                <td name="sysSrcLang">${system.sourcelang}</td>
                                <td name="sysTgtLang">${system.targetlang}</td>
                                <td>${system.citation}</td>
                                <td>${system.notes}</td>
                                <td>${system.isConstraint}</td>
                                <td>${system.isPrimary}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <div align="right">
                        <!-- 除了IE,所有浏览器button 的默认type="submit" -->
                        <button class="btn btn-default" type="button" onclick="window.location.href='/system/new'">创建新系统</button>
                        <button type="submit" class="btn btn-primary">下一步</button>
                    </div>
                </fieldset>


                <input type="hidden" id="setId" name="setId"/>
                <input type="hidden" id="sysId" name="sysId"/>
                <input type="hidden" id="srcLang" name="srcLang"/>
                <input type="hidden" id="tgtLang" name="tgtLang"/>
                <input type="hidden" id="track" name="track"/>
            </form>
        </div>
    </div>

</div>

</body>
</html>
