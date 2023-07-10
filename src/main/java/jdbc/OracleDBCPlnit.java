package jdbc;
import java.sql.DriverManager;
import java.util.Properties;

import org.apache.commons.dbcp2.*;
import org.apache.commons.pool2.impl.GenericObjectPool;
import org.apache.commons.pool2.impl.GenericObjectPoolConfig;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;


public class OracleDBCPlnit extends HttpServlet{
    @Override
    public void init() throws ServletException{
        loadJDBCDriver();
        initConnectionPool();
    }
    public void loadJDBCDriver(){
        try {
            Class.forName("oracle.jdbc.OracleDriver");
            System.out.println("Oracle 드라이버 로딩 성공");
        } catch (ClassNotFoundException e) {
            System.out.println("Oracle 드라이버 로딩 실패");
            throw new RuntimeException("fail to load JDBC Driver", e);
        }
    }

    private void initConnectionPool() {
        try {
            String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:XE/HR?" +
                    "useUnicode=true&characterEncoding=utf8";
            String dbUser = "hr";
            String dbpw = "1234";

            ConnectionFactory connFactory = new DriverManagerConnectionFactory(jdbcUrl, dbUser, dbpw);
            PoolableConnectionFactory poolableConnFactory = new PoolableConnectionFactory(connFactory, null);
            poolableConnFactory.setValidationQuery("select 1");

            //커넥션 풀의 설정 정보를 생성함.
            GenericObjectPoolConfig poolConfig = new GenericObjectPoolConfig();
            poolConfig.setTimeBetweenEvictionRunsMillis(1000L * 60L * 5L); //유휴 커넥션 검사 주기설정.
            poolConfig.setTestWhileIdle(true); //풀에 보관중이 커넥션이 유효한지 검사할지 여부
            poolConfig.setMaxIdle(4); //커넥션 최소 개수
            poolConfig.setMaxTotal(50); //커넥션 최대 개수

            //커넥션 풀 생성
            GenericObjectPool<PoolableConnection> connectionPool =
                    new GenericObjectPool<>(poolableConnFactory, poolConfig);
            poolableConnFactory.setPool(connectionPool);

            Class.forName("org.apache.commons.dbcp2.PoolingDriver");
            System.out.println("풀링 드라이버 로딩");
            PoolingDriver driver = (PoolingDriver) DriverManager.getDriver("jdbc:apache:commons:dbcp:");
            driver.registerPool("chap14", connectionPool);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
