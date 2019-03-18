<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>HIT MT WEB</title>
    <script src="${pageContext.request.contextPath}/statics/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/statics/css/local.css"/>
    <script type="text/javascript">


        function getLeaderBoard() {

            var track = document.getElementById("track").value;
            var metric = document.getElementById("metric").value;

            var data;
            $.ajax(
                {
                    type: 'get',
                    url: '${pageContext.request.contextPath}/leaderboard/' + track + "/" + metric,
                    success: function (result) {
                        for (var i = 0; i < result.length; i++) {
                            data += '<tr>' +
                                '<td>' + result[i].time + '</td>' +
                                '<td>' + result[i].systemName + '</td>' +
                                '<td>' + result[i].testset + '</td>' +
                                '<td>' + result[i].notes + '</td>' +
                                /*'<td>' + result[i].srclang + '</td>' +
                                '<td>' + result[i].tgtlang + '</td>' +*/
                                '<td>' + result[i].BLEU_SBP + '</td>' +
                                '<td>' + result[i].BLEU_NIST + '</td>' +
                                '<td>' + result[i].TER + '</td>' +
                                '<td>' + result[i].METEOR + '</td>' +
                                '<td>' + result[i].NIST + '</td>' +
                                '<td>' + result[i].GTM + '</td>' +
                                '<td>' + result[i].mWER + '</td>' +
                                '<td>' + result[i].mPER + '</td>' +
                                '<td>' + result[i].ICT + '</td>' +
                                '</tr>'
                        }
                        //清空上次数据
                        $("#leaderBoard tbody tr:not(:first)").html("");
                        //将查询出来的数据插入
                        $("#leaderBoard #firstTr").after(data);
                    }
                }
            )
        }

    </script>
</head>
<body>
<div align="center" style="width: 80%;text-align: center;margin-left: 10%">
    <h2>Welcome to HIT MT Eval Web!</h2>
    <div align="right"><a href="/user/login">login</a></div>
    <div align="left"><h3>Latest News</h3>
        <table>
            <tr>
                <td>XXXXXXX</td>
            </tr>
            <tr>
                <td>XXXXXXX</td>
            </tr>
            <tr>
                <td>XXXXXXX</td>
            </tr>
            <tr>
                <td>XXXXXXX</td>
            </tr>
        </table>
    </div>
    <div align="left">
        <h3>Leader Board</h3>
        <label for="track">Select Track:</label>
        <select id="track" name="track" onchange="getLeaderBoard()" style="margin-right: 20px">
            <option value="CE">CE</option>
            <option value="EC">EC</option>
            <option value="TC">TC</option>
        </select>
        <label for="metric">Select Metric:</label>
        <select id="metric" name="metric" onchange="getLeaderBoard()">
            <option value="BLEU_SBP">BLEU_SBP</option>
            <option value="BLEU_NIST">BLEU_NIST</option>
            <option value="TER">TER</option>
            <option value="METEOR">METEOR</option>
            <option value="NIST">NIST</option>
            <option value="GTM">GTM</option>
            <option value="mWER">mWER</option>
            <option value="mPER">mPER</option>
            <option value="ICT">ICT</option>
        </select>
        <table class="gridtable" id="leaderBoard" style="margin-top: 20px">

            <tr id="firstTr">
                <th>Time</th>
                <th>System</th>
                <th>TestSet</th>
                <th>Run Notes</th>
                <%--<th>Source language</th>
                <th>Target language</th>--%>
                <th>BLEU_SBP</th>
                <th>BLEU_NIST</th>
                <th>TER</th>
                <th>METEOR</th>
                <th>NIST</th>
                <th>GTM</th>
                <th>mWER</th>
                <th>mPER</th>
                <th>ICT</th>
            </tr>
            <c:forEach items="${resultList}" var="submission">
                <tr>
                    <td>${submission.time}</td>
                    <td>${submission.systemName}</td>
                    <td>${submission.testset}</td>
                    <td>${submission.notes}</td>
                    <td>${submission.BLEU_SBP}</td>
                    <td>${submission.BLEU_NIST}</td>
                    <td>${submission.TER}</td>
                    <td>${submission.METEOR}</td>
                    <td>${submission.NIST}</td>
                    <td>${submission.GTM}</td>
                    <td>${submission.MPER}</td>
                    <td>${submission.MPER}</td>
                    <td>${submission.ICT}</td>
                </tr>
            </c:forEach>

        </table>
    </div>


</div>
</body>
</html>
