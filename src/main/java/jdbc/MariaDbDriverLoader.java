package jdbc;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

public class MariaDbDriverLoader extends HttpServlet {
    public void init(ServletConfig config) throws ServletException{
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            System.out.println("MariaDb 드라이버 로딩 성공");
        } catch (ClassNotFoundException e) {
            System.out.println("MariaDb 드라이버 로딩 실패");
            throw new RuntimeException(e);
        }

    }
}
