<%--
  Created by IntelliJ IDEA.
  User: 10297
  Date: 2019/2/25
  Time: 16:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>New System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/statics/css/local.css"/>
    <script language="JavaScript">
        function logout() {
            if (window.confirm('Are you sure to log out?') == true) {
                window.location.href = '/user/logout'
            }
        }

        function checkForm() {
            var name = document.getElementById("sysname").value
            if(name==null||name==""){
                alert("Name must not be null")
                return false
            }else{
                return true
            }
        }
    </script>
    <style type="text/css">
        p {
            margin: 10px;
            font-size:small;
        }
    </style>
</head>
<body>
<div>
    <ul>
        <li><a href="/user/status">主页</a></li>
        <li><a class="active" href="/system/new">添加系统</a></li>
        <li><a href="/system/user_list">系统列表</a></li>
        <li><a href="/test_sets/list">测试集</a> </li>
        <li><a href="/submit/frame">提交测试</a></li>

        <li style="float: right"><a href="javascript:void(0)" onclick="logout()">登出</a></li>
        <li style="float:right"><a href="/user/edit/${username}">修改信息</a></li>
    </ul>
</div>
<div >
    <h2>New System</h2>
    <form method="post" onsubmit="return checkForm()">
        <p>
            <label for="sysname">Name</label><br/>
            <input type="text" id="sysname" name="name"/>
        </p>
        <div>
            <p>
                <input type="checkbox" id="isConstraint" name="isConstraint">
                <label for="isConstraint">Tick if this is constraint system</label>
            </p>

            <p>
                <input type="checkbox" id="isPrimary" name="isPrimary">
                <label for="isPrimary">Tick if this is primary submission</label>
            </p>
        </div>
        <p>
            <label for="software">Software</label><br/>
            <input type="text" id="software" name="software"/>
        </p>

        <p>
            <label for="sourceLang">Source Language</label><br/>
            <select id="sourceLang" name="sourcelang">
                <option value="CS">CS</option>
                <option value="EN">EN</option>
                <option value="MG">MG</option>
            </select>
        </p>
        <p>
            <label for="targetLang">Target Language</label><br/>
            <select id="targetLang" name="targetlang">
                <option value="CS">CS</option>
                <option value="EN">EN</option>
                <option value="MG">MG</option>
            </select>
        </p>
        <p>
            <label for="citation">Citation</label><br/>
            <input type="text" id="citation" name="citation"/>
        </p>
        <p>
            <label for="website">Website</label><br/>
            <input type="text" id="website" name="website"/>
        </p>
        <p>
            <label for="notes">Notes</label><br/>
            <textarea name="notes" id="notes" cols="30" rows="10"></textarea>
        </p>
        <div >
            <p>
                <input  type="submit" value="Create">
            </p>
        </div>

    </form>
</div>

</body>
</html>
