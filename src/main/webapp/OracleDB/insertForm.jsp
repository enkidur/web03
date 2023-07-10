<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-07-10
  Time: 오후 3:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>member 테이블 레코드 삽입.</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/ch14/Oracle/insert.jsp" method="post">
  <table border="1">
    <tr>
      <td>아이디</td>
      <td><input type="text" name="memberID" size="10"></td>
      <td>암호</td>
      <td><input type="text" name="password" size="10"></td>
    </tr>
    <tr>
      <td>이름</td>
      <td><input type="text" name="name" size="10"></td>
      <td>이메일</td>
      <td><input type="text" name="email" size="10"></td>
    </tr>
    <tr>
      <td colspan="4"><input type="submit" value="삽입"></td>
    </tr>
  </table>
</form>
</body>
</html>
