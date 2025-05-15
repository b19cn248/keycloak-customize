<#import "template.ftl" as layout>
<#import "field.ftl" as field>
<#import "buttons.ftl" as buttons>
<#import "social-providers.ftl" as identityProviders>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <!-- template: login.ftl -->

    <#if section = "header">
        <h1 class="news-login-title">Đăng nhập</h1>
    <#elseif section = "form">
        <div id="kc-form" class="animated-card">
            <div id="kc-form-wrapper">
                <#if realm.password>
                    <form id="kc-form-login" class="${properties.kcFormClass!}" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post" novalidate="novalidate">
                        <#if !usernameHidden??>
                            <#assign label>
                                <#if !realm.loginWithEmailAllowed>Tên đăng nhập<#elseif !realm.registrationEmailAsUsername>Tên đăng nhập hoặc Email<#else>Email</#if>
                            </#assign>
                            <@field.input name="username" label=label error=kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc autofocus=true autocomplete="username" value=login.username!'' />
                            <@field.password name="password" label=msg("password") error="" forgotPassword=realm.resetPasswordAllowed autofocus=usernameHidden?? autocomplete="current-password">
                                <#if realm.rememberMe && !usernameHidden??>
                                    <@field.checkbox name="rememberMe" label="Ghi nhớ đăng nhập" value=login.rememberMe?? />
                                </#if>
                            </@field.password>
                        <#else>
                            <@field.password name="password" label=msg("password") forgotPassword=realm.resetPasswordAllowed autofocus=usernameHidden?? autocomplete="current-password">
                                <#if realm.rememberMe && !usernameHidden??>
                                    <@field.checkbox name="rememberMe" label="Ghi nhớ đăng nhập" value=login.rememberMe?? />
                                </#if>
                            </@field.password>
                        </#if>

                        <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                        <@buttons.loginButton />
                    </form>
                </#if>
            </div>
        </div>
    <#elseif section = "socialProviders" >
        <#if realm.password && social.providers?? && social.providers?has_content>
            <@identityProviders.show social=social/>
        </#if>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <span>Chưa có tài khoản? <a href="${url.registrationUrl}" class="register-link">Đăng ký</a></span>
                </div>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>