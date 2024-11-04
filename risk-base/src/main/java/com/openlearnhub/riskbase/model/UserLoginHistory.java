package com.openlearnhub.riskbase.model;


import java.sql.Timestamp;

public class UserLoginHistory {
    private String id;
    private String userId;
    private String ipAddress;
    private String operatingSystem;
    private String browser;
    private Timestamp timeLogin;
    private String client;

    public UserLoginHistory() {
    }

    private UserLoginHistory(Builder builder) {
        setId(builder.id);
        setUserId(builder.userId);
        setIpAddress(builder.ipAddress);
        setOperatingSystem(builder.operatingSystem);
        setBrowser(builder.browser);
        setTimeLogin(builder.timeLogin);
        setClient(builder.client);
    }

    public static Builder builder() {
        return new Builder();
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public String getOperatingSystem() {
        return operatingSystem;
    }

    public void setOperatingSystem(String operatingSystem) {
        this.operatingSystem = operatingSystem;
    }

    public String getBrowser() {
        return browser;
    }

    public void setBrowser(String browser) {
        this.browser = browser;
    }

    public Timestamp getTimeLogin() {
        return timeLogin;
    }

    public void setTimeLogin(Timestamp timeLogin) {
        this.timeLogin = timeLogin;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }


    public static final class Builder {
        private String id;
        private String userId;
        private String ipAddress;
        private String operatingSystem;
        private String browser;
        private Timestamp timeLogin;
        private String client;

        private Builder() {
        }

        public Builder id(String val) {
            id = val;
            return this;
        }

        public Builder userId(String val) {
            userId = val;
            return this;
        }

        public Builder ipAddress(String val) {
            ipAddress = val;
            return this;
        }

        public Builder operatingSystem(String val) {
            operatingSystem = val;
            return this;
        }

        public Builder browser(String val) {
            browser = val;
            return this;
        }

        public Builder timeLogin(Timestamp val) {
            timeLogin = val;
            return this;
        }

        public Builder client(String val) {
            client = val;
            return this;
        }

        public UserLoginHistory build() {
            return new UserLoginHistory(this);
        }
    }
}
