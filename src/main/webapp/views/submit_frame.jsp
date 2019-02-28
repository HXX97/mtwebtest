<%--
  Created by IntelliJ IDEA.
  User: 10297
  Date: 2019/2/28
  Time: 1:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Submit:Frame</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/statics/css/local.css"/>
    <script language="JavaScript">
        function logout() {
            if (window.confirm('Are you sure to log out?') == true) {
                window.location.href = '/user/logout'
            }
        }

        function checkForm() {
            var setSrcLang, setTgtLang, sysSrcLang, sysTgtLang;
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
            }

            return true;

        }
    </script>
</head>
<body>
<div>
    <ul>
        <li><a href="/user/status">主页</a></li>
        <li><a href="/system/new">添加系统</a></li>
        <li><a href="/system/user_list">系统列表</a></li>
        <li><a href="/test_sets/list">测试集</a></li>
        <li><a class="active" href="#">提交测试</a></li>


        <li style="float: right"><a href="javascript:void(0)" onclick="logout()">登出</a></li>
        <li style="float: right"><a href="/user/edit/${username}">修改信息</a></li>
    </ul>
</div>

<h2>Submit:Frame</h2>
<form method="post" onsubmit="return checkForm()">
    <div align="center">
        <table class="gridtable" id="testSetTable" style="margin-top: 20px">
            <caption style="text-align: left;font-size: large">Choose TestSet</caption>
            <tr>
                <th></th>
                <th>Name</th>
                <th>Origin</th>
                <th>Domain</th>
                <th>Citation</th>
                <th>Notes</th>
                <th>Source Language</th>
                <th>Target Language</th>
            </tr>
            <c:forEach items="${requestScope.testSetList}" var="testSet">
                <tr name="setRow">
                    <td><input type="radio" name="chooseSet" value="${testSet.testsetid}"></td>
                    <td>${testSet.name}</td>
                    <td>${testSet.origin}</td>
                    <td>${testSet.domain}</td>
                    <td>${testSet.citation}</td>
                    <td>${testSet.notes}</td>
                    <td><select name="setSrcLang">
                        <option value="CS">CS</option>
                        <option value="EN">EN</option>
                        <option value="MG">MG</option>
                    </select></td>
                    <td><select name="setTgtLang">
                        <option value="CS">CS</option>
                        <option value="EN">EN</option>
                        <option value="MG">MG</option>
                    </select></td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <div align="center">
        <%-- <label for="systemTable" style="float: left">Choose Your System</label><br/>--%>

        <table class="gridtable" id="systemTable" style="margin-top: 20px">
            <caption style="text-align: left;font-size: large">Choose System</caption>
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
        </table>
        <div style="width:80%;margin-top: 10px">
            <input type="submit" value="Proceed" style="float: right"/>
        </div>

    </div>

    <input type="hidden" id="setId" name="setId"/>
    <input type="hidden" id="sysId" name="sysId"/>
    <input type="hidden" id="srcLang" name="srcLang"/>
    <input type="hidden" id="tgtLang" name="tgtLang"/>
</form>

</body>
</html>
