<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Home Page</title>
  <link rel="stylesheet" href="styles.css"> <!-- External stylesheet -->
  <style>
    /* Add basic styles */
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

    nav {
      background-color: #0056b3;
      display: flex;
      justify-content: center;
      padding: 10px 0;
    }

    nav a {
      color: white;
      text-decoration: none;
      margin: 0 15px;
      font-weight: bold;
    }

    nav a:hover {
      text-decoration: underline;
    }

    .hero {
      background: url('https://via.placeholder.com/1200x400') no-repeat center center/cover;
      color: white;
      text-align: center;
      padding: 100px 20px;
    }

    .hero h1 {
      font-size: 3rem;
      margin: 0;
    }

    .hero p {
      font-size: 1.2rem;
      margin-top: 10px;
    }

    .container {
      max-width: 1100px;
      margin: 20px auto;
      padding: 0 20px;
    }

    .content {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
    }

    .card {
      background-color: #f4f4f4;
      border: 1px solid #ddd;
      border-radius: 8px;
      padding: 20px;
      flex: 1 1 calc(33.333% - 40px);
      box-sizing: border-box;
      text-align: center;
    }

    .card h3 {
      margin-top: 0;
    }

   footer {
    background: rgba(34, 34, 34, 0.95);
    color: white;
    text-align: center;
    padding: 1rem 0;
    margin-top: auto;
    position: relative;
    border-top: 1px solid rgba(255, 255, 255, 0.1);
}

footer p {
    margin: 0;
    font-size: 0.9rem;
    color: rgba(255, 255, 255, 0.8);
    display: flex;
    justify-content: center;
    align-items: center;
}

/* Adjust body to ensure footer stays at bottom */
body {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

.main-container {
    flex: 1;
}

@media (max-width: 768px) {
    footer {
        padding: 0.8rem 0;
    }
    
    footer p {
        font-size: 0.8rem;
    }
}

    @media (max-width: 768px) {
      .hero h1 {
        font-size: 2rem;
      }

      .content {
        flex-direction: column;
      }

      .card {
        flex: 1 1 100%;
      }
    }
  </style>
</head>
<body>
  <header>
    <h1>Welcome to My Website</h1>
    <p>Your tagline goes here</p>
  </header>
  


  <main class="container">
    <h2>Our Features</h2>
    <div class="content">
      <div class="card">
        <h3>Feature 1</h3>
        <p>Brief description of this feature.</p>
      </div>
      <div class="card">
        <h3>Feature 2</h3>
        <p>Brief description of this feature.</p>
      </div>
      <div class="card">
        <h3>Feature 3</h3>
        <p>Brief description of this feature.</p>
      </div>
    </div>
  </main>

  <footer>
    <p>&copy; 2025 My Website. All rights reserved.</p>
  </footer>
</body>
</html>
