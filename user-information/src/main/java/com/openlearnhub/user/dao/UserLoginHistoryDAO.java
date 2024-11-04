package com.openlearnhub.user.dao;

import com.openlearnhub.user.model.UserLoginHistory;
import com.openlearnhub.user.util.DatabaseConnector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;

public class UserLoginHistoryDAO {

    private static final Logger logger = Logger.getLogger(UserLoginHistoryDAO.class.getName());

    public int insert(UserLoginHistory model) {
        int count = 0;
        String sql = "INSERT INTO user_login_history"
                + "(user_id, ip_address, operating_system, browser, time_login, client) VALUES (?,?,?,?,?,?)";
        try (Connection connection = DatabaseConnector.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, model.getUserId());
            statement.setString(2, model.getIpAddress());
            statement.setString(3, model.getOperatingSystem());
            statement.setString(4, model.getBrowser());
            statement.setTimestamp(5, model.getTimeLogin());
            statement.setString(6, model.getClient());
            count = statement.executeUpdate();

        } catch (SQLException e) {
            logger.severe("Error insert user login history: " + e);
        }
        return count;
    }

    public boolean isExist(String userId, String ipAddress, String os, String browser,
                           String clientName) {
        String sql = "SELECT 1 FROM user_login_history "
                + "WHERE user_id = ? AND ip_address = ? AND operating_system = ? AND browser = ? AND client = ? "
                + "LIMIT 1";
        try (Connection connection = DatabaseConnector.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, userId != null ? userId : "");
            statement.setString(2, ipAddress != null ? ipAddress : "");
            statement.setString(3, os != null ? os : "");
            statement.setString(4, browser != null ? browser : "");
            statement.setString(5, clientName != null ? clientName : "");
            try (ResultSet result = statement.executeQuery()) {
                return result.next();
            }
        } catch (SQLException e) {
            logger.severe("Error check exist user login history: " + e);
        }

        return false;
    }
}
