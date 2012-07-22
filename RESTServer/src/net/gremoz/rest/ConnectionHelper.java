package net.gremoz.rest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;
/**
 *
 * @author Artem Grebenkin
 *
 */
public class ConnectionHelper
{
	private String url;
	private static ConnectionHelper instance;

	private ConnectionHelper()
	{
    	String driver = null;
    	String host = null;
    	String username = null;
    	String password = null;
    	String db = null;

    	try {
    		Class.forName("com.mysql.jdbc.Driver");
    		url = "jdbc:mysql://localhost/directory?user=root";
            ResourceBundle bundle = ResourceBundle.getBundle("users");
            driver = bundle.getString("jdbc.driver");
            host = bundle.getString("jdbc.host");
            username = bundle.getString("jdbc.username");
            password = bundle.getString("jdbc.password");
            db = bundle.getString("jdbc.db");

            Class.forName(driver);
            url = "jdbc:mysql://" + host + "/" + db +"?user=" + username + "&password=" + password;

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static Connection getConnection() throws SQLException {
		if (instance == null) {
			instance = new ConnectionHelper();
		}
		try {
			return DriverManager.getConnection(instance.url);
		} catch (SQLException e) {
			throw e;
		}
	}
	
	public static void close(Connection connection)
	{
		try {
			if (connection != null) {
				connection.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}