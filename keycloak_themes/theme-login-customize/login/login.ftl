<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
        <div id="kc-form">
            <#if realm.password>
                <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                    <#if !usernameHidden??>
                        <div class="sf-form-group">
                            <label for="username" class="sf-label">
                                <#if !realm.loginWithEmailAllowed>
                                    ${msg("username")}
                                <#elseif !realm.registrationEmailAsUsername>
                                    ${msg("usernameOrEmail")}
                                <#else>
                                    ${msg("email")}
                                </#if>
                            </label>
                            <div class="sf-input-wrapper">
                                <i class="fas fa-user sf-input-icon"></i>
                                <input
                                        tabindex="1"
                                        id="username"
                                        class="sf-input"
                                        name="username"
                                        value="${(login.username!'')}"
                                        type="text"
                                        autofocus
                                        autocomplete="username"
                                        aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                        placeholder="Nhập tên đăng nhập hoặc email"
                                />
                            </div>
                            <#if messagesPerField.existsError('username','password')>
                                <span id="input-error" class="sf-error-message" aria-live="polite">
                                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                </span>
                            </#if>
                        </div>
                    </#if>

                    <div class="sf-form-group">
                        <label for="password" class="sf-label">${msg("password")}</label>
                        <div class="sf-input-wrapper">
                            <i class="fas fa-lock sf-input-icon"></i>
                            <input
                                    tabindex="2"
                                    id="password"
                                    class="sf-input"
                                    name="password"
                                    type="password"
                                    autocomplete="current-password"
                                    aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                    placeholder="Nhập mật khẩu của bạn"
                            />
                            <button
                                    class="sf-password-toggle"
                                    type="button"
                                    aria-label="${msg("showPassword")}"
                                    aria-controls="password"
                                    data-password-toggle
                                    tabindex="3"
                                    data-label-show="${msg('showPassword')}"
                                    data-label-hide="${msg('hidePassword')}"
                            >
                                <i class="fas fa-eye" aria-hidden="true"></i>
                            </button>
                        </div>
                        <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                            <span id="input-error" class="sf-error-message" aria-live="polite">
                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                            </span>
                        </#if>
                    </div>

                    <div class="sf-options">
                        <div id="kc-form-options">
                            <#if realm.rememberMe && !usernameHidden??>
                                <div class="sf-checkbox">
                                    <label>
                                        <#if login.rememberMe??>
                                            <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                        <#else>
                                            <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                        </#if>
                                    </label>
                                </div>
                            </#if>
                        </div>
                        <div>
                            <#if realm.resetPasswordAllowed>
                                <a tabindex="4" href="${url.loginResetCredentialsUrl}" class="sf-link">${msg("doForgotPassword")}</a>
                            </#if>
                        </div>
                    </div>

                    <div id="kc-form-buttons">
                        <input
                                type="hidden"
                                id="id-hidden-input"
                                name="credentialId"
                                <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>
                        />
                        <input
                                tabindex="5"
                                class="sf-button"
                                name="login"
                                id="kc-login"
                                type="submit"
                                value="${msg("doLogIn")}"
                        />
                    </div>
                </form>
            </#if>
        </div>
    <#elseif section = "info">
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div class="sf-divider">
                ${msg("noAccount")}
            </div>
            <div style="text-align: center;">
                <a tabindex="6" href="${url.registrationUrl}" class="sf-link">${msg("doRegister")}</a>
            </div>
        </#if>
    <#elseif section = "socialProviders">
        <#if realm.password && social?? && social.providers?has_content>
            <div class="sf-divider">
                ${msg("identity-provider-login-label")}
            </div>
            <div class="sf-social-buttons">
                <#list social.providers as p>

                    id="social-${p.alias}"
                    class="sf-social-button"
                    href="${p.loginUrl}"
                    >
                    <#if p.iconClasses?has_content>
                        <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!} sf-social-icon" aria-hidden="true"></i>
                    </#if>
                    ${p.displayName!}
                    </a>
                </#list>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>