package com.openlearnhub.user.constant;

public class Constant {

  private Constant() {
  }

  public static final String USER_AGENT = "user-agent";
  public static final String X_FORWARDED_FOR = "X-FORWARDED-FOR";
  public static final String HTTP_FORWARDED = "HTTP_FORWARDED";
  public static final String HTTP_FORWARDED_FOR = "HTTP_FORWARDED_FOR";
  public static final String HTTP_X_FORWARDED = "HTTP_X_FORWARDED";
  public static final String HTTP_X_FORWARDED_FOR = "HTTP_X_FORWARDED_FOR";
  public static final String HTTP_CLIENT_IP = "HTTP_CLIENT_IP";
  public static final String HTTP_VIA = "HTTP_VIA";
  public static final String HTTP_X_CLUSTER_CLIENT_IP = "HTTP_X_CLUSTER_CLIENT_IP";
  public static final String PROXY_CLIENT_IP = "Proxy-Client-IP";
  public static final String WL_PROXY_CLIENT_IP = "WL-Proxy-Client-IP";
  public static final String REMOTE_ADDR = "REMOTE_ADDR";
  public static final String OPERATING_SYSTEM = "OperatingSystemName";
  public static final String BROWSER = "AgentName";
  public static final String LOOPBACK_IP = "127.0.0.1";
  public static final String LOCALHOST = "localhost";
  public static final String CLIENT = "client";
  public static final String CLIENT_LABEL = "Client ID";
  public static final String CLIENT_HELP_TEXT = "Specifies ID referenced in URI and tokens. "
      + "For example 'my-client'. For SAML this is also the expected issuer value from authn requests";
  public static final String CLIENT_DEFAULT_VALUE = "";
}
