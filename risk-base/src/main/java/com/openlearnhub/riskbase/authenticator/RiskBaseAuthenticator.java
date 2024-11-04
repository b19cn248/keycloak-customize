package com.openlearnhub.riskbase.authenticator;

import com.openlearnhub.riskbase.constant.Constant;
import com.openlearnhub.riskbase.dao.UserLoginHistoryDAO;
import com.openlearnhub.riskbase.model.UserLoginHistory;
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
import java.util.List;
import java.util.logging.Logger;

public class RiskBaseAuthenticator implements Authenticator {

    private static final Logger logger = Logger.getLogger(RiskBaseAuthenticator.class.getName());

    final KeycloakSession session;

    /**
     * constructor create keycloak session
     *
     * @param session session of keycloak
     */
    public RiskBaseAuthenticator(KeycloakSession session) {
        this.session = session;
    }


    @Override
    public void authenticate(AuthenticationFlowContext context) {
        // get config name client on keycloak
        AuthenticatorConfigModel config = context.getAuthenticatorConfig();
        String clientName = config.getConfig().get(Constant.CLIENT);
        UserLoginHistoryDAO userLoginHistoryDAO = new UserLoginHistoryDAO();
        UserModel user = context.getUser();
        List<UserLoginHistory> loginHistoryList = userLoginHistoryDAO.getLoginHistoryList(user.getId(), clientName);

        String ipAddress = null;
        try {
            ipAddress = getIpAddress(context);
        } catch (UnknownHostException e) {
            logger.severe("Error get IP address: " + e);
        }

        UserAgentAnalyzer userAgentAnalyzer = UserAgentAnalyzer.newBuilder().build();
        UserAgent userAgent = userAgentAnalyzer.parse(
                context.getHttpRequest().getHttpHeaders().getHeaderString(Constant.USER_AGENT));

        // is strange ip address

        if (isStrangeIPAddress(ipAddress, loginHistoryList)) {
            context.attempted();
            return;
        }

        // is strange OS
        if (isStrangeOS(userAgent.getValue(Constant.OPERATING_SYSTEM),
                loginHistoryList)) {
            context.attempted();
            return;
        }

        // is strange browser
        if (isStrangeBrowser(userAgent.getValue(Constant.BROWSER),
                loginHistoryList)) {
            context.attempted();
            return;
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

    private boolean isStrangeIPAddress(String ipAddress, List<UserLoginHistory> userLoginHistoryList) {
        // check first login
        if (userLoginHistoryList != null && !userLoginHistoryList.isEmpty()) {
            for (UserLoginHistory userLoginHistory : userLoginHistoryList) {
                if (userLoginHistory.getIpAddress().equalsIgnoreCase(ipAddress)) {
                    return false;
                }
            }
        } else {
            return false;
        }
        return true;
    }



    private boolean isStrangeOS(String operatingSystem, List<UserLoginHistory> userLoginHistoryList) {
        // check first login
        if (userLoginHistoryList != null && !userLoginHistoryList.isEmpty()) {
            for (UserLoginHistory UserLoginHistory : userLoginHistoryList) {
                if (UserLoginHistory.getOperatingSystem().equalsIgnoreCase(operatingSystem)) {
                    return false;
                }
            }
        } else {
            return false;
        }
        return true;
    }


    private boolean isStrangeBrowser(String browser, List<UserLoginHistory> userLoginHistoryList) {
        // check first login
        if (userLoginHistoryList != null && !userLoginHistoryList.isEmpty()) {
            for (UserLoginHistory UserLoginHistory : userLoginHistoryList) {
                if (UserLoginHistory.getBrowser().equalsIgnoreCase(browser)) {
                    return false;
                }
            }
        } else {
            return false;
        }
        return true;
    }
}
