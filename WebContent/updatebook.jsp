<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>

<%@ page import="java.util.UUID" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Books</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f7f7f7;
        }
        h1 {
            color: #2e8b57;
        }
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        td {
            background-color: #f9f9f9;
        }
        button, input[type="submit"] {
            padding: 8px 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            margin-top: 10px;
            border-radius: 6px;
        }
        button:hover, input[type="submit"]:hover {
            background-color: #45a049;
        }
        .delete-btn {
            background-color: #e74c3c;
        }
        .delete-btn:hover {
            background-color: #c0392b;
        }
        
    </style>
</head>
<body>
    <h1>Manage Books</h1>

    <!-- Form for Update and Delete -->
    <form method="post">
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
                    List<model.Book> books = (List<model.Book>) request.getAttribute("books");
                    if (books != null) {
                        for (model.Book book : books) {
                %>
                <tr>

                    <!-- Book ID (hidden) -->
                    <td>
                        <input type="text" name="bookId" value="<%= book.getBookId() %>" readonly />
                    </td>

                    <!-- Editable fields -->
                    <td>
                        <input type="number" name="edition_<%= book.getBookId() %>" value="<%= book.getEdition() %>" required />
                    </td>
                    <td>
                        <input type="text" name="title_<%= book.getBookId() %>" value="<%= book.getTitle() %>" required />
                    </td>
                    <td>
                        <input type="text" name="pubName_<%= book.getBookId() %>" value="<%= book.getPub_name() %>" required />
                    </td>
                    <td>
                        <input type="date" name="pubYear_<%= book.getBookId() %>" 
                               value="<%= book.getPub_year() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(book.getPub_year()) : "" %>" />
                    </td>
                    <td>
                        <input type="text" name="isbn_<%= book.getBookId() %>" value="<%= book.getIsbn_code() %>" required />
                    </td>

                    <!-- Dropdown for book status -->
                   <td><%= book.getBookStatus() != null ? book.getBookStatus().name() : "N/A" %></td>




                    <!-- Non-editable Shelf field -->
                    <td>
                        <input type="text" value="<%= book.getShelf() != null ? book.getShelf().getBookCategory() : "N/A" %>" readonly />
                    </td>
                </tr>
                <% 
                        }
                    }
                %>
            </tbody>
        </table>

        <!-- Update and Delete buttons -->
        <div style="margin-top: 20px;">
            <!-- Update Book Details -->
            <button type="submit" formaction="updateBookServlet">Update Book Details</button>

        </div>
    </form>

    <!-- Back to Dashboard Button -->
    <button onclick="window.location.href='librarianPage.jsp';">Back to Dashboard</button>
</body>
</html>
