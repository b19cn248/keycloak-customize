<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
    <!DOCTYPE html>
    <html class="${properties.kcHtmlClass!}" lang="${lang}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${msg("loginTitle",(realm.displayName!''))}</title>

        <style>
            :root {
                --primary-color: #1a73e8;
                --secondary-color: #f8f9fa;
                --text-color: #202124;
                --border-color: #dadce0;
                --focus-color: #1a73e8;
                --error-color: #d93025;
            }

            body {
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
                margin: 0;
                padding: 0;
                display: flex;
                min-height: 100vh;
                background-color: #f8f9fa;
                color: var(--text-color);
            }

            .login-container {
                max-width: 420px;
                margin: auto;
                padding: 40px 30px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            }

            .smart-feeds-logo {
                text-align: center;
                margin-bottom: 30px;
            }

            .smart-feeds-logo h1 {
                font-size: 24px;
                font-weight: 500;
                color: var(--primary-color);
                margin: 0;
            }

            .form-group {
                margin-bottom: 24px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-size: 14px;
                font-weight: 500;
            }

            input[type="text"],
            input[type="password"],
            input[type="email"] {
                width: 100%;
                padding: 12px 16px;
                font-size: 16px;
                border: 1px solid var(--border-color);
                border-radius: 4px;
                box-sizing: border-box;
                transition: border-color 0.2s;
            }

            input:focus {
                outline: none;
                border-color: var(--focus-color);
                box-shadow: 0 0 0 2px rgba(26,115,232,0.2);
            }

            .btn {
                display: block;
                width: 100%;
                padding: 12px 16px;
                background-color: var(--primary-color);
                color: white;
                border: none;
                border-radius: 4px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.2s;
            }

            .btn:hover {
                background-color: #0d65d9;
            }

            .text-center {
                text-align: center;
            }

            .text-link {
                color: var(--primary-color);
                text-decoration: none;
                font-weight: 500;
            }

            .text-link:hover {
                text-decoration: underline;
            }

            .alert {
                padding: 12px 16px;
                margin-bottom: 20px;
                border-radius: 4px;
                border-left: 4px solid;
            }

            .alert-error {
                background-color: #fce8e6;
                border-left-color: var(--error-color);
                color: var(--error-color);
            }

            .alert-success {
                background-color: #e6f4ea;
                border-left-color: #0f9d58;
                color: #0f9d58;
            }

            .form-footer {
                margin-top: 24px;
                font-size: 14px;
                text-align: center;
            }

            .form-header {
                margin-bottom: 32px;
                text-align: center;
            }

            .form-header h2 {
                font-size: 24px;
                font-weight: 500;
                margin: 0;
                color: var(--text-color);
            }

            @media (max-width: 480px) {
                .login-container {
                    max-width: 100%;
                    box-shadow: none;
                    border-radius: 0;
                }
            }
        </style>

        <!-- Các script được import từ Keycloak -->
        <#if properties.scripts?has_content>
            <#list properties.scripts?split(' ') as script>
                <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
            </#list>
        </#if>
    </head>

    <body>
    <div class="login-container" role="main">
        <div class="smart-feeds-logo">
            <h1>Smart Feeds</h1>
        </div>

        <div class="form-header">
            <h2><#nested "header"></h2>
        </div>

        <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
            <div class="alert alert-${message.type}">
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
    </body>
    </html>
</#macro>