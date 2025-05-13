package com.openlearnhub.riskbase.authenticator;

import org.keycloak.events.Event;
import org.keycloak.events.EventListenerProvider;
import org.keycloak.events.EventType;
import org.keycloak.events.admin.AdminEvent;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.UserModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public class SyncEventListener implements EventListenerProvider {

    private static final Logger logger = LoggerFactory.getLogger(SyncEventListener.class);
    private static final String USER_API_URL = "https://smart.feeds.api.openlearnhub.io.vn/api/v1/users";

    private final KeycloakSession session;

    public SyncEventListener(KeycloakSession session) {
        this.session = session;
    }

    @Override
    public void onEvent(Event event) {
        // Xử lý cả sự kiện đăng ký và đăng nhập qua Google
        if (event.getType() == EventType.REGISTER ||
                (event.getType() == EventType.IDENTITY_PROVIDER_LOGIN &&
                        event.getDetails() != null &&
                        event.getDetails().containsKey("identity_provider") &&
                        "google".equals(event.getDetails().get("identity_provider")))) {

            String userId = event.getUserId();

            try {
                // Kiểm tra user đã tồn tại bằng keycloakId
                if (userExistsByKeycloakId(userId)) {
                    logger.info("User with keycloakId {} already exists in database", userId);
                    return;
                }

                // Lấy UserModel từ userId trong sự kiện
                UserModel user = session.users().getUserById(session.getContext().getRealm(), userId);
                if (user == null) {
                    logger.error("Unable to find user with id {}", userId);
                    return;
                }

                // Lấy thông tin từ UserModel
                String email = user.getEmail();
                String username = user.getUsername();
                String name = (user.getFirstName() != null ? user.getFirstName() : "") +
                        (user.getLastName() != null ? " " + user.getLastName() : "");
                name = name.trim();

                // Tạo payload JSON cho API
                String jsonPayload = createJsonPayload(userId, email, username, name);

                // Gọi API để tạo user
                boolean success = callCreateUserApi(jsonPayload);

                if (success) {
                    logger.info("Successfully synced user {} to database via API", userId);
                }

            } catch (Exception e) {
                logger.error("Error while syncing user to database: ", e);
            }
        }
    }

    private boolean userExistsByKeycloakId(String keycloakId) {
        try {
            URL url = new URL(USER_API_URL + "/exists/keycloak?keycloakId=" + keycloakId);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Accept", "application/json");

            int responseCode = conn.getResponseCode();

            if (responseCode == HttpURLConnection.HTTP_OK) {
                try (BufferedReader br = new BufferedReader(
                        new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
                    String response = br.readLine();
                    return "true".equals(response);
                }
            }

            return false;
        } catch (Exception e) {
            logger.error("Error checking if user exists by keycloakId: ", e);
            return false;
        }
    }

    private String createJsonPayload(String keycloakId, String email, String username, String name) {
        return "{"
                + "\"email\":\"" + email + "\","
                + "\"username\":\"" + username + "\","
                + "\"name\":\"" + name + "\","
                + "\"points\":0,"
                + "\"keycloakId\":\"" + keycloakId + "\","
                + "\"settingsId\":1,"
                + "\"readLaterListId\":1,"
                + "\"subscriptionId\":1,"
                + "\"createdBy\":\"KEYCLOAK\","
                + "\"updatedBy\":\"KEYCLOAK\""
                + "}";
    }

    private boolean callCreateUserApi(String jsonPayload) {
        try {
            URL url = new URL(USER_API_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Accept", "application/json");
            conn.setDoOutput(true);

            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = jsonPayload.getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            int responseCode = conn.getResponseCode();

            if (responseCode == HttpURLConnection.HTTP_CREATED || responseCode == HttpURLConnection.HTTP_OK) {
                return true;
            } else {
                StringBuilder response = new StringBuilder();
                try (BufferedReader br = new BufferedReader(
                        new InputStreamReader(conn.getErrorStream(), StandardCharsets.UTF_8))) {
                    String responseLine;
                    while ((responseLine = br.readLine()) != null) {
                        response.append(responseLine.trim());
                    }
                }

                logger.error("Failed to create user via API. Response code: {}, Response: {}",
                        responseCode, response.toString());
                return false;
            }
        } catch (Exception e) {
            logger.error("Error calling create user API: ", e);
            return false;
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