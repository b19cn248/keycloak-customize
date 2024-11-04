package com.openlearnhub.user.authenticator;

import com.openlearnhub.user.constant.Constant;
import com.openlearnhub.user.dao.UserLoginHistoryDAO;
import com.openlearnhub.user.model.UserLoginHistory;
import lombok.extern.slf4j.Slf4j;
import nl.basjes.parse.useragent.UserAgent;
import nl.basjes.parse.useragent.UserAgentAnalyzer;
import nl.basjes.parse.useragent.utils.springframework.util.StringUtils;
import org.apache.commons.validator.routines.InetAddressValidator;
import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.Authenticator;
import org.keycloak.models.AuthenticatorConfigModel;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Timestamp;
import java.util.List;
import java.util.logging.Logger;

@Slf4j
public class SaveUserInfoAuthenticator implements Authenticator {

    private static final Logger logger = Logger.getLogger(SaveUserInfoAuthenticator.class.getName());


    final KeycloakSession session;

    public SaveUserInfoAuthenticator(KeycloakSession session) {
        this.session = session;
    }

    @Override
    public void authenticate(AuthenticationFlowContext context) {
        // get config name client on keycloak
        AuthenticatorConfigModel config = context.getAuthenticatorConfig();
        String clientName = config.getConfig().get(Constant.CLIENT);
        // prepare UserLoginHistory, insert if not exist in DB
        UserAgentAnalyzer userAgentAnalyzer = UserAgentAnalyzer.newBuilder().build();
        UserAgent userAgent = userAgentAnalyzer.parse(
                context.getHttpRequest().getHttpHeaders().getHeaderString(Constant.USER_AGENT));

        UserLoginHistory userLoginHistory = null;
        try {
            userLoginHistory = UserLoginHistory.builder()
                    .userId(context.getUser().getId())
                    .ipAddress(getIpAddress(context))
                    .operatingSystem(userAgent.getValue(Constant.OPERATING_SYSTEM))
                    .browser(userAgent.getValue(Constant.BROWSER))
                    .timeLogin(new Timestamp(System.currentTimeMillis()))
                    .client(clientName)
                    .build();
        } catch (UnknownHostException e) {
            logger.warning("Error get ip address: " + e.getMessage());
        }
        UserLoginHistoryDAO userLoginHistoryDAO = new UserLoginHistoryDAO();
        assert userLoginHistory != null;
        if (!userLoginHistoryDAO.isExist(userLoginHistory.getUserId(), userLoginHistory.getIpAddress(),
                userLoginHistory.getOperatingSystem(), userLoginHistory.getBrowser(), userLoginHistory.getClient())) {
            int countRecordInsert = userLoginHistoryDAO.insert(userLoginHistory);

            if (countRecordInsert == 0) {
                logger.warning("Error insert user login history");
            }
        }

        context.success();
    }

    @Override
    public void action(AuthenticationFlowContext authenticationFlowContext) {
        // do nothing
    }

    @Override
    public boolean requiresUser() {
        return false;
    }

    @Override
    public boolean configuredFor(KeycloakSession keycloakSession, RealmModel realmModel, UserModel userModel) {
        return false;
    }

    @Override
    public void setRequiredActions(KeycloakSession keycloakSession, RealmModel realmModel, UserModel userModel) {
        // do nothing
    }

    @Override
    public void close() {
        // do nothing
    }


    private String getIpAddress(AuthenticationFlowContext context) throws UnknownHostException {
        if (context == null) {
            return null;
        }
        String ipAddress = null;
        InetAddressValidator validator = InetAddressValidator.getInstance();
        List<String> possibleIpHeaders = List.of(
                Constant.X_FORWARDED_FOR,
                Constant.HTTP_FORWARDED,
                Constant.HTTP_FORWARDED_FOR,
                Constant.HTTP_X_FORWARDED,
                Constant.HTTP_X_FORWARDED_FOR,
                Constant.HTTP_CLIENT_IP,
                Constant.HTTP_VIA,
                Constant.HTTP_X_CLUSTER_CLIENT_IP,
                Constant.PROXY_CLIENT_IP,
                Constant.WL_PROXY_CLIENT_IP,
                Constant.REMOTE_ADDR
        );
        for (String ipHeader : possibleIpHeaders) {
            String headerValue = context.getHttpRequest().getHttpHeaders().getHeaderString(ipHeader);
            if (StringUtils.hasLength(headerValue) && validator.isValid(headerValue)) {
                ipAddress = headerValue;
                break;
            }
        }
        if (ipAddress == null) {
            ipAddress = context.getSession().getContext().getConnection().getRemoteAddr();
        }
        if (Constant.LOOPBACK_IP.equals(ipAddress) || Constant.LOCALHOST.equalsIgnoreCase(ipAddress)) {
            ipAddress = InetAddress.getLocalHost().getHostAddress();
        }

        return ipAddress;
    }
}
