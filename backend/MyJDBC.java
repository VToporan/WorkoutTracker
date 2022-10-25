import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class MyJDBC {
    public static void main(String[] args) {
        try {

            Connection connection = DriverManager.getConnection("url", "user", "password");

            Statement statement = connection.createStatement();

            ResultSet resultSet = statement.executeQuery("select * from users");

            while (resultSet.next()) {
                System.out.println(resultSet.getString("firstname"));
            }

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
