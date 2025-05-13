package com.openlearnhub.riskbase.authenticator;

import org.keycloak.events.Event;
import org.keycloak.events.EventListenerProvider;
import org.keycloak.events.EventType;
import org.keycloak.events.admin.AdminEvent;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.UserModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Timestamp;

public class SyncEventListener implements EventListenerProvider {

    private static final Logger logger = LoggerFactory.getLogger(SyncEventListener.class);

    private final KeycloakSession session;

    public SyncEventListener(KeycloakSession session) {
        this.session = session;
    }

    @Override
    public void onEvent(Event event) {
        // Chỉ xử lý sự kiện đăng ký (REGISTER)
        if (event.getType() == EventType.REGISTER) {
            try {
                // Lấy UserModel dựa trên userId từ sự kiện
                String userId = event.getUserId();
                UserModel user = session.users().getUserById(session.getContext().getRealm(), userId);

                // Lấy thông tin từ UserModel
                String email = user.getEmail();
                String username = user.getUsername();
                String name = (user.getFirstName() != null ? user.getFirstName() : "") +
                        (user.getLastName() != null ? " " + user.getLastName() : "");
                name = name.trim();

                // Kết nối tới MySQL database
                String url = "jdbc:mysql://mysql_db:3306/smart_feed";
                String dbUser = "root";
                String dbPassword = "root";

                try (Connection conn = DriverManager.getConnection(url, dbUser, dbPassword)) {
                    // SQL insert phù hợp với cấu trúc bảng mới
                    String sql = "INSERT INTO users (email , name, username, created_at, updated_at, " +
                            "created_by, updated_by, is_deleted, points, settings_id, read_later_list_id, subscription_id) " +
                            "VALUES (?, ? , ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                    try (PreparedStatement stmt = conn.prepareStatement(sql)) {

                        Timestamp currentTime = new Timestamp(System.currentTimeMillis());
                        stmt.setString(1, email); // email
                        stmt.setString(2, name); // name - kết hợp firstName và lastName
                        stmt.setString(3, username); // username
                        stmt.setTimestamp(4, currentTime); // created_at
                        stmt.setTimestamp(5, currentTime); // updated_at
                        stmt.setString(6, "KEYCLOAK"); // created_by
                        stmt.setString(7, "KEYCLOAK"); // updated_by
                        stmt.setInt(8, 0); // is_deleted - 0 = false
                        stmt.setLong(9, 0); // points - default 0
                        stmt.setLong(10, 1L); // settings_id = 1
                        stmt.setLong(11, 1L); // read_later_list_id = 1
                        stmt.setLong(12, 1L); // subscription_id = 1

                        stmt.executeUpdate();
                        logger.info("Successfully synced user {} to MySQL database", userId);
                    }
                }
            } catch (Exception e) {
                logger.error("Error while syncing user to MySQL database: ", e);
            }
        }
    }

    @Override
    public void onEvent(AdminEvent adminEvent, boolean b) {
        // Không xử lý admin event
    }

    @Override
    public void close() {
        // Cleanup nếu cần
    }
}