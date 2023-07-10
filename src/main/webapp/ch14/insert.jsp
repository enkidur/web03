<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    String memberID = request.getParameter("memberID");
    String password = request.getParameter("password");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
%>

<%

  //  Class.forName("org.mariadb.jdbc.Driver");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try{
        String jdbcDriver = "jdbc:mariadb://localhost:3306/chap14?" +
                "useUnicode=true&characterEncoding=utf8";
        String dbUser = "lee";
        String dbpw = "1234";

        conn = DriverManager.getConnection(jdbcDriver,dbUser,dbpw);
        pstmt = conn.prepareStatement("insert into member values (?,?,?,?)");
        pstmt.setString(1,memberID);
        pstmt.setString(2,password);
        pstmt.setString(3,name);
        pstmt.setString(4,email);

        pstmt.executeUpdate();

    }finally {
        if(pstmt != null)try {
            pstmt.close();
        }catch (SQLException e){}

        if(conn != null)try{
            conn.close();
        }catch (SQLException e){}
    }
%>
<html>
<head>
    <title>삽입</title>
</head>
<body>
Member테이블에 새로운 레코드를 삽입 하였습니다.
</body>
</html>
