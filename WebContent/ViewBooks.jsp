<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book List | AUCA Library</title>
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
            padding: 20px;
            color: #FFF;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            width: 95%;
            max-width: 1200px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 25px 45px rgba(0, 0, 0, 0.2);
        }

        .container h2 {
            color: #D2691E;
            font-size: 2em;
            margin-bottom: 30px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            position: relative;
            padding-bottom: 15px;
            text-align: center;
        }

        .container h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: linear-gradient(90deg, #8B4513, #D2691E);
            border-radius: 2px;
        }

        .table-container {
            overflow-x: auto;
            margin: 20px 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            color: #FFF;
        }

        th {
            background: rgba(210, 105, 30, 0.2);
            font-weight: 600;
            font-size: 0.9em;
        }

        tr:hover {
            background: rgba(210, 105, 30, 0.1);
        }

        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 500;
        }

        .status-available {
            background: rgba(76, 175, 80, 0.2);
            color: #4CAF50;
        }

        .status-borrowed {
            background: rgba(255, 152, 0, 0.2);
            color: #FF9800;
        }

        .status-received {
            background: rgba(33, 150, 243, 0.2);
            color: #2196F3;
        }

        .btn {
            width: 200px;
            padding: 14px;
            border: none;
            border-radius: 10px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin: 20px auto;
            display: block;
        }

        .btn-secondary {
            background: transparent;
            border: 1px solid rgba(210, 105, 30, 0.5);
            color: #D2691E;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(210, 105, 30, 0.4);
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: rgba(255, 255, 255, 0.7);
            font-size: 1.1em;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            th, td {
                padding: 10px;
                font-size: 0.9em;
            }

            .container h2 {
                font-size: 1.5em;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Book List</h2>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Edition</th>
                        <th>Title</th>
                        <th>Publisher Name</th>
                        <th>Publication Year</th>
                        <th>ISBN Code</th>
                        <th>Status</th>
                        <th>Shelf Name</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        @SuppressWarnings("unchecked")
                        List<model.Book> books = (List<model.Book>)request.getAttribute("books");
                        if (books != null && !books.isEmpty()) {
                            for (model.Book book : books) {
                    %>
                    <tr>
                        <td><%= book.getBookId() %></td>
                        <td><%= book.getEdition() %></td>
                        <td><%= book.getTitle() %></td>
                        <td><%= book.getPub_name() %></td>
                        <td><%= book.getPub_year() != null ? book.getPub_year().toString() : "N/A" %></td>
                        <td><%= book.getIsbn_code() %></td>
                        <td>
                            <span class="status-badge status-<%= book.getBookStatus() != null ? 
                                book.getBookStatus().name().toLowerCase() : "na" %>">
                                <%= book.getBookStatus() != null ? book.getBookStatus().name() : "N/A" %>
                            </span>
                        </td>
                        <td><%= book.getShelf() != null ? book.getShelf().getBookCategory(): "N/A" %></td>
                    </tr>
                    <%  
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="8" class="empty-state">No books available</td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <button type="button" onclick="window.location.href='addBook.jsp';" 
                class="btn btn-secondary">Back to Add Book</button>
    </div>
</body>
</html>
