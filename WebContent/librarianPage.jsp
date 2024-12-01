<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Librarian Dashboard</title>
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
            padding-top: 80px;
            color: #FFF;
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
            padding: 15px 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            z-index: 1000;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
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

        .nav-button {
            background: transparent;
            border: none;
            color: #FFF;
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 0.9em;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
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

        /* Content Styling */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .content {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 25px 45px rgba(0, 0, 0, 0.2);
        }

        h1 {
            color: #D2691E;
            font-size: 2.5em;
            margin-bottom: 20px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        p {
            color: #DDD;
            font-size: 1.1em;
            line-height: 1.6;
            margin-bottom: 30px;
        }

        /* Table Styling */
        .stats-table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 15px;
            overflow: hidden;
            margin-top: 30px;
        }

        .stats-table th, 
        .stats-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            color: #FFF;
        }

        .stats-table th {
            background: rgba(210, 105, 30, 0.2);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9em;
            letter-spacing: 0.5px;
        }

        .stats-table tr:hover {
            background: rgba(210, 105, 30, 0.1);
        }

        .book-count {
            color: #D2691E;
            font-weight: 600;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-5px); }
        }

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
            <a href="viewPendingMemberships" class="nav-button">View Pending Memberships</a>
            <a href="DisplayAllBorrowers" class="nav-button">View Borrowings</a>
            <a href="addBook.jsp" class="nav-button">Add New Books</a>
            <a href="loadBooks" class="nav-button">Update/Delete Books</a>
            <form action="logout.jsp" method="post" style="margin: 0;">
                <button type="submit" class="logout-btn">Logout</button>
            </form>
        </div>
        <button class="toggle-btn" id="toggleBtn">☰</button>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <div class="content">
            <h1>Welcome, Librarian!</h1>
            <p>Here you can manage library records, view pending memberships, and handle book borrowings.</p>
            
            <%@ page import="java.util.*, model.Room, model.Shelf, model.Book" %>
            <%@ page import="org.hibernate.Session, org.hibernate.query.Query" %>
            <%@ page import="util.HibernateUtil" %>
            
            <table class="stats-table">
                <thead>
                    <tr>
                        <th>Room Code</th>
                        <th>Number of Books</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Session hibernateSession = HibernateUtil.getSession().openSession();
                        try {
                            String hql = "SELECT r, COUNT(b) FROM Room r " +
                                        "LEFT JOIN r.shelves s " +
                                        "LEFT JOIN s.books b " +
                                        "GROUP BY r";
                            Query<Object[]> query = hibernateSession.createQuery(hql, Object[].class);
                            List<Object[]> results = query.getResultList();
                            
                            for (Object[] result : results) {
                                Room room = (Room) result[0];
                                Long bookCount = (Long) result[1];
                    %>
                                <tr>
                                    <td><%= room.getRoomCode() %></td>
                                    <td class="book-count"><%= bookCount %></td>
                                </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            hibernateSession.close();
                        }
                    %>
                </tbody>
            </table>
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
