package com.openlearnhub.riskbase.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnector {

    private static final Logger logger = LoggerFactory.getLogger(DatabaseConnector.class);

    private DatabaseConnector() {
    }

    public static Connection getConnection() throws SQLException {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection("jdbc:mysql://mysql_db:3306/smart_feed",
                    "root", "root");
            logger.info("Connection to database successful");
        } catch (Exception e) {
            logger.error("Database connection error: ", e);
        }
        return connection;
    }
}

