<div class="kc-login" style="
    width: 400px;
    margin: 100px auto;
    padding: 40px;
    background: rgba(255, 255, 255, 0.8);
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    font-family: 'Arial', sans-serif;
">
    <h1 style="
        text-align: center;
        font-size: 28px;
        margin-bottom: 30px;
        color: #333;
    ">
        ${msg("loginTitle")}
    </h1>

    <form action="${url.loginAction}" method="post">
        <label for="username" style="font-size: 14px; color: #666; display: block; margin-bottom: 5px;">
            ${msg("username")}
        </label>
        <input id="username" name="username" type="text" autofocus="true" required style="
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        ">

        <label for="password" style="font-size: 14px; color: #666; display: block; margin-bottom: 5px;">
            ${msg("password")}
        </label>
        <input id="password" name="password" type="password" required style="
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        ">

        <button type="submit" style="
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        ">
            ${msg("login")}
        </button>
    </form>

    <div class="kc-footer" style="text-align: center; margin-top: 20px; color: #999; font-size: 12px;">
        <p>&copy; 2024 Your Company. All rights reserved.</p>
    </div>
</div>
