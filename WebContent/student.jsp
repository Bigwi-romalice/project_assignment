<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.query.Query" %>
<%@ page import="util.HibernateUtil" %>
<%@ page import="model.Borrower" %>
<%@ page import="model.Book" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard | AUCA Library</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: #1E1E1E;
            background-image: 
                radial-gradient(at 40% 20%, rgba(139, 69, 19, 0.4) 0px, transparent 50%),
                radial-gradient(at 80% 0%, rgba(210, 105, 30, 0.3) 0px, transparent 50%),
                radial-gradient(at 0% 50%, rgba(160, 82, 45, 0.4) 0px, transparent 50%);
            min-height: 100vh;
            margin: 0;
            padding-top: 80px; /* Space for fixed navbar */
        }

        /* Navbar Styling */
        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding: 10px 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            z-index: 1000;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            height: 60px;
        }

        .logo-container {
            text-align: center;
            margin-bottom: 0;
        }

        .logo {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 1px solid rgba(210, 105, 30, 0.5);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            margin: 0;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .nav-links form {
            margin: 0;
        }

        .nav-button {
            background: transparent;
            border: none;
            color: #FFF;
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 0.9em;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .nav-button:hover {
            background: rgba(210, 105, 30, 0.2);
            transform: translateY(-2px);
        }

        .logout-btn {
            background: linear-gradient(45deg, #8B4513, #D2691E);
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(210, 105, 30, 0.4);
        }

        /* Main Content Styling */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .main-content {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 25px 45px rgba(0, 0, 0, 0.2);
        }

        .welcome-section {
            text-align: center;
            padding: 40px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 15px;
            position: relative;
            overflow: hidden;
            animation: fadeIn 0.8s ease-out;
        }

        .welcome-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #8B4513, #D2691E);
            border-radius: 4px;
        }

        h1 {
            color: #D2691E;
            font-size: 2.5em;
            margin-bottom: 20px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .welcome-section p {
            color: #DDD;
            font-size: 1.1em;
            line-height: 1.6;
        }

        /* Animations */
        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-5px); }
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Mobile Responsive */
        @media (max-width: 768px) {
            .navbar {
                padding: 15px 20px;
            }

            .nav-links {
                display: none;
                position: absolute;
                top: 100%;
                left: 0;
                right: 0;
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(10px);
                padding: 20px;
                flex-direction: column;
                gap: 10px;
            }

            .nav-links.expanded {
                display: flex;
            }

            .toggle-btn {
                display: block;
            }

            .container {
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="logo-container" style="display: flex; align-items: center; gap: 15px;">
            <img src="images/Auca2.png" alt="AUCA Library Logo" class="logo">
            <span style="color: #D2691E; font-size: 1.5em; font-weight: 600; text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);">
                AUCA Library
            </span>
        </div>
        <div class="nav-links" id="navLinks">
            <form action="checkMembershipStatus" method="post">
                <button type="submit" name="action" value="borrowBook" class="nav-button">Borrow a Book</button>
            </form>
            <button onclick="window.location.href='provinceName.jsp';" class="nav-button">Display Province</button>
            <form action="logout.jsp" method="post">
                <button type="submit" class="logout-btn">Logout</button>
            </form>
        </div>
        <button class="toggle-btn" id="toggleBtn">☰</button>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <div class="main-content">
            <div class="welcome-section">
                <h1>Welcome to Student Dashboard</h1>
                <p>You can borrow books and manage your library activities here.</p>
            </div>
        </div>
    </div>

    <script>
        const navLinks = document.getElementById('navLinks');
        const toggleBtn = document.getElementById('toggleBtn');

        toggleBtn.addEventListener('click', () => {
            navLinks.classList.toggle('expanded');
        });
    </script>
</body>
</html>

