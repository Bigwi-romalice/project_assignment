<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Management Dashboard | AUCA Library</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #6B73FF 0%, #000DFF 100%);
            min-height: 100vh;
            color: #333;
        }

        .container {
            display: flex;
            min-height: 100vh;
            animation: fadeIn 0.5s ease-out;
        }

        /* Sidebar Styling */
        .sidebar {
            width: 300px;
            background: white;
            padding: 40px 20px;
            display: flex;
            flex-direction: column;
            box-shadow: 5px 0 15px rgba(0, 0, 0, 0.1);
            position: fixed;
            height: 100%;
        }

        .sidebar h2 {
            color: #333;
            font-size: 1.8em;
            text-align: center;
            margin-bottom: 40px;
            padding-bottom: 20px;
            border-bottom: 2px solid rgba(107, 115, 255, 0.2);
        }

        .nav-item {
            margin-bottom: 15px;
            width: 100%;
        }

        .nav-link {
            display: block;
            padding: 14px 20px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            background: white;
            color: #6B73FF;
            border: 2px solid #6B73FF;
            text-align: center;
        }

        .nav-link:hover {
            background: linear-gradient(135deg, #6B73FF, #000DFF);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(107, 115, 255, 0.4);
        }

        .logout-btn {
            margin-top: auto;
            background: linear-gradient(135deg, #FF6B6B, #FF0000) !important;
            color: white !important;
            border: none !important;
        }

        .logout-btn:hover {
            background: linear-gradient(135deg, #FF5252, #E60000) !important;
        }

        /* Main Content Styling */
        .main-content {
            flex: 1;
            margin-left: 300px;
            padding: 40px;
        }

        .content-card {
            background: white;
            padding: 40px;
            border-radius: 30px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
            margin-bottom: 30px;
        }

        h1 {
            color: #333;
            font-size: 2.5em;
            margin-bottom: 20px;
            position: relative;
            padding-bottom: 15px;
        }

        h1::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100px;
            height: 4px;
            background: linear-gradient(135deg, #6B73FF, #000DFF);
            border-radius: 2px;
        }

        p {
            color: #666;
            font-size: 1.1em;
            line-height: 1.6;
            margin-bottom: 30px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        .stat-card {
            background: rgba(107, 115, 255, 0.1);
            padding: 20px;
            border-radius: 15px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
                padding: 20px;
            }

            .main-content {
                margin-left: 0;
                padding: 20px;
            }

            .content-card {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <h2>Management Dashboard</h2>
            <div class="nav-item">
                <a href="loadBooks" class="nav-link">View Book List</a>
            </div>
            <div class="nav-item">
                <a href="provinceName.jsp" class="nav-link">Display Province</a>
            </div>
            <div class="nav-item">
                <a href="logout.jsp" class="nav-link logout-btn">Logout</a>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="content-card">
                <h1>Welcome, Management!</h1>
                <p>Access and manage library system functionalities from your dashboard.</p>
                
                <!-- Optional: Add statistics cards -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <h3>Total Books</h3>
                        <p>View and manage the library catalog</p>
                    </div>
                    <div class="stat-card">
                        <h3>Provinces</h3>
                        <p>View province distribution</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>