<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Borrow a Book | AUCA Library</title>
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

        .message {
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 30px;
            text-align: center;
            font-weight: 500;
            background: rgba(255, 255, 255, 0.1);
        }

        .message.success {
            border: 1px solid #4CAF50;
            color: #4CAF50;
        }

        .message.error {
            border: 1px solid #FF5252;
            color: #FF5252;
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

        input[type="date"] {
            width: 100%;
            max-width: 300px;
            padding: 12px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            font-size: 1em;
            color: #FFF;
            transition: all 0.3s ease;
        }

        input[type="date"]:focus {
            border-color: #D2691E;
            outline: none;
            box-shadow: 0 0 0 3px rgba(210, 105, 30, 0.2);
        }

        input[type="radio"] {
            width: 18px;
            height: 18px;
            margin-right: 10px;
            cursor: pointer;
            accent-color: #D2691E;
        }

        .button-container {
            display: flex;
            gap: 20px;
            margin-top: 30px;
            justify-content: center;
        }

        .btn {
            padding: 14px 25px;
            border: none;
            border-radius: 10px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            min-width: 150px;
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
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Borrow a Book</h2>

        <c:if test="${not empty message}">
            <div class="message ${message == 'Book borrowed successfully!' ? 'success' : 'error'}">
                ${message}
            </div>
        </c:if>

        <c:choose>
            <c:when test="${not empty availableBooks}">
                <form action="borrowBook" method="post">
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Edition</th>
                                    <th>Publisher</th>
                                    <th>Publication Year</th>
                                    <th>ISBN</th>
                                    <th>Available Stock</th>
                                    <th>Select</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="book" items="${availableBooks}">
                                    <tr>
                                        <td>${book.title}</td>
                                        <td>${book.edition}</td>
                                        <td>${book.pub_name}</td>
                                        <td>${book.pub_year}</td>
                                        <td>${book.isbn_code}</td>
                                        <td>${book.shelf.available_stock}</td>
                                        <td>
                                            <input type="radio" name="bookId" value="${book.bookId}" required>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="form-group">
                        <label for="returnDate">Select Planned Return Date:</label>
                        <input type="date" id="returnDate" name="returnDate" required>
                    </div>

                    <div class="button-container">
                        <button type="submit" class="btn btn-primary">Borrow Selected Book</button>
                        <button type="button" onclick="window.location.href='student.jsp';" 
                                class="btn btn-secondary">Back to Dashboard</button>
                    </div>
                </form>
            </c:when>
            <c:otherwise>
                <div class="message error">
                    No books are available for borrowing at this time.
                </div>
                <div class="button-container">
                    <button type="button" onclick="window.location.href='student.jsp';" 
                            class="btn btn-secondary">Back to Dashboard</button>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
