<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f9f9f9;
            font-family: 'Arial', sans-serif;
        }

        .login-container {
            text-align: center;
        }

        .logo {
            margin-bottom: 50px;
        }

        input[type="text"] {
            width: 300px;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        button {
            padding: 10px 20px;
            background-color: white;
            color: #333;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            cursor: pointer;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        button:hover {
            background-color: #f0f0f0;
        }

        .reset-password {
            margin-top: 20px;
        }

        .reset-password a {
            color: #4CAF50;
            text-decoration: none;
            font-size: 14px;
        }

        .reset-password a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="login-container">
    <div class="logo">
        <img src="${url.resourcesPath}/img/logo.png" alt="Logo" />
    </div>

    <form action="${url.loginAction}" method="post">
        <input id="username" name="username" type="text" placeholder="メールアドレス" autofocus="true" required>
        <button type="submit">ログイン</button>
    </form>

    <!-- Reset password link -->
    <div class="reset-password">
        <a href="${url.loginResetCredentialsUrl}">パスワードをお忘れですか?</a> <!-- "Forgot your password?" in Japanese -->
    </div>
</div>

</body>
</html>
