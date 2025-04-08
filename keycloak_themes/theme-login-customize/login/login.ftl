<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        <div class="olh-news-header">
            <img src="${url.resourcesPath}/img/olh.png" alt="OLH News Logo" class="olh-logo">
            <span class="olh-title">Sign in to your account</span>
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
                                       placeholder="Username or email"
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
                                       placeholder="Password"
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
                --olh-primary: #0066cc;
                --olh-primary-dark: #0055aa;
                --olh-accent: #FF5722;
                --olh-text: #333333;
                --olh-text-light: #666666;
                --olh-background: #f0f2f5;
                --olh-card-bg: #FFFFFF;
                --olh-border: #E0E0E0;
                --olh-success: #4CAF50;
                --olh-error: #F44336;
                --olh-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
            }

            body {
                background-color: var(--olh-background);
                background-image: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIHZpZXdCb3g9IjAgMCAxMDAgMTAwIiBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSJub25lIj48cG9seWdvbiBwb2ludHM9IjAsMCAxMDAsMCAxMDAsMTAwIDAsMTAwIiBzdHlsZT0iZmlsbDojZjBmMmY1OyIvPjxwYXRoIGQ9Ik00MCwzMCBMNzAsNzAgTDEwMCw0MCBMMTAwLDEwMCBMMCwxMDAgTDAsNzAgWiIgc3R5bGU9ImZpbGw6I2VhZWRmMjsgc3Ryb2tlLXdpZHRoOjA7IiAvPjxwYXRoIGQ9Ik0wLDQwIEw0MCwxMCBMNzAsMzAgTDMwLDEwMCBMMCwxMDAgWiIgc3R5bGU9ImZpbGw6I2U0ZThmMDsgc3Ryb2tlLXdpZHRoOjA7IiAvPjwvc3ZnPg==');
                background-repeat: no-repeat;
                background-size: cover;
                background-position: center;
                font-family: 'Roboto', Arial, sans-serif;
                color: var(--olh-text);
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            .olh-news-header {
                display: flex;
                align-items: center;
                justify-content: flex-start;
                margin-bottom: 1.5rem;
                padding: 0 1rem;
            }

            .olh-logo {
                height: 32px;
                margin-right: 12px;
            }

            .olh-title {
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--olh-primary);
            }

            .olh-form-container {
                background-color: var(--olh-card-bg);
                border-radius: 8px;
                box-shadow: var(--olh-shadow);
                width: 400px;
                max-width: 90%;
                margin: 2rem auto;
                overflow: hidden;
            }

            .olh-form-wrapper {
                width: 100%;
                padding: 2rem;
            }

            .olh-form-group {
                margin-bottom: 1.5rem;
            }

            .olh-label {
                display: block;
                margin-bottom: 0.5rem;
                font-weight: 500;
                color: var(--olh-text);
                font-size: 0.9rem;
            }

            .olh-input {
                width: 100%;
                padding: 0.75rem 1rem;
                border: 1px solid var(--olh-border);
                border-radius: 4px;
                font-size: 1rem;
                transition: all 0.2s ease;
                background-color: #f7f9fc;
            }

            .olh-input:focus {
                border-color: var(--olh-primary);
                outline: none;
                box-shadow: 0 0 0 2px rgba(0, 102, 204, 0.2);
                background-color: #fff;
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
                transition: color 0.2s;
                font-size: 0.9rem;
            }

            .olh-link:hover {
                color: var(--olh-primary-dark);
                text-decoration: underline;
            }

            .olh-form-buttons {
                margin-top: 1.5rem;
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
                transition: background-color 0.2s;
                width: 100%;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            }

            .olh-button:hover {
                background-color: var(--olh-primary-dark);
            }

            /* Social providers styling */
            #kc-social-providers {
                margin-top: 1.5rem;
                border-top: 1px solid var(--olh-border);
                padding-top: 1.5rem;
            }

            #kc-social-providers h2 {
                margin-top: 0;
                margin-bottom: 1rem;
                font-size: 1rem;
                color: var(--olh-text-light);
                text-align: center;
            }

            .olh-social-list {
                list-style: none;
                padding: 0;
                margin: 0;
                display: flex;
                flex-direction: column;
                gap: 0.75rem;
            }

            .olh-social-button {
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 0.75rem 1rem;
                border: 1px solid var(--olh-border);
                border-radius: 4px;
                text-decoration: none;
                color: var(--olh-text);
                transition: all 0.2s;
                background-color: #fff;
                font-size: 0.9rem;
            }

            .olh-social-button:hover {
                background-color: #f5f7fa;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            }

            .olh-social-icon {
                margin-right: 0.5rem;
                font-size: 1.2rem;
            }

            /* Registration container styling */
            #kc-registration-container {
                text-align: center;
                margin-top: 1.5rem;
                padding-top: 1.5rem;
                padding-bottom: 0.5rem;
                border-top: 1px solid var(--olh-border);
                font-size: 0.9rem;
            }

            #kc-registration a {
                color: var(--olh-primary);
                font-weight: 500;
            }

            /* Responsive adjustments */
            @media (max-width: 480px) {
                .olh-form-container {
                    width: 100%;
                    max-width: 100%;
                    margin: 0;
                    border-radius: 0;
                    box-shadow: none;
                    min-height: 100vh;
                }

                .olh-form-wrapper {
                    padding: 1.5rem;
                }

                .olh-news-header {
                    margin-top: 2rem;
                    justify-content: center;
                }

                .olh-form-settings {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 0.75rem;
                }

                body {
                    background-image: none;
                    display: block;
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