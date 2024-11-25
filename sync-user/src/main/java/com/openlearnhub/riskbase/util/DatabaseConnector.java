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
            connection = DriverManager.getConnection("jdbc:postgresql:/postgres/shop_sport?currentSchema=user_service",
                    "postgres", "postgres");

            logger.info("Connection to database successful");
        } catch (Exception e) {
            logger.error("Database connection error: ", e);
        }
        return connection;
    }
}

