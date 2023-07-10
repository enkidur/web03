<%@ page import="java.sql.*" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>회원목록</title>
</head>
<body>
member 테이블 내용
<table width="100%" border="1">
    <tr>
        <td>이름</td>
        <td>아이디</td>
        <td>이메일</td>
    </tr>
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
            String dbUser = "";
            String dbpw = "";

            String query = "select * from member order by memberid";

            conn = DriverManager.getConnection(jdbcDriver, dbUser, dbpw);
            statement = conn.createStatement();
            resultSet = statement.executeQuery(query);

            while (resultSet.next()) {%>
    <tr>
        <td><%=resultSet.getString("NAME")%>
        </td>
        <td><%=resultSet.getString("MEMBERID")%>
        </td>
        <td><%=resultSet.getString("EMAIL")%>
        </td>
    </tr>

    <%
            }
        } catch (SQLException e) {
            out.print(e);
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
</table>
</body>
</html>
