<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        <div class="olh-news-header">
            <img src="${url.resourcesPath}/img/olh-logo.png" alt="OLH News Logo" class="olh-logo">
            <span class="olh-title">${msg("loginAccountTitle")}</span>
        </div>
    <#elseif section = "form">
        <div id="kc-form" class="olh-form-container">
            <div id="kc-form-wrapper" class="olh-form-wrapper">
                <#if realm.password>
                    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                        <#if !usernameHidden??>
                            <div class="${properties.kcFormGroupClass!} olh-form-group">
                                <label for="username" class="${properties.kcLabelClass!} olh-label"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>

                                <input tabindex="2" id="username" class="${properties.kcInputClass!} olh-input" name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="username"
                                       aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                       dir="ltr"
                                       placeholder="Nhập tên đăng nhập"
                                />

                                <#if messagesPerField.existsError('username','password')>
                                    <span id="input-error" class="${properties.kcInputErrorMessageClass!} olh-error-message" aria-live="polite">
                                        ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                </span>
                                </#if>

                            </div>
                        </#if>

                        <div class="${properties.kcFormGroupClass!} olh-form-group">
                            <label for="password" class="${properties.kcLabelClass!} olh-label">${msg("password")}</label>

                            <div class="${properties.kcInputGroup!} olh-input-group" dir="ltr">
                                <input tabindex="3" id="password" class="${properties.kcInputClass!} olh-input" name="password" type="password" autocomplete="current-password"
                                       aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                       placeholder="Nhập mật khẩu"
                                />
                                <button class="${properties.kcFormPasswordVisibilityButtonClass!} olh-visibility-button" type="button" aria-label="${msg("showPassword")}"
                                        aria-controls="password" data-password-toggle tabindex="4"
                                        data-icon-show="${properties.kcFormPasswordVisibilityIconShow!}" data-icon-hide="${properties.kcFormPasswordVisibilityIconHide!}"
                                        data-label-show="${msg('showPassword')}" data-label-hide="${msg('hidePassword')}">
                                    <i class="${properties.kcFormPasswordVisibilityIconShow!}" aria-hidden="true"></i>
                                </button>
                            </div>

                            <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                                <span id="input-error" class="${properties.kcInputErrorMessageClass!} olh-error-message" aria-live="polite">
                                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                            </span>
                            </#if>

                        </div>

                        <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!} olh-form-settings">
                            <div id="kc-form-options" class="olh-form-options">
                                <#if realm.rememberMe && !usernameHidden??>
                                    <div class="checkbox olh-checkbox">
                                        <label>
                                            <#if login.rememberMe??>
                                                <input tabindex="5" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                            <#else>
                                                <input tabindex="5" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                            </#if>
                                        </label>
                                    </div>
                                </#if>
                            </div>
                            <div class="${properties.kcFormOptionsWrapperClass!} olh-reset-password">
                                <#if realm.resetPasswordAllowed>
                                    <span><a tabindex="6" href="${url.loginResetCredentialsUrl}" class="olh-link">${msg("doForgotPassword")}</a></span>
                                </#if>
                            </div>

                        </div>

                        <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} olh-form-buttons">
                            <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                            <input tabindex="7" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} olh-button" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                        </div>
                    </form>
                </#if>
            </div>
        </div>
        <script type="module" src="${url.resourcesPath}/js/passwordVisibility.js"></script>

        <!-- Custom CSS for OLH News login page -->
        <style>
            :root {
                --olh-primary: #3949AB;
                --olh-primary-dark: #303F9F;
                --olh-accent: #FF5722;
                --olh-text: #333333;
                --olh-text-light: #666666;
                --olh-background: #F5F5F5;
                --olh-card-bg: #FFFFFF;
                --olh-border: #E0E0E0;
                --olh-success: #4CAF50;
                --olh-error: #F44336;
            }

            body {
                background-color: var(--olh-background);
                font-family: 'Roboto', Arial, sans-serif;
                color: var(--olh-text);
            }

            .olh-news-header {
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 2rem;
            }

            .olh-logo {
                height: 40px;
                margin-right: 10px;
            }

            .olh-title {
                font-size: 1.8rem;
                font-weight: bold;
                color: var(--olh-primary);
            }

            .olh-form-container {
                background-color: var(--olh-card-bg);
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                padding: 2rem;
                max-width: 450px;
                margin: 0 auto;
            }

            .olh-form-wrapper {
                width: 100%;
            }

            .olh-form-group {
                margin-bottom: 1.5rem;
            }

            .olh-label {
                display: block;
                margin-bottom: 0.5rem;
                font-weight: 500;
                color: var(--olh-text);
            }

            .olh-input {
                width: 100%;
                padding: 0.75rem 1rem;
                border: 1px solid var(--olh-border);
                border-radius: 4px;
                font-size: 1rem;
                transition: border-color 0.3s;
            }

            .olh-input:focus {
                border-color: var(--olh-primary);
                outline: none;
                box-shadow: 0 0 0 2px rgba(57, 73, 171, 0.2);
            }

            .olh-input-group {
                position: relative;
            }

            .olh-visibility-button {
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                color: var(--olh-text-light);
                cursor: pointer;
            }

            .olh-error-message {
                color: var(--olh-error);
                font-size: 0.875rem;
                margin-top: 0.5rem;
                display: block;
            }

            .olh-form-settings {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
            }

            .olh-checkbox {
                display: flex;
                align-items: center;
            }

            .olh-checkbox input {
                margin-right: 0.5rem;
            }

            .olh-link {
                color: var(--olh-primary);
                text-decoration: none;
                transition: color 0.3s;
            }

            .olh-link:hover {
                color: var(--olh-primary-dark);
                text-decoration: underline;
            }

            .olh-form-buttons {
                margin-top: 2rem;
            }

            .olh-button {
                background-color: var(--olh-primary);
                color: white;
                border: none;
                border-radius: 4px;
                padding: 0.75rem 1.5rem;
                font-size: 1rem;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.3s;
                width: 100%;
            }

            .olh-button:hover {
                background-color: var(--olh-primary-dark);
            }

            /* Social providers styling */
            #kc-social-providers {
                margin-top: 2rem;
                border-top: 1px solid var(--olh-border);
                padding-top: 1.5rem;
            }

            #kc-social-providers h2 {
                margin-bottom: 1rem;
                font-size: 1.25rem;
                color: var(--olh-text);
                text-align: center;
            }

            .kc-social-links {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 1rem;
            }

            .kc-social-provider-logo {
                width: 24px;
                height: 24px;
                margin-right: 0.5rem;
            }

            /* Registration container styling */
            #kc-registration-container {
                text-align: center;
                margin-top: 1.5rem;
                padding-top: 1.5rem;
                border-top: 1px solid var(--olh-border);
            }

            #kc-registration a {
                color: var(--olh-primary);
                font-weight: 500;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .olh-form-container {
                    padding: 1.5rem;
                    margin: 0 1rem;
                }

                .olh-form-settings {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .olh-reset-password {
                    margin-top: 1rem;
                }
            }
        </style>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container" class="olh-registration-container">
                <div id="kc-registration">
                    <span>${msg("noAccount")} <a tabindex="8" class="olh-link"
                                                 href="${url.registrationUrl}">${msg("doRegister")}</a></span>
                </div>
            </div>
        </#if>
    <#elseif section = "socialProviders" >
        <#if realm.password && social?? && social.providers?has_content>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!} olh-social-providers">
                <hr/>
                <h2>${msg("identity-provider-login-label")}</h2>

                <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if> olh-social-list">
                    <#list social.providers as p>
                        <li>
                            <a id="social-${p.alias}" class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if> olh-social-button"
                               type="button" href="${p.loginUrl}">
                                <#if p.iconClasses?has_content>
                                    <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!} olh-social-icon" aria-hidden="true"></i>
                                    <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                                <#else>
                                    <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                                </#if>
                            </a>
                        </li>
                    </#list>
                </ul>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>