<#import "template.ftl" as layout>
<#import "field.ftl" as field>
<#import "buttons.ftl" as buttons>
<#import "social-providers.ftl" as identityProviders>

<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <!-- template: login.ftl -->

    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <#if realm.password>
                    <div class="smartfeeds-form-header">
                        <div class="smartfeeds-form-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                <circle cx="12" cy="7" r="4"></circle>
                            </svg>
                        </div>
                        <h2 class="smartfeeds-form-title">${msg("loginAccountTitle")}</h2>
                        <p class="smartfeeds-form-subtitle">Đăng nhập để truy cập tin tức của bạn</p>
                    </div>

                    <form id="kc-form-login" class="${properties.kcFormClass!}" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post" novalidate="novalidate">
                        <#if !usernameHidden??>
                            <#assign label>
                                <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>
                            </#assign>
                            <@field.input name="username" label=label error=kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc autofocus=true autocomplete="username" value=login.username!'' />
                            <@field.password name="password" label=msg("password") error="" forgotPassword=realm.resetPasswordAllowed autofocus=usernameHidden?? autocomplete="current-password">
                                <#if realm.rememberMe && !usernameHidden??>
                                    <@field.checkbox name="rememberMe" label=msg("rememberMe") value=login.rememberMe?? />
                                </#if>
                            </@field.password>
                        <#else>
                            <@field.password name="password" label=msg("password") forgotPassword=realm.resetPasswordAllowed autofocus=usernameHidden?? autocomplete="current-password">
                                <#if realm.rememberMe && !usernameHidden??>
                                    <@field.checkbox name="rememberMe" label=msg("rememberMe") value=login.rememberMe?? />
                                </#if>
                            </@field.password>
                        </#if>

                        <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>

                        <div class="smartfeeds-form-actions">
                            <button class="smartfeeds-primary-btn" name="login" id="kc-login" type="submit">
                                ${msg("doLogIn")}
                            </button>
                        </div>
                    </form>
                </#if>
            </div>
        </div>
    <#elseif section = "socialProviders" >
        <#if realm.password && social.providers?? && social.providers?has_content>
            <div class="smartfeeds-divider">
                <span>${msg("or")}</span>
            </div>

            <div id="kc-social-providers" class="smartfeeds-social-providers">
                <#list social.providers as p>
                    <a href="${p.loginUrl}" id="social-${p.alias}" class="smartfeeds-social-btn">
                        <#if p.iconClasses?has_content>
                            <i class="${p.iconClasses!}"></i>
                        </#if>
                        <span>${p.displayName!}</span>
                    </a>
                </#list>
            </div>
        </#if>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container" class="smartfeeds-registration">
                <span>${msg("noAccount")} <a href="${url.registrationUrl}" class="smartfeeds-link">${msg("doRegister")}</a></span>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>