<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        <div class="olh-news-header">
            <img src="${url.resourcesPath}/img/olh.png" alt="OpenLearnHub Logo" class="olh-logo">
        </div>
    <#elseif section = "form">
        <div id="kc-form" class="olh-form-container">
            <div id="kc-form-wrapper" class="olh-form-wrapper">
                <h2 class="sign-in-header">SIGN IN</h2>
                <#if realm.password>
                    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                        <#if !usernameHidden??>
                            <div class="${properties.kcFormGroupClass!} olh-form-group">
                                <label for="username" class="${properties.kcLabelClass!} olh-label">Username</label>

                                <div class="input-group">
                                    <div class="input-icon">
                                        <i class="fa fa-user"></i>
                                    </div>
                                    <input tabindex="2" id="username" class="${properties.kcInputClass!} olh-input" name="username" value="${(login.username!'')}" type="text" autofocus autocomplete="username"
                                           aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                           dir="ltr"
                                           placeholder="Username or email"
                                    />
                                </div>

                                <#if messagesPerField.existsError('username','password')>
                                    <span id="input-error" class="${properties.kcInputErrorMessageClass!} olh-error-message" aria-live="polite">
                                        ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                </span>
                                </#if>

                            </div>
                        </#if>

                        <div class="${properties.kcFormGroupClass!} olh-form-group">
                            <label for="password" class="${properties.kcLabelClass!} olh-label">Password</label>

                            <div class="input-group">
                                <div class="input-icon">
                                    <i class="fa fa-lock"></i>
                                </div>
                                <input tabindex="3" id="password" class="${properties.kcInputClass!} olh-input" name="password" type="password" autocomplete="current-password"
                                       aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                       placeholder="Password"
                                />
                                <button class="${properties.kcFormPasswordVisibilityButtonClass!} olh-visibility-button" type="button" aria-label="${msg("showPassword")}"
                                        aria-controls="password" data-password-toggle tabindex="4"
                                        data-icon-show="${properties.kcFormPasswordVisibilityIconShow!}" data-icon-hide="${properties.kcFormPasswordVisibilityIconHide!}"
                                        data-label-show="${msg('showPassword')}" data-label-hide="${msg('hidePassword')}">
                                    <i class="fa fa-eye-slash" aria-hidden="true"></i>
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
                            <input tabindex="7" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} olh-button" name="login" id="kc-login" type="submit" value="SIGN IN"/>
                        </div>
                    </form>
                </#if>
            </div>
        </div>
        <script type="module" src="${url.resourcesPath}/js/passwordVisibility.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <!-- Custom CSS for OpenLearnHub login page -->
        <style>
            :root {
                --olh-primary: #1976d2;
                --olh-primary-dark: #115293;
                --olh-accent: #FF5722;
                --olh-text: #333333;
                --olh-text-light: #666666;
                --olh-background: #1565c0;
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
                background-image: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIHZpZXdCb3g9IjAgMCAxMDAgMTAwIiBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSJub25lIj48cGF0aCBmaWxsPSIjMTU2NWMwIiBkPSJNMCAwTDEwMCAwIDEwMCAxMDAgMCAxMDB6Ii8+PGc+PGcgZmlsbC1vcGFjaXR5PSIuMSIgZmlsbD0iI2ZmZiI+PGNpcmNsZSBjeD0iMTAiIGN5PSIzNSIgcj0iMyIvPjxjaXJjbGUgY3g9IjQwIiBjeT0iNzAiIHI9IjQiLz48Y2lyY2xlIGN4PSI3MCIgY3k9IjQwIiByPSIyIi8+PGNpcmNsZSBjeD0iOTUiIGN5PSI4NSIgcj0iMyIvPjxwYXRoIGQ9Ik0xNSAyNUw4NSA4NVoiIHN0cm9rZT0iI2ZmZiIgc3Ryb2tlLW9wYWNpdHk9Ii4yIiBzdHJva2Utd2lkdGg9IjAuNSIvPjxwYXRoIGQ9Ik00MCA4MEw4MCAyMFoiIHN0cm9rZT0iI2ZmZiIgc3Ryb2tlLW9wYWNpdHk9Ii4yIiBzdHJva2Utd2lkdGg9IjAuNSIvPjwvZz48L2c+PHBhdGggZD0iTTAgMEMxMCAxMCAyMCA1IDMwIDE1QzQwIDI1IDUwIDE1IDYwIDI1QzcwIDM1IDgwIDI1IDkwIDM1QzEwMCA0NSAxMDAgMTAwIDEwMCAxMDBIMFoiIGZpbGw9IiMxMTUyOTMiIGZpbGwtb3BhY2l0eT0iLjMiLz48L3N2Zz4=');
                background-repeat: no-repeat;
                background-size: cover;
                background-position: center;
                font-family: 'Roboto', Arial, sans-serif;
                color: var(--olh-text);
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            .olh-news-header {
                text-align: center;
                margin-bottom: 1.5rem;
            }

            .olh-logo {
                height: 40px;
                filter: brightness(0) invert(1);
            }

            .sign-in-header {
                color: var(--olh-primary);
                text-align: center;
                font-size: 1.5rem;
                font-weight: 600;
                margin-top: 0;
                margin-bottom: 2rem;
            }

            .olh-form-container {
                background-color: var(--olh-card-bg);
                border-radius: 4px;
                box-shadow: var(--olh-shadow);
                width: 380px;
                max-width: 90%;
                margin: 0 auto 2rem;
                overflow: hidden;
                padding: 2rem;
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
                font-size: 0.9rem;
            }

            .input-group {
                position: relative;
                display: flex;
                width: 100%;
                border: 1px solid var(--olh-border);
                border-radius: 4px;
                overflow: hidden;
            }

            .input-group:focus-within {
                border-color: var(--olh-primary);
                box-shadow: 0 0 0 1px var(--olh-primary);
            }

            .input-icon {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 40px;
                background-color: #f5f5f5;
                color: #666;
                border-right: 1px solid var(--olh-border);
            }

            .olh-input {
                width: 100%;
                padding: 0.75rem 1rem;
                border: none;
                font-size: 1rem;
                outline: none;
                background-color: white;
            }

            .olh-visibility-button {
                position: absolute;
                right: 0;
                top: 0;
                height: 100%;
                width: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
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
                margin-top: 1rem;
                padding-top: 1rem;
                text-align: center;
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
                margin-top: 1rem;
                color: white;
                font-size: 0.9rem;
            }

            #kc-registration a {
                color: white;
                font-weight: 500;
                text-decoration: underline;
            }

            .footer-text {
                text-align: center;
                color: rgba(255, 255, 255, 0.8);
                font-size: 0.8rem;
                margin-top: 2rem;
            }

            /* Responsive adjustments */
            @media (max-width: 480px) {
                .olh-form-container {
                    width: 100%;
                    max-width: 100%;
                    margin: 0;
                    border-radius: 0;
                    box-shadow: none;
                    height: 100vh;
                }

                .olh-form-wrapper {
                    padding: 0;
                }

                .olh-news-header {
                    margin-top: 2rem;
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
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <span>${msg("noAccount")} <a tabindex="8"
                                                 href="${url.registrationUrl}">${msg("doRegister")}</a></span>
                </div>
            </div>
        </#if>
        <div class="footer-text">
            Developed by OpenLearnHub
        </div>
    <#elseif section = "socialProviders" >
        <#if realm.password>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!} olh-social-providers">
                <h2>Or sign in with</h2>

                <ul class="olh-social-list">
                    <li>
                        <a id="social-google" class="olh-social-button" type="button" href="${url.loginUrl}?kc_idp_hint=google">
                            <i class="fab fa-google olh-social-icon" aria-hidden="true"></i>
                            <span>Google</span>
                        </a>
                    </li>
                </ul>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>