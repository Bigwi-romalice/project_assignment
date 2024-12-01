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
            max-width: 1400px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 25px 45px rgba(0, 0, 0, 0.2);
        }

        .header {
            margin-bottom: 30px;
        }

        .header h1 {
            color: #D2691E;
            font-size: 2em;
            margin-bottom: 30px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            position: relative;
            padding-bottom: 15px;
            text-align: center;
        }

        .header h1::after {
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
            margin-bottom: 30px;
            border-radius: 15px;
            background: rgba(255, 255, 255, 0.05);
        }

        table {
            width: 100%;
            border-collapse: collapse;
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

        input[type="radio"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: #D2691E;
        }

        .button-container {
            display: flex;
            gap: 20px;
            margin-top: 30px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            padding: 14px 25px;
            border: none;
            border-radius: 10px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            min-width: 200px;
        }

        .btn-primary {
            background: linear-gradient(45deg, #8B4513, #D2691E);
            color: white;
        }

        .btn-secondary {
            background: transparent;
            border: 1px solid rgba(210, 105, 30, 0.5);
            color: #D2691E;
        }

        .btn-danger {
            background: linear-gradient(45deg, #8B4513, #D2691E);
            color: white;
            opacity: 0.9;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(210, 105, 30, 0.4);
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            .button-container {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }

            th, td {
                padding: 10px;
                font-size: 0.9em;
            }

            .header h1 {
                font-size: 1.5em;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Book List</h1>
        </div>

        <form method="post" action="deleteBookServlet">
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
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            @SuppressWarnings("unchecked")
                            List<model.Book> books = (List<model.Book>) request.getAttribute("books");
                            if (books != null) {
                                for (model.Book book : books) {
                        %>
                        <tr>
                            <td><%= book.getBookId() %></td>
                            <td><%= book.getEdition() %></td>
                            <td><%= book.getTitle() %></td>
                            <td><%= book.getPub_name() %></td>
                            <td><%= book.getPub_year() != null ? book.getPub_year().toString() : "N/A" %></td>
                            <td><%= book.getIsbn_code() %></td>
                            <td><%= book.getBookStatus() != null ? book.getBookStatus().name() : "N/A" %></td>
                            <td><%= book.getShelf() != null ? book.getShelf().getBookCategory(): "N/A" %></td>
                            <td>
                                <input type="radio" name="bookId" value="<%= book.getBookId() %>" />
                            </td>
                        </tr>
                        <%  
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <div class="button-container">
                <a href="updateBooks" class="btn btn-primary">Update Book Details</a>
                <button type="submit" formaction="deleteBookServlet" class="btn btn-danger">Delete Selected Book</button>
                <button type="button" onclick="window.location.href='addBook.jsp';" 
                        class="btn btn-secondary">Back to Add Book</button>
            </div>
        </form>
    </div>
</body>
</html>
