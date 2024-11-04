package com.openlearnhub.riskbase.authenticator;

import com.openlearnhub.riskbase.constant.Constant;
import org.keycloak.Config;
import org.keycloak.authentication.Authenticator;
import org.keycloak.authentication.AuthenticatorFactory;
import org.keycloak.models.AuthenticationExecutionModel;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.KeycloakSessionFactory;
import org.keycloak.provider.ProviderConfigProperty;

import java.util.List;

public class RiskBaseAuthenticatorFactory implements AuthenticatorFactory {

    protected static final AuthenticationExecutionModel.Requirement[] REQUIREMENT_CHOICES = {
            AuthenticationExecutionModel.Requirement.REQUIRED,
            AuthenticationExecutionModel.Requirement.ALTERNATIVE,
            AuthenticationExecutionModel.Requirement.DISABLED
    };

    @Override
    public String getDisplayType() {
        return Constant.DISPLAY_TYPE;
    }

    @Override
    public String getReferenceCategory() {
        return null;
    }

    @Override
    public boolean isConfigurable() {
        return true;
    }

    @Override
    public AuthenticationExecutionModel.Requirement[] getRequirementChoices() {
        return REQUIREMENT_CHOICES;
    }

    @Override
    public boolean isUserSetupAllowed() {
        return true;
    }

    @Override
    public String getHelpText() {
        return Constant.PROVIDER_HELP_TEXT;
    }

    @Override
    public List<ProviderConfigProperty> getConfigProperties() {
        return List.of(new ProviderConfigProperty(Constant.CLIENT, Constant.CLIENT_LABEL,
                Constant.CLIENT_HELP_TEXT, ProviderConfigProperty.STRING_TYPE,
                Constant.CLIENT_DEFAULT_VALUE));
    }

    @Override
    public Authenticator create(KeycloakSession keycloakSession) {
        return new RiskBaseAuthenticator(keycloakSession);
    }

    @Override
    public void init(Config.Scope scope) {
        // Do nothing
    }

    @Override
    public void postInit(KeycloakSessionFactory keycloakSessionFactory) {
        // Do nothing
    }

    @Override
    public void close() {
        // Do nothing
    }

    @Override
    public String getId() {
        return "risk-base";
    }
}
