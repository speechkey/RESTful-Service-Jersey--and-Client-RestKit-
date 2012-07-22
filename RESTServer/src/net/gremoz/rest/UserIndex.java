package net.gremoz.rest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import net.gremoz.rest.User;

/**
 * @author Artem Grebenkin
 */
public class UserIndex {

    public List<User> getAll() {
        List<User> userList = new ArrayList<User>();
        Connection c = null;
        String sql = "SELECT * FROM users ORDER BY name";
        try {
            c = ConnectionHelper.getConnection();
            Statement s = c.createStatement();
            ResultSet rs = s.executeQuery(sql);

            while (rs.next()) {
                userList.add(mapUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } finally {
            ConnectionHelper.close(c);
        }
        return userList;
    }

    public List<User> getById(int id) {
        List<User> userList = new ArrayList<User>();

        Connection c = null;
        String sql = "SELECT * FROM users " +
                     "WHERE id = ?";

        try {
            c = ConnectionHelper.getConnection();
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                userList.add(mapUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } finally {
            ConnectionHelper.close(c);
        }
        return userList;
    }

    public List<User> create(User user) {
        List<User> userList = new ArrayList<User>();
        Connection c = null;
        PreparedStatement ps = null;
        try {
            c = ConnectionHelper.getConnection();

            ps = c.prepareStatement("INSERT INTO users " +
                                    "(name, about, photo) " +
                                    "VALUES (?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, user.getName());
            ps.setString(2, user.getAbout());
            ps.setString(3, user.getPhoto());

            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();

            rs.next();
            int id = rs.getInt(1);
            user.setId(id);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } finally {
            ConnectionHelper.close(c);
        }
        userList.add(user);
        return userList;
    }

    public List<User> update(User user) {
        List<User> userList = new ArrayList<User>();
        Connection c = null;
        try {
            c = ConnectionHelper.getConnection();

            PreparedStatement ps = c.prepareStatement("UPDATE users " +
                                                      "SET name=?, about=?, photo=? " +
                                                      "WHERE id=?");
            ps.setString(1, user.getName());
            ps.setString(2, user.getAbout());
            ps.setString(3, user.getPhoto());
            ps.setInt(4, user.getId());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } finally {
            ConnectionHelper.close(c);
        }
        userList.add(user);
        return userList;
    }

    public boolean remove(int id) {
        Connection c = null;
        try {
            c = ConnectionHelper.getConnection();

            PreparedStatement ps = c.prepareStatement("DELETE FROM users WHERE id=?");
            ps.setInt(1, id);
            int count = ps.executeUpdate();

            return count == 1;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } finally {
            ConnectionHelper.close(c);
        }
    }

    protected User mapUser(ResultSet rs) throws SQLException {
        User user = new User();

        user.setId(rs.getInt("id"));
        user.setName(rs.getString("name"));
        user.setAbout(rs.getString("about"));
        user.setPhoto(rs.getString("photo"));

        return user;
    }
    
}
