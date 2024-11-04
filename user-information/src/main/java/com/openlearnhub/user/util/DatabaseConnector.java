package com.openlearnhub.user.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DatabaseConnector {

    private static final Logger logger = Logger.getLogger(DatabaseConnector.class.getName());

    private DatabaseConnector() {
    }

    public static Connection getConnection() throws SQLException {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection("jdbc:postgresql://postgres/user_service?stringtype=unspecified",
                    "postgres", "postgres");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Database connection error: ", e);
        }
        return connection;
    }
}
