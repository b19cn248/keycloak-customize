<#import "template.ftl" as layout>
<#import "user-profile-commons.ftl" as userProfileCommons>
<@layout.registrationLayout displayMessage=messagesPerField.exists('global') displayRequiredFields=true; section>
    <#if section = "header">
        ${msg("registerTitle")}
    <#elseif section = "form">
        <form id="kc-register-form" action="${url.registrationAction}" method="post">
            <!-- User Profile Fields -->
            <div class="form-group">
                <label for="firstName">${msg("firstName")}<#if messagesPerField.exists('firstName')><span class="required">*</span></#if></label>
                <input type="text" id="firstName" name="firstName" value="${(register.formData.firstName!'')}"
                       aria-invalid="<#if messagesPerField.existsError('firstName')>true</#if>"/>
                <#if messagesPerField.existsError('firstName')>
                    <span class="error-message">${kcSanitize(messagesPerField.get('firstName'))?no_esc}</span>
                </#if>
            </div>

            <div class="form-group">
                <label for="lastName">${msg("lastName")}<#if messagesPerField.exists('lastName')><span class="required">*</span></#if></label>
                <input type="text" id="lastName" name="lastName" value="${(register.formData.lastName!'')}"
                       aria-invalid="<#if messagesPerField.existsError('lastName')>true</#if>"/>
                <#if messagesPerField.existsError('lastName')>
                    <span class="error-message">${kcSanitize(messagesPerField.get('lastName'))?no_esc}</span>
                </#if>
            </div>

            <div class="form-group">
                <label for="email">${msg("email")}<span class="required">*</span></label>
                <input type="email" id="email" name="email" value="${(register.formData.email!'')}" autocomplete="email"
                       aria-invalid="<#if messagesPerField.existsError('email')>true</#if>"/>
                <#if messagesPerField.existsError('email')>
                    <span class="error-message">${kcSanitize(messagesPerField.get('email'))?no_esc}</span>
                </#if>
            </div>

            <#if !realm.registrationEmailAsUsername>
                <div class="form-group">
                    <label for="username">${msg("username")}<span class="required">*</span></label>
                    <input type="text" id="username" name="username" value="${(register.formData.username!'')}" autocomplete="username"
                           aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"/>
                    <#if messagesPerField.existsError('username')>
                        <span class="error-message">${kcSanitize(messagesPerField.get('username'))?no_esc}</span>
                    </#if>
                </div>
            </#if>

            <#if passwordRequired??>
                <div class="form-group">
                    <label for="password">${msg("password")}<span class="required">*</span></label>
                    <input type="password" id="password" name="password" autocomplete="new-password"
                           aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"/>
                    <#if messagesPerField.existsError('password')>
                        <span class="error-message">${kcSanitize(messagesPerField.get('password'))?no_esc}</span>
                    </#if>
                </div>

                <div class="form-group">
                    <label for="password-confirm">${msg("passwordConfirm")}<span class="required">*</span></label>
                    <input type="password" id="password-confirm" name="password-confirm" autocomplete="new-password"
                           aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"/>
                    <#if messagesPerField.existsError('password-confirm')>
                        <span class="error-message">${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}</span>
                    </#if>
                </div>
            </#if>

            <div class="form-group">
                <button class="btn" type="submit">${msg("doRegister")}</button>
            </div>

            <div class="form-footer">
                <span><a class="text-link" href="${url.loginUrl}">${msg("backToLogin")}</a></span>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>