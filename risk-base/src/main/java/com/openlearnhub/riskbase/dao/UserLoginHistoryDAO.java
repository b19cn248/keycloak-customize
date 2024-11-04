package com.openlearnhub.riskbase.dao;

import com.openlearnhub.riskbase.model.UserLoginHistory;
import com.openlearnhub.riskbase.util.DatabaseConnector;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class UserLoginHistoryDAO {

    private static final Logger logger = Logger.getLogger(UserLoginHistoryDAO.class.getName());

    public List<UserLoginHistory> getLoginHistoryList(String userId, String clientName) {
        List<UserLoginHistory> listInfoUserLogin = new ArrayList<>();
        String sql = "SELECT user_id, ip_address, operating_system, browser, client FROM user_login_history "
                + "WHERE client = ? AND user_id = ? "
                + "GROUP BY user_id, ip_address, operating_system, browser, client ";
        try (Connection connection = DatabaseConnector.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, clientName);
            statement.setString(2, userId);
            try (ResultSet result = statement.executeQuery()) {
                while (result.next()) {
                    UserLoginHistory infoUserLogin = UserLoginHistory.builder()
                            .userId(result.getString("user_id"))
                            .ipAddress(result.getString("ip_address"))
                            .operatingSystem(result.getString("operating_system"))
                            .browser(result.getString("browser"))
                            .client(result.getString("client"))
                            .build();
                    listInfoUserLogin.add(infoUserLogin);
                }
            }
        } catch (SQLException e) {
            logger.severe("Error get login history list: " + e);
        }

        return listInfoUserLogin;
    }
}
