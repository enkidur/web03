<%@ page import="java.sql.*" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String memberID = request.getParameter("memberID");
%>
<html>
<head>
    <title>회원목록</title>
</head>
<body>
member 테이블 내용
<%
    int i = 0;
    ResultSet resultSet = null;
    Statement statement = null;
    Connection conn = null;
    try {
        Class.forName("org.mariadb.jdbc.Driver");

        conn = null;
        statement = null;
        resultSet = null;

        String jdbcDriver = "jdbc:mariadb://localhost:3306/chap14?" +
                "useUnicode=true&characterEncoding=utf8";
        String dbUser = "lee";
        String dbpw = "1234";

        String query = "select * from member where MEMBERID = " + "'" + memberID + "'";

        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbpw);
        statement = conn.createStatement();
        resultSet = statement.executeQuery(query);

        if (resultSet.next()) {%>
<table border="1">
    <tr>
        <td>아이디</td>
        <td><%=memberID%>
        </td>
    </tr>
    <tr>
        <td>암호</td>
        <td><%=resultSet.getString("PASSWORD")%>
        </td>
    </tr>
    <tr>
        <td>이름</td>
        <td><%=resultSet.getString("NAME")%>
        </td>
    </tr>
    <tr>
        <td>이메일</td>
        <td><%=resultSet.getString("EMAIL")%>
        </td>
    </tr>
</table>

<% } else { %>

<%=memberID%>에 해당하는 정보가 존재하지 않습니다.
<%
    }
} catch (SQLException e) {%>
에러발생 :<%=e.getMessage()%>
<%
    } finally {
        if (resultSet != null) try {
            resultSet.close();
        } catch (SQLException e) {
        }
        if (statement != null) try {
            statement.close();
        } catch (SQLException e) {
        }
        if (conn != null) try {
            conn.close();
        } catch (SQLException e) {
        }

    }
%>
</body>
</html>
