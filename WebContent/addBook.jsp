<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Shelf" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Book | AUCA Library</title>
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

        /* Update Navbar Styling */
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

        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
            color: #D2691E;
            font-size: 1.5em;
            font-weight: 600;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .logo span {
            font-size: 1.2em;
            animation: float 3s ease-in-out infinite;
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

        /* Add toggle button styling for mobile */
        .toggle-btn {
            display: none;
            background: none;
            border: none;
            color: #FFF;
            font-size: 1.5em;
            cursor: pointer;
        }

        @media (max-width: 768px) {
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
        }

        /* Update container to remove grid layout */
        .container {
            max-width: 800px;  /* Reduced since we don't need side panel */
            margin: 20px auto;
            padding: 20px;
        }

        /* Remove nav-panel related styles since we're moving links to top navbar */
        .nav-links {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        @media (max-width: 768px) {
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
        }

        /* Form Container */
        .form-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 25px 45px rgba(0, 0, 0, 0.2);
        }

        .form-container h2 {
            color: #D2691E;
            font-size: 2em;
            margin-bottom: 30px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            position: relative;
            padding-bottom: 15px;
        }

        .form-container h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100px;
            height: 4px;
            background: linear-gradient(90deg, #8B4513, #D2691E);
            border-radius: 2px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #FFF;
            font-weight: 500;
            font-size: 0.9em;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            font-size: 1em;
            color: #FFF;
            transition: all 0.3s ease;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: #D2691E;
            outline: none;
            box-shadow: 0 0 0 3px rgba(210, 105, 30, 0.2);
        }

        .form-group option {
            background: #1E1E1E;
            color: #FFF;
        }

        .submit-btn {
            background: linear-gradient(45deg, #8B4513, #D2691E);
            color: white;
            padding: 14px 30px;
            border: none;
            border-radius: 10px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 20px;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(210, 105, 30, 0.4);
        }

        .submit-btn:disabled {
            background: rgba(255, 255, 255, 0.1);
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        @media (max-width: 768px) {
            .container {
                grid-template-columns: 1fr;
            }

            .form-container {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="logo">
            <span>📚</span>
            AUCA Library
        </div>
        <div class="nav-links" id="navLinks">
            <button onclick="location.href='addRoom.jsp'" class="nav-button">Add New Room</button>
            <button onclick="location.href='loadRooms'" class="nav-button">Add New Shelf</button>
            <a href="loadBooks" class="nav-button">View Book List</a>
            <button onclick="window.location.href='librarianPage.jsp';" class="nav-button">Back to Dashboard</button>
            <form action="logout.jsp" method="post" style="margin: 0;">
                <button type="submit" class="logout-btn">Logout</button>
            </form>
        </div>
        <button class="toggle-btn" id="toggleBtn">☰</button>
    </nav>

    <div class="container">
        <!-- Form Container -->
        <div class="form-container">
            <h2>Add a New Book</h2>
            <form action="BookServlet" method="post">
                <div class="form-group">
                    <label for="title">Title:</label>
                    <input type="text" id="title" name="title" required>
                </div>

                <div class="form-group">
                    <label for="edition">Edition:</label>
                    <input type="number" id="edition" name="edition" required>
                </div>

                <div class="form-group">
                    <label for="pub_name">Publisher Name:</label>
                    <input type="text" id="pub_name" name="pub_name" required>
                </div>

                <div class="form-group">
                    <label for="pub_year">Publication Year:</label>
                    <input type="date" id="pub_year" name="pub_year" required>
                </div>

                <div class="form-group">
                    <label for="isbn_code">ISBN Code:</label>
                    <input type="text" id="isbn_code" name="isbn_code" required>
                </div>

                <div class="form-group">
                    <label for="bookStatus">Book Status:</label>
                    <select id="bookStatus" name="bookStatus" required>
                        <option value="AVAILABLE">Available</option>
                        <option value="BORROWED">Borrowed</option>
                        <option value="RECEIVED">Received</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="shelf_id">Shelf:</label>
                    <select id="shelf_id" name="shelf_id" required>
                        <%
                            @SuppressWarnings("unchecked")
                            List<Shelf> shelves = (List<Shelf>) request.getAttribute("shelves");
                            if (shelves != null && !shelves.isEmpty()) {
                                for (Shelf shelf : shelves) {
                        %>
                            <option value="<%= shelf.getShelfId().toString() %>">
                                <%= shelf.getBookCategory() %>
                            </option>
                        <%
                                }
                            } else {
                        %>
                            <option value="" disabled>No shelves available</option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <button type="submit" class="submit-btn" 
                    <%= (shelves == null || shelves.isEmpty()) ? "disabled" : "" %>>
                    Add Book
                </button>
            </form>
        </div>
    </div>
</body>
</html>
