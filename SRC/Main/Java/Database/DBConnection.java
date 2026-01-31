package Database;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    protected static String URL = "jdbc:postgresql://127.0.0.1:5432/websitePerumahan";
    protected static String USER = "postgres";
    protected static String PASS = "*******";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("org.postgresql.Driver");
        return DriverManager.getConnection(URL, USER, PASS);
    }
}