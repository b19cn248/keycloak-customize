<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
    <!DOCTYPE html>
    <html class="${properties.kcHtmlClass!}"<#if realm.internationalizationEnabled> lang="${locale.currentLanguageTag}"</#if>>

    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="robots" content="noindex, nofollow">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="gitlab-dast-validation" content="725047a2-e8a6-41f7-b33a-77479efc9d5c">

        <#if properties.meta?has_content>
            <#list properties.meta?split(' ') as meta>
                <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
            </#list>
        </#if>
        <title>${msg("loginTitle",(realm.displayName!''))}</title>
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
        <#if scripts??>
            <#list scripts as script>
                <script src="${script}" type="text/javascript"></script>
            </#list>
        </#if>
        <#if authenticationSession??>
            <script type="module">
                import { checkCookiesAndSetTimer } from "${url.resourcesPath}/js/authChecker.js";

                checkCookiesAndSetTimer(
                    "${authenticationSession.authSessionId}",
                    "${authenticationSession.tabId}",
                    "${url.ssoLoginInOtherTabsUrl}"
                );
            </script>
        </#if>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
            }

            body {
                background-color: #1565c0;
                background-image: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIHZpZXdCb3g9IjAgMCAxMDAgMTAwIiBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSJub25lIj48cGF0aCBmaWxsPSIjMTU2NWMwIiBkPSJNMCAwTDEwMCAwIDEwMCAxMDAgMCAxMDB6Ii8+PGc+PGcgZmlsbC1vcGFjaXR5PSIuMSIgZmlsbD0iI2ZmZiI+PGNpcmNsZSBjeD0iMTAiIGN5PSIzNSIgcj0iMyIvPjxjaXJjbGUgY3g9IjQwIiBjeT0iNzAiIHI9IjQiLz48Y2lyY2xlIGN4PSI3MCIgY3k9IjQwIiByPSIyIi8+PGNpcmNsZSBjeD0iOTUiIGN5PSI4NSIgcj0iMyIvPjxwYXRoIGQ9Ik0xNSAyNUw4NSA4NVoiIHN0cm9rZT0iI2ZmZiIgc3Ryb2tlLW9wYWNpdHk9Ii4yIiBzdHJva2Utd2lkdGg9IjAuNSIvPjxwYXRoIGQ9Ik00MCA4MEw4MCAyMFoiIHN0cm9rZT0iI2ZmZiIgc3Ryb2tlLW9wYWNpdHk9Ii4yIiBzdHJva2Utd2lkdGg9IjAuNSIvPjwvZz48L2c+PHBhdGggZD0iTTAgMEMxMCAxMCAyMCA1IDMwIDE1QzQwIDI1IDUwIDE1IDYwIDI1QzcwIDM1IDgwIDI1IDkwIDM1QzEwMCA0NSAxMDAgMTAwIDEwMCAxMDBIMFoiIGZpbGw9IiMxMTUyOTMiIGZpbGwtb3BhY2l0eT0iLjMiLz48L3N2Zz4=');
                background-repeat: no-repeat;
                background-size: cover;
                background-position: center;
                font-family: 'Roboto', Arial, sans-serif;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
                color: #333;
            }

            .olh-container {
                width: 100%;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                flex: 1;
            }

            .footer-text {
                text-align: center;
                color: rgba(255, 255, 255, 0.8);
                font-size: 0.8rem;
                margin-top: 2rem;
                margin-bottom: 1rem;
            }

            @media (max-width: 480px) {
                body {
                    display: block;
                    background-image: none;
                }
            }
        </style>
    </head>

    <body>
    <div class="olh-container">
        <!-- Content will be inserted here -->
        <#nested "header">

        <#-- App-initiated actions should not see warning messages about the need to complete the action -->
        <#-- during login.                                                                               -->
        <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
            <div class="alert-${message.type} ${properties.kcAlertClass!} pf-m-<#if message.type = 'error'>danger<#else>${message.type}</#if>">
                <div class="pf-c-alert__icon">
                    <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
                    <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
                    <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
                    <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
                </div>
                <span class="${properties.kcAlertTitleClass!}">${kcSanitize(message.summary)?no_esc}</span>
            </div>
        </#if>

        <#nested "form">

        <#if auth?has_content && auth.showTryAnotherWayLink()>
            <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post">
                <div class="${properties.kcFormGroupClass!}">
                    <input type="hidden" name="tryAnotherWay" value="on"/>
                    <a href="#" id="try-another-way"
                       onclick="document.forms['kc-select-try-another-way-form'].submit();return false;">${msg("doTryAnotherWay")}</a>
                </div>
            </form>
        </#if>

        <#nested "socialProviders">

        <#if displayInfo>
            <div id="kc-info" class="${properties.kcSignUpClass!}">
                <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                    <#nested "info">
                </div>
            </div>
        </#if>

        <div class="footer-text">
            Developed by OpenLearnHub
        </div>
    </div>
    </body>
    </html>
</#macro>