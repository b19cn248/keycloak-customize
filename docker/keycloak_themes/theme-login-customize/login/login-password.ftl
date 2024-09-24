<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enter Password</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            text-align: center;
        }

        .logo {
            margin-bottom: 50px;
        }

        .user-email {
            font-size: 16px;
            margin-bottom: 20px;
            color: #555;
        }

        input[type="password"] {
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
    </style>
</head>
<body>

<div class="login-container">
    <div class="logo">
        <img src="${url.resourcesPath}/img/logo.png" alt="Logo" />
    </div>

    <!-- Display the username or email -->
    <div class="user-email">
        ${auth.attemptedUsername!''} <!-- Use auth.attemptedUsername to display the previously entered username -->
    </div>

    <form action="${url.loginAction}" method="post">
        <input id="password" name="password" type="password" placeholder="パスワード" autofocus="true" required>

        <button type="submit">ログイン</button>
    </form>
</div>

</body>
</html>
