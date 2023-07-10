<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-07-10
  Time: 오후 1:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>이름변경폼</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/ch14/Oracle/update.jsp">
    <table border="1">
        <tr>
            <td>
                아이디
            </td>
            <td>
                <input type="text" name="memberID" SIZE="10">
            </td>
            <td>
                이름
            </td>
            <td>
                <input type="text" name="name" size="10">
            </td>
        </tr>
        <tr>
            <td colspan="4"> <input type="submit" value="변경"></td>
        </tr>
    </table>
</form>
</body>
</html>
