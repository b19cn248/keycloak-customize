<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
        <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
            <div class="form-group">
                <label for="username">
                    <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>
                </label>
                <input tabindex="1" id="username" name="username" value="${(login.username!'')}" type="text" autofocus autocomplete="username"
                       aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"/>

                <#if messagesPerField.existsError('username','password')>
                    <span class="error-message">${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}</span>
                </#if>
            </div>

            <div class="form-group">
                <div class="label-with-link">
                    <label for="password">${msg("password")}</label>
                    <#if realm.resetPasswordAllowed>
                        <a class="text-link float-right" tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
                    </#if>
                </div>
                <input tabindex="2" id="password" name="password" type="password" autocomplete="current-password"
                       aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"/>
            </div>

            <#if realm.rememberMe && !usernameHidden??>
                <div class="form-group checkbox-group">
                    <label class="checkbox-label">
                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" <#if login.rememberMe??>checked</#if>>
                        <span>${msg("rememberMe")}</span>
                    </label>
                </div>
            </#if>

            <div class="form-group">
                <button tabindex="4" name="login" id="kc-login" type="submit" class="btn">
                    ${msg("doLogIn")}
                </button>
            </div>
        </form>
    <#elseif section = "info">
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div class="form-footer">
                ${msg("noAccount")} <a class="text-link" tabindex="6" href="${url.registrationUrl}">${msg("doRegister")}</a>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>