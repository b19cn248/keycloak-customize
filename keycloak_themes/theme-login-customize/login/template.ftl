<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
    <!DOCTYPE html>
    <html class="${properties.kcHtmlClass!}" lang="${lang}"<#if realm.internationalizationEnabled> dir="${(locale.rtl)?then('rtl','ltr')}"</#if>>

    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="robots" content="noindex, nofollow">
        <meta name="color-scheme" content="light${darkMode?then(' dark', '')}">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <#if properties.meta?has_content>
            <#list properties.meta?split(' ') as meta>
                <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
            </#list>
        </#if>
        <title>${msg("loginTitle",(realm.displayName!'Smart Feeds'))}</title>
        <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
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
        <!-- Custom Smart Feeds styles -->
        <link href="${url.resourcesPath}/css/smartfeeds-auth.css" rel="stylesheet" />

        <#if darkMode>
            <script type="module" async blocking="render">
                const DARK_MODE_CLASS = "${properties.kcDarkModeClass}";
                const mediaQuery = window.matchMedia("(prefers-color-scheme: dark)");

                updateDarkMode(mediaQuery.matches);
                mediaQuery.addEventListener("change", (event) => updateDarkMode(event.matches));

                function updateDarkMode(isEnabled) {
                    const { classList } = document.documentElement;

                    if (isEnabled) {
                        classList.add(DARK_MODE_CLASS);
                    } else {
                        classList.remove(DARK_MODE_CLASS);
                    }
                }
            </script>
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
    </head>

    <body class="${properties.kcBodyClass!} smartfeeds-auth-body" data-page-id="login-${pageId}">
    <div class="${properties.kcLogin!}">
        <div class="${properties.kcLoginContainer!} smartfeeds-auth-container">
            <header id="kc-header" class="smartfeeds-auth-header">
                <div class="smartfeeds-logo-wrapper">
                    <img src="${url.resourcesPath}/img/keycloak-logo-text.svg" alt="Smart Feeds" class="smartfeeds-logo">
                </div>
                <div class="smartfeeds-theme-toggle">
                    <button id="theme-toggle" class="smartfeeds-theme-button" aria-label="Toggle dark mode">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z"></path>
                        </svg>
                    </button>
                </div>
            </header>

            <main class="${properties.kcLoginMain!}">
                <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                    <div class="smartfeeds-alert ${properties.kcAlertClass!} pf-m-${(message.type = 'error')?then('danger', message.type)}">
                        <div class="${properties.kcAlertIconClass!}">
                            <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
                            <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
                            <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
                            <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
                        </div>
                        <span class="${properties.kcAlertTitleClass!}">${kcSanitize(message.summary)?no_esc}</span>
                    </div>
                </#if>

                <div class="smartfeeds-auth-card">
                    <div class="smartfeeds-auth-content">
                        <h1 class="smartfeeds-auth-title"><#nested "header"></h1>
                        <#nested "form">
                    </div>
                </div>

                <div class="smartfeeds-auth-footer">
                    <#nested "socialProviders">

                    <#if displayInfo>
                        <div id="kc-info" class="smartfeeds-info">
                            <div id="kc-info-wrapper">
                                <#nested "info">
                            </div>
                        </div>
                    </#if>
                </div>
            </main>

            <footer class="smartfeeds-footer">
                <p>&copy; ${.now?string('yyyy')} Smart Feeds. All rights reserved.</p>
            </footer>
        </div>
    </div>

    <script>
        // Dark mode toggle functionality
        document.getElementById('theme-toggle').addEventListener('click', function() {
            document.documentElement.classList.toggle('pf-v5-theme-dark');
        });
    </script>
    </body>
    </html>
</#macro>