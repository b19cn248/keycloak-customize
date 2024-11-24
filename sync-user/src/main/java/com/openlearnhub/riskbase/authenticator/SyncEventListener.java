package com.openlearnhub.riskbase.authenticator;

import com.openlearnhub.riskbase.util.DatabaseConnector;
import org.keycloak.events.Event;
import org.keycloak.events.EventListenerProvider;
import org.keycloak.events.EventType;
import org.keycloak.events.admin.AdminEvent;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.UserModel;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class SyncEventListener implements EventListenerProvider {

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
                String firstName = user.getFirstName();
                String lastName = user.getLastName();

                try (Connection conn = DatabaseConnector.getConnection()) {
                    String sql = "INSERT INTO users (id, email, username, first_name, last_name, created_at, is_deleted, status) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                        stmt.setString(1, userId); // id
                        stmt.setString(2, email); // email
                        stmt.setString(3, username); // username
                        stmt.setString(4, firstName); // first_name
                        stmt.setString(5, lastName); // last_name
                        stmt.setLong(6, System.currentTimeMillis() / 1000); // created_at (Unix timestamp)
                        stmt.setBoolean(7, false); // is_deleted
                        stmt.setBoolean(8, true); // status
                        stmt.executeUpdate();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
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


