<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SuperMarché - Connexion</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
    
    
          :root {
            --primary-color: #ffc107;
            --secondary-color: #ff9800;
            --text-color: #2c3e50;
            --bg-color: #f8f9fa;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		    line-height: 1.6;
		    display: flex;
		    flex-direction: column;
		    min-height: 100vh;
		    background-image: url('${pageContext.request.contextPath}/images/Background.jpg');
		    background-size: cover;
		    background-position: center;
		    background-repeat: no-repeat;
		    background-attachment: fixed;
		    position: relative;
        }

        /* Header Styles */
        .header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            padding: 1rem 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .header-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-brand {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: white;
            text-decoration: none;
        }

        .header-logo {
            font-size: 2rem;
        }

        .header-title {
            margin: 0;
            font-size: 1.5rem;
        }

        .header-tools {
            display: flex;
            gap: 1rem;
        }

        .header-tool {
            color: white;
            text-decoration: none;
            padding: 0.5rem;
            border-radius: 50%;
            transition: all 0.3s;
        }

        .header-tool:hover {
            background: rgba(255,255,255,0.2);
        }

        /* Navbar Styles */
        .navbar {
            background: #333;
            padding: 0;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }

        .nav-list {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            padding: 1rem 1.5rem;
            display: block;
            transition: background-color 0.3s;
        }

        .nav-link:hover {
            background:  orange;
        }

        .nav-link.active {
            background: var(--primary-color);
            color: black;
        }

        /* Main Content Styles */
        .main-container {
            flex: 1;
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .content-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .content-title {
            margin: 0;
            font-size: 1.8rem;
            color: var(--text-color);
        }

        .main-container {
            flex: 1;
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }

        @media (max-width: 768px) {
            .header-container {
                flex-direction: column;
                text-align: center;
            }

            .header-tools {
                margin-top: 1rem;
            }

            .nav-list {
                flex-direction: column;
            }

            .nav-link {
                width: 100%;
                text-align: center;
            }

            .nav-right {
                margin: 0;
                width: 100%;
                justify-content: center;
            }
        }

        .login-container {
            max-width: 400px;
            margin: 3rem auto;
            background: rgba(0, 0, 0, 0.5);
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .login-header {
            background: linear-gradient(135deg, var(--primary-color), #ff9800);
            color: white;
            padding: 1rem;
            text-align: center;
        }

        .login-header i {
            font-size: 3rem;
            margin-bottom: 0.5rem;
        }

        .login-header h2 {
            margin: 0;
            font-size: 1.5rem;
        }

        .login-body {
            padding: 2rem;
        }

        .input-group {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .input-group i.input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }

        .form-control {
            width: 100%;
            padding: 0.8rem 1rem 0.8rem 2.5rem;
            font-size: 1rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            background-color: var(--bg-color);
            transition: all 0.3s ease;
            box-sizing: border-box;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(255, 193, 7, 0.25);
            background-color: white;
        }

        .password-toggle {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #6c757d;
            cursor: pointer;
            padding: 0;
        }

        .password-toggle:hover {
            color: var(--primary-color);
        }

        .remember-me {
            margin: 1rem 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #666;
        }

        .login-button {
            width: 100%;
            padding: 0.8rem;
            background: linear-gradient(135deg, var(--primary-color), #ff9800);
            border: none;
            border-radius: 8px;
            color: white;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .login-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 193, 7, 0.4);
        }

        .signup-link {
            text-align: center;
            margin-top: 1.5rem;
            color: #666;
        }

        .signup-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }

        @media (max-width: 576px) {
            .login-container {
                margin: 1rem;
                width: auto;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <i class="fas fa-shopping-cart"></i>
            <h2>SuperMarché</h2>
            <p>Portail de connexion</p>
        </div>
        
        <div class="login-body">
            <form action="auth" method="post">
                <input type="hidden" name="action" value="login">
                
                <div class="input-group">
                    <i class="fas fa-envelope input-icon"></i>
                    <input type="email" 
                           class="form-control" 
                           id="email" 
                           name="email" 
                           placeholder="Adresse email"
                           required>
                </div>

                <div class="input-group">
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password" 
                           class="form-control" 
                           id="password" 
                           name="password" 
                           placeholder="Mot de passe"
                           required>
                    <button type="button" class="password-toggle" onclick="togglePassword()">
                        <i class="far fa-eye"></i>
                    </button>
                </div>

                <div class="remember-me">
                    <input type="checkbox" id="remember" name="remember">
                    <label for="remember" style="color : white">Se souvenir de moi</label>
                </div>

                <button type="submit" class="login-button">
                    <i class="fas fa-sign-in-alt"></i> Se connecter
                </button>
            </form>

            <div class="signup-link " style="color : white">
                Pas encore de compte ? 
                <a href="auth?action=signup">Créer un compte</a>
            </div>
        </div>
    </div>

    <script>
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const toggleButton = document.querySelector('.password-toggle i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleButton.classList.remove('fa-eye');
                toggleButton.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleButton.classList.remove('fa-eye-slash');
                toggleButton.classList.add('fa-eye');
            }
        }
    </script>
</body>
</html>