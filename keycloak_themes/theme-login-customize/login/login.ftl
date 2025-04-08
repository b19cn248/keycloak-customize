<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        <div class="news-portal-header">
            <div class="news-logo">
                <span class="news-icon">📰</span>
                <span class="news-title">${msg("loginAccountTitle")}</span>
            </div>
        </div>
    <#elseif section = "form">
        <div id="kc-form" class="news-form-container">
            <div id="kc-form-wrapper" class="news-form-wrapper">
                <#if realm.password>
                    <div class="news-login-intro">
                        <h2>Đăng nhập vào tài khoản của bạn</h2>
                        <p>Truy cập để đọc tin tức hàng ngày, lưu bài viết yêu thích và cá nhân hóa trải nghiệm của bạn.</p>
                    </div>
                    <form id="kc-form-login" class="news-login-form" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                        <#if !usernameHidden??>
                            <div class="${properties.kcFormGroupClass!} news-form-group">
                                <label for="username" class="${properties.kcLabelClass!} news-label">
                                    <#if !realm.loginWithEmailAllowed>
                                        ${msg("username")}
                                    <#elseif !realm.registrationEmailAsUsername>
                                        ${msg("usernameOrEmail")}
                                    <#else>
                                        ${msg("email")}
                                    </#if>
                                </label>
                                <div class="news-input-wrapper">
                                    <span class="news-input-icon">👤</span>
                                    <input
                                            tabindex="2"
                                            id="username"
                                            class="${properties.kcInputClass!} news-input"
                                            name="username"
                                            value="${(login.username!'')}"
                                            type="text"
                                            autofocus
                                            autocomplete="username"
                                            aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                            dir="ltr"
                                            placeholder="Nhập tên đăng nhập của bạn"
                                    />
                                </div>
                                <#if messagesPerField.existsError('username','password')>
                                    <span id="input-error" class="${properties.kcInputErrorMessageClass!} news-error-message" aria-live="polite">
                                        ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                    </span>
                                </#if>
                            </div>
                        </#if>

                        <div class="${properties.kcFormGroupClass!} news-form-group">
                            <label for="password" class="${properties.kcLabelClass!} news-label">${msg("password")}</label>
                            <div class="${properties.kcInputGroup!} news-input-wrapper" dir="ltr">
                                <span class="news-input-icon">🔒</span>
                                <input
                                        tabindex="3"
                                        id="password"
                                        class="${properties.kcInputClass!} news-input"
                                        name="password"
                                        type="password"
                                        autocomplete="current-password"
                                        aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                        placeholder="Nhập mật khẩu của bạn"
                                />
                                <button
                                        class="${properties.kcFormPasswordVisibilityButtonClass!} news-password-toggle"
                                        type="button"
                                        aria-label="${msg("showPassword")}"
                                        aria-controls="password"
                                        data-password-toggle
                                        tabindex="4"
                                        data-icon-show="${properties.kcFormPasswordVisibilityIconShow!}"
                                        data-icon-hide="${properties.kcFormPasswordVisibilityIconHide!}"
                                        data-label-show="${msg('showPassword')}"
                                        data-label-hide="${msg('hidePassword')}"
                                >
                                    <i class="${properties.kcFormPasswordVisibilityIconShow!}" aria-hidden="true"></i>
                                </button>
                            </div>
                            <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                                <span id="input-error" class="${properties.kcInputErrorMessageClass!} news-error-message" aria-live="polite">
                                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                </span>
                            </#if>
                        </div>

                        <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!} news-form-options">
                            <div id="kc-form-options" class="news-remember-me">
                                <#if realm.rememberMe && !usernameHidden??>
                                    <div class="checkbox news-checkbox">
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
                            <div class="${properties.kcFormOptionsWrapperClass!} news-forgot-password">
                                <#if realm.resetPasswordAllowed>
                                    <span><a tabindex="6" href="${url.loginResetCredentialsUrl}" class="news-link">${msg("doForgotPassword")}</a></span>
                                </#if>
                            </div>
                        </div>

                        <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} news-form-buttons">
                            <input
                                    type="hidden"
                                    id="id-hidden-input"
                                    name="credentialId"
                                    <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>
                            />
                            <input
                                    tabindex="7"
                                    class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} news-login-button"
                                    name="login"
                                    id="kc-login"
                                    type="submit"
                                    value="${msg("doLogIn")}"
                            />
                        </div>
                    </form>
                </#if>
            </div>
        </div>
        <script type="module" src="${url.resourcesPath}/js/passwordVisibility.js"></script>
    <#elseif section = "info">
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container" class="news-registration-container">
                <div id="kc-registration" class="news-registration">
                    <span>${msg("noAccount")} <a tabindex="8" class="news-register-link" href="${url.registrationUrl}">${msg("doRegister")}</a></span>
                </div>
            </div>
        </#if>
    <#elseif section = "socialProviders">
        <#if realm.password && social?? && social.providers?has_content>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!} news-social-providers">
                <hr class="news-divider"/>
                <h2 class="news-social-title">${msg("identity-provider-login-label")}</h2>
                <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if> news-social-list">
                    <#list social.providers as p>
                        <li class="news-social-item">
                            <a
                                    id="social-${p.alias}"
                                    class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if> news-social-button"
                                    type="button"
                                    href="${p.loginUrl}"
                            >
                                <#if p.iconClasses?has_content>
                                    <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
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

<style>
    :root {
        --news-primary-color: #2874A6;
        --news-secondary-color: #5DADE2;
        --news-accent-color: #F39C12;
        --news-text-color: #333;
        --news-light-text: #666;
        --news-bg-color: #f9f9f9;
        --news-input-bg: #fff;
        --news-border-color: #ddd;
        --news-error-color: #e74c3c;
        --news-success-color: #27ae60;
        --news-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        --news-font: 'Roboto', 'Helvetica Neue', Arial, sans-serif;
    }

    body {
        background-color: var(--news-bg-color);
        font-family: var(--news-font);
        color: var(--news-text-color);
        line-height: 1.6;
    }

    /* Header styles */
    .news-portal-header {
        text-align: center;
        margin-bottom: 2rem;
    }

    .news-logo {
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        font-weight: bold;
        color: var(--news-primary-color);
    }

    .news-icon {
        font-size: 2rem;
        margin-right: 0.5rem;
    }

    .news-title {
        font-size: 1.8rem;
        letter-spacing: 0.5px;
        text-transform: uppercase;
    }

    /* Form container styles */
    .news-form-container {
        background-color: var(--news-input-bg);
        border-radius: 8px;
        box-shadow: var(--news-shadow);
        padding: 2rem;
        max-width: 500px;
        margin: 0 auto;
    }

    .news-form-wrapper {
        width: 100%;
    }

    /* Login intro styles */
    .news-login-intro {
        text-align: center;
        margin-bottom: 2rem;
    }

    .news-login-intro h2 {
        color: var(--news-primary-color);
        font-size: 1.5rem;
        margin-bottom: 0.5rem;
    }

    .news-login-intro p {
        color: var(--news-light-text);
        font-size: 0.9rem;
    }

    /* Form group styles */
    .news-form-group {
        margin-bottom: 1.5rem;
    }

    .news-label {
        display: block;
        font-weight: 500;
        margin-bottom: 0.5rem;
        color: var(--news-primary-color);
    }

    .news-input-wrapper {
        position: relative;
        display: flex;
        align-items: center;
    }

    .news-input-icon {
        position: absolute;
        left: 10px;
        color: var(--news-light-text);
        font-size: 1rem;
    }

    .news-input {
        width: 100%;
        padding: 0.75rem 1rem 0.75rem 2.5rem;
        border: 1px solid var(--news-border-color);
        border-radius: 4px;
        font-size: 1rem;
        transition: border-color 0.2s, box-shadow 0.2s;
    }

    .news-input:focus {
        border-color: var(--news-secondary-color);
        box-shadow: 0 0 0 3px rgba(93, 173, 226, 0.2);
        outline: none;
    }

    .news-password-toggle {
        position: absolute;
        right: 10px;
        background: none;
        border: none;
        color: var(--news-light-text);
        cursor: pointer;
    }

    .news-error-message {
        color: var(--news-error-color);
        font-size: 0.85rem;
        margin-top: 0.5rem;
        display: block;
    }

    /* Form options styles */
    .news-form-options {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1.5rem;
        font-size: 0.9rem;
    }

    .news-checkbox label {
        display: flex;
        align-items: center;
        cursor: pointer;
    }

    .news-checkbox input {
        margin-right: 0.5rem;
    }

    .news-link {
        color: var(--news-primary-color);
        text-decoration: none;
        transition: color 0.2s;
    }

    .news-link:hover {
        color: var(--news-secondary-color);
        text-decoration: underline;
    }

    /* Button styles */
    .news-login-button {
        width: 100%;
        background: var(--news-primary-color);
        color: white;
        border: none;
        border-radius: 4px;
        padding: 0.75rem;
        font-size: 1rem;
        font-weight: 500;
        cursor: pointer;
        transition: background-color 0.2s;
    }

    .news-login-button:hover {
        background-color: var(--news-secondary-color);
    }

    /* Registration styles */
    .news-registration-container {
        text-align: center;
        margin-top: 1.5rem;
    }

    .news-register-link {
        color: var(--news-accent-color);
        font-weight: 500;
        text-decoration: none;
    }

    .news-register-link:hover {
        text-decoration: underline;
    }

    /* Social providers styles */
    .news-divider {
        border: 0;
        height: 1px;
        background-color: var(--news-border-color);
        margin: 2rem 0;
    }

    .news-social-title {
        text-align: center;
        font-size: 1.2rem;
        color: var(--news-primary-color);
        margin-bottom: 1.5rem;
    }

    .news-social-list {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 1rem;
        padding: 0;
        list-style: none;
    }

    .news-social-button {
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #f8f9fa;
        border: 1px solid var(--news-border-color);
        border-radius: 4px;
        padding: 0.75rem 1.5rem;
        text-decoration: none;
        color: var(--news-text-color);
        transition: all 0.2s;
    }

    .news-social-button:hover {
        background-color: #e9ecef;
        transform: translateY(-2px);
    }

    .news-social-button i {
        margin-right: 0.5rem;
    }

    /* Responsive design */
    @media (max-width: 768px) {
        .news-form-container {
            padding: 1.5rem;
            margin: 0 1rem;
        }

        .news-form-options {
            flex-direction: column;
            align-items: flex-start;
            gap: 0.75rem;
        }

        .news-social-list {
            flex-direction: column;
        }
    }

    /* Animation effects */
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .news-form-container {
        animation: fadeIn 0.5s ease-out forwards;
    }
</style>