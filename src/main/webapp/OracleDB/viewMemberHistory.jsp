<%@ page import="java.io.Reader" %>
<%@ page import="java.io.StringReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String memberID = request.getParameter("memberID");
%>
<html>
<head>
    <title>회원 정보</title>
</head>
<body>
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:";
        String dbUser = "hr";
        String dbpw = "1234";

        String query = "select * from member_history " + "where memberid = '" + memberID + "'";
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbpw);
        stmt = conn.createStatement();
        rs = stmt.executeQuery(query);

        if (rs.next()) {
%>
<table border="1">
    <tr>
        <td>아이디</td>
        <td><%=memberID%>
        </td>
    </tr>
    <tr>
        <td>히스토리</td>
        <td>
            <%
                String history = null;
                Reader reader = null;
                try {
                    reader = rs.getCharacterStream("HISTORY");

                    if (reader != null) {
                        StringBuffer stringBuffer = new StringBuffer();
                        char[] ch = new char[512];
                        int len = -1;

                        while ((len = reader.read(ch)) != -1) {
                            stringBuffer.append(ch, 0, len);
                        }
                        history = stringBuffer.toString();
                    }
                } catch (IOException ie) {
                    out.println("익셉션발생:" + ie.getMessage());
                } finally {
                    if (reader != null) try {
                        reader.close();
                    } catch (IOException ie) {
                    }
                }
            %>
            <%=history%>
        </td>
    </tr>
</table>
<%
} else {
%>
<%=memberID%> 회원의 히스토리가 없습니다.
<%
    }
  }catch (SQLException SE) {
  %>
에러발생: <%=SE.getMessage()%>
    <%}finally {
      if(rs != null)try {
        rs.close();
      }catch (SQLException SE){}

      if(stmt != null)try {
        stmt.close();
      }catch (SQLException SE){}
      if(conn != null)try {
        conn.close();
      }catch (SQLException SE){}
    }
%>
</body>
</html>