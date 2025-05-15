<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
    <!DOCTYPE html>
    <html class="${properties.kcHtmlClass!}" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="robots" content="noindex, nofollow">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <#if properties.meta?has_content>
            <#list properties.meta?split(' ') as meta>
                <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
            </#list>
        </#if>
        <title>${msg("loginTitle",(realm.displayName!''))}</title>
        <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

        <style>
            :root {
                --primary-color: #1a73e8;
                --primary-hover: #1669d9;
                --primary-active: #135cbe;
                --secondary-color: #f8f9fa;
                --text-color: #202124;
                --text-secondary: #5f6368;
                --border-color: #dadce0;
                --focus-color: #1a73e8;
                --error-color: #d93025;
                --shadow-sm: 0 2px 6px rgba(0,0,0,0.08);
                --shadow-md: 0 4px 12px rgba(0,0,0,0.12);
            }

            * {
                box-sizing: border-box;
            }

            body {
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
                margin: 0;
                padding: 0;
                display: flex;
                min-height: 100vh;
                background: linear-gradient(135deg, #f7faff 0%, #e4f0ff 100%);
                color: var(--text-color);
                align-items: center;
                justify-content: center;
            }

            .login-container {
                max-width: 420px;
                margin: auto;
                padding: 40px 32px;
                background: white;
                border-radius: 12px;
                box-shadow: var(--shadow-md);
                width: 100%;
                border: 1px solid rgba(0,0,0,0.05);
                animation: fadeIn 0.5s ease;
            }

            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(10px); }
                to { opacity: 1; transform: translateY(0); }
            }

            .smart-feeds-logo {
                text-align: center;
                margin-bottom: 24px;
            }

            .smart-feeds-logo a {
                display: inline-flex;
                align-items: center;
                text-decoration: none;
                color: var(--primary-color);
                font-size: 28px;
                font-weight: 500;
                transition: transform 0.2s ease;
            }

            .smart-feeds-logo a:hover {
                transform: scale(1.03);
            }

            .smart-feeds-logo i {
                margin-right: 10px;
                font-size: 24px;
            }

            .form-group {
                margin-bottom: 24px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-size: 14px;
                font-weight: 500;
                color: var(--text-color);
            }

            .label-with-link {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .float-right {
                font-size: 14px;
            }

            .input-wrapper {
                position: relative;
            }

            .input-wrapper i {
                position: absolute;
                left: 14px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--text-secondary);
                font-size: 16px;
            }

            input[type="text"],
            input[type="password"],
            input[type="email"] {
                width: 100%;
                padding: 12px 16px 12px 40px;
                font-size: 16px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                transition: all 0.2s;
                background-color: #f7f9fc;
            }

            input:focus {
                outline: none;
                border-color: var(--focus-color);
                box-shadow: 0 0 0 2px rgba(26,115,232,0.2);
                background-color: #fff;
            }

            .password-toggle {
                position: absolute;
                right: 12px;
                top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                color: var(--text-secondary);
                cursor: pointer;
                font-size: 16px;
            }

            .password-toggle:hover {
                color: var(--primary-color);
            }

            .btn {
                display: flex;
                width: 100%;
                padding: 13px 16px;
                background-color: var(--primary-color);
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.2s, transform 0.1s;
                justify-content: center;
                align-items: center;
                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            }

            .btn i {
                margin-right: 8px;
            }

            .btn:hover {
                background-color: var(--primary-hover);
                box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            }

            .btn:active {
                background-color: var(--primary-active);
                transform: translateY(1px);
            }

            .btn-secondary {
                background-color: #f1f3f4;
                color: var(--text-color);
                margin-top: 10px;
            }

            .btn-secondary:hover {
                background-color: #e8eaed;
            }

            .text-center {
                text-align: center;
            }

            .text-link {
                color: var(--primary-color);
                text-decoration: none;
                font-weight: 500;
                transition: color 0.2s;
            }

            .text-link:hover {
                color: var(--primary-hover);
                text-decoration: underline;
            }

            .alert {
                padding: 12px 16px;
                margin-bottom: 20px;
                border-radius: 8px;
                font-size: 14px;
                display: flex;
                align-items: center;
            }

            .alert i {
                margin-right: 10px;
                font-size: 16px;
            }

            .alert-error {
                background-color: #fce8e6;
                color: var(--error-color);
            }

            .alert-success {
                background-color: #e6f4ea;
                color: #0f9d58;
            }

            .alert-warning {
                background-color: #fff8e1;
                color: #996500;
            }

            .alert-info {
                background-color: #e8f0fe;
                color: #174ea6;
            }

            .form-footer {
                margin-top: 24px;
                text-align: center;
                font-size: 14px;
                color: var(--text-secondary);
            }

            .form-header {
                margin-bottom: 28px;
                text-align: center;
            }

            .form-header h2 {
                font-size: 24px;
                font-weight: 600;
                margin: 0;
                color: var(--text-color);
            }

            .checkbox-group {
                display: flex;
                align-items: center;
            }

            .checkbox-label {
                display: flex;
                align-items: center;
                cursor: pointer;
                font-size: 14px;
                color: var(--text-secondary);
            }

            .checkbox-label input {
                margin-right: 8px;
            }

            .error-message {
                color: var(--error-color);
                font-size: 12px;
                margin-top: 4px;
                display: block;
            }

            .required {
                color: var(--error-color);
                margin-left: 4px;
            }

            .instruction {
                font-size: 14px;
                margin-bottom: 24px;
                color: var(--text-secondary);
            }

            @media (max-width: 480px) {
                .login-container {
                    max-width: 100%;
                    box-shadow: none;
                    border-radius: 0;
                    padding: 24px 16px;
                    margin: 0;
                    height: 100vh;
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                }

                body {
                    background: white;
                }
            }
        </style>

        <#if properties.stylesCommon?has_content>
            <#list properties.stylesCommon?split(' ') as style>
                <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
            </#list>
        </#if>
        <#if properties.styles?has_content>
            <#list properties.styles?split(' ') as style>
                <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
            </#list>
        </#if>
        <#if properties.scripts?has_content>
            <#list properties.scripts?split(' ') as script>
                <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
            </#list>
        </#if>
        <script type="importmap">
            {
                "imports": {
                    "rfc4648": "${url.resourcesCommonPath}/vendor/rfc4648/rfc4648.js"
            }
        }
        </script>
        <#if scripts??>
            <#list scripts as script>
                <script src="${script}" type="text/javascript"></script>
            </#list>
        </#if>
        <script type="module">
            import { startSessionPolling } from "${url.resourcesPath}/js/authChecker.js";
            startSessionPolling("${url.ssoLoginInOtherTabsUrl?no_esc}");
        </script>
    </head>

    <body>
    <div class="login-container" role="main">
        <div class="smart-feeds-logo">
            <a href="#">
                <i class="fas fa-rss"></i>
                <span>Smart Feeds</span>
            </a>
        </div>

        <div class="form-header">
            <h2><#nested "header"></h2>
        </div>

        <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
            <div class="alert alert-${message.type}">
                <#if message.type = 'success'><i class="fas fa-check-circle"></i></#if>
                <#if message.type = 'warning'><i class="fas fa-exclamation-triangle"></i></#if>
                <#if message.type = 'error'><i class="fas fa-times-circle"></i></#if>
                <#if message.type = 'info'><i class="fas fa-info-circle"></i></#if>
                ${kcSanitize(message.summary)?no_esc}
            </div>
        </#if>

        <#nested "form">

        <#if displayInfo>
            <div class="form-footer">
                <#nested "info">
            </div>
        </#if>
    </div>

    <script>
        // Toggle password visibility
        document.addEventListener('DOMContentLoaded', function() {
            const toggleButtons = document.querySelectorAll('.password-toggle');

            toggleButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const passwordInput = this.previousElementSibling;
                    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    passwordInput.setAttribute('type', type);

                    // Toggle icon
                    if (type === 'text') {
                        this.innerHTML = '<i class="fas fa-eye-slash"></i>';
                    } else {
                        this.innerHTML = '<i class="fas fa-eye"></i>';
                    }
                });
            });
        });
    </script>
    </body>
    </html>
</#macro>