<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
    <!DOCTYPE html>
    <html class="${properties.kcHtmlClass!}" lang="${locale.currentLanguageTag!'en'}">

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

        <style>
            :root {
                --primary-color: #1a73e8;
                --secondary-color: #f8f9fa;
                --text-color: #202124;
                --border-color: #dadce0;
                --focus-color: #1a73e8;
                --error-color: #d93025;
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
                width: 100%;
            }

            .smart-feeds-logo {
                text-align: center;
                margin-bottom: 30px;
            }

            .smart-feeds-logo h1 {
                font-size: 28px;
                font-weight: 500;
                color: var(--primary-color);
                margin: 0;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .smart-feeds-logo h1::before {
                content: "";
                display: inline-block;
                width: 24px;
                height: 24px;
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='%231a73e8' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='M4 11a9 9 0 0 1 9 9'%3E%3C/path%3E%3Cpath d='M4 4a16 16 0 0 1 16 16'%3E%3C/path%3E%3Ccircle cx='5' cy='19' r='1'%3E%3C/circle%3E%3C/svg%3E");
                margin-right: 10px;
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

            .label-with-link {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .float-right {
                font-size: 14px;
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

            .btn-secondary {
                background-color: #f1f3f4;
                color: #3c4043;
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
            }

            .text-link:hover {
                text-decoration: underline;
            }

            .alert {
                padding: 12px 16px;
                margin-bottom: 20px;
                border-radius: 4px;
                border-left: 4px solid;
                font-size: 14px;
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

            .alert-warning {
                background-color: #fff8e1;
                border-left-color: #f9a825;
                color: #996500;
            }

            .alert-info {
                background-color: #e8f0fe;
                border-left-color: #1a73e8;
                color: #174ea6;
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

            .checkbox-group {
                display: flex;
                align-items: center;
            }

            .checkbox-label {
                display: flex;
                align-items: center;
                cursor: pointer;
                font-size: 14px;
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
                color: #5f6368;
            }

            @media (max-width: 480px) {
                .login-container {
                    max-width: 100%;
                    box-shadow: none;
                    border-radius: 0;
                    padding: 24px 16px;
                }

                body {
                    background-color: white;
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