<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String idValue = request.getParameter("id");

    Connection conn = null;
    PreparedStatement pstmtItem = null;
    PreparedStatement pstmtDetail = null;

    String jdbcDriver = "jdbc:mariadb://localhost:3306/chap14?" +
            "useUnicode=true&characterEncoding=utf8";
    String dbUser = "";
    String dbpw = "";

    Throwable occuredExecption = null;

    try {
        int id = Integer.parseInt(idValue);
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbpw);

        //트렌젝션시작
        conn.setAutoCommit(false);

        pstmtItem = conn.prepareStatement("insert into ITEM VALUES (?,?)");
        pstmtItem.setInt(1, id);
        pstmtItem.setString(2, "상품 이름 " + id);
        pstmtItem.executeUpdate();

        if (request.getParameter("error") != null) {
            throw new Exception("의도적 익셉션 발생");
        }

        pstmtDetail = conn.prepareStatement("insert into ITEM_DETAIL VALUES (?,?)");
        pstmtDetail.setInt(1, id);
        pstmtDetail.setString(2, "상세 설명 " + id);
        pstmtDetail.executeUpdate();

        conn.commit();

    } catch (Throwable throwable) {
      if (conn != null) {
        try {
          conn.rollback();
        } catch (SQLException e) {}
      }
      occuredExecption = throwable;
    }finally {
      if(pstmtItem != null)try {
        pstmtItem.close();
      }catch (SQLException e){}
      if(pstmtDetail != null)try{
        pstmtDetail.close();
      }catch (SQLException e){}
    }
%>
<html>
<head>
    <title>Item 값 입력</title>
</head>
<body>
<% if(occuredExecption != null){%>
에러가 발생 : <%=occuredExecption.getMessage()%>
<%}else{%>
데이터가 성공적으로 들어감.
<%}%>
</body>
</html>
