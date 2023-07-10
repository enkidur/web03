<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    String memberID = request.getParameter("memberID");
    String name = request.getParameter("name");

    int updateCount = 0;

    Class.forName("org.mariadb.jdbc.Driver");

    Connection conn = null;
    Statement stmt = null;

    try {
        String jdbcDriver = "jdbc:mariadb://localhost:3306/chap14?" +
                "useUnicode=true&characterEncoding=utf8";
        String dbUser = "lee";
        String dbpw = "1234";

        String query = "UPDATE member SET NAME=" +
                "'"+ name +"'" + " WHERE MEMBERID =" + "'"+memberID+"'";
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbpw);
        stmt = conn.createStatement();
        updateCount = stmt.executeUpdate(query);
    } catch (SQLException e) {
      out.print(e);
    } finally {
        if (stmt != null) try {
            stmt.close();
        } catch (SQLException e) {
        }
        if (conn != null) try {
            conn.close();
        } catch (SQLException e) {
        }

    }
%>
<html>
<head>
    <title>이름 변경</title>
</head>
<body>
<% if(updateCount>0){%>
<%=memberID%> 의 이름을 <%=name%> (으)로 변경
<%}else{%>
<%=memberID%>가 존재 하지 않음.
<%}%>
</body>
</html>
