<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Borrowings Management | AUCA Library</title>
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

        .header {
            margin-bottom: 30px;
        }

        .header h2 {
            color: #D2691E;
            font-size: 2em;
            margin-bottom: 30px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            position: relative;
            padding-bottom: 15px;
            text-align: center;
        }

        .header h2::after {
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

        .role-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 500;
            background: rgba(210, 105, 30, 0.2);
            color: #FFF;
        }

        .btn {
            padding: 12px 20px;
            border: none;
            border-radius: 10px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .return-btn {
            background: linear-gradient(45deg, #8B4513, #D2691E);
            color: white;
            padding: 8px 16px;
            border-radius: 8px;
            text-decoration: none;
            display: inline-block;
        }

        .btn-back {
            background: transparent;
            border: 1px solid rgba(210, 105, 30, 0.5);
            color: #D2691E;
        }

        .btn:hover, .return-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(210, 105, 30, 0.4);
        }

        .button-container {
            display: flex;
            gap: 20px;
            margin-top: 30px;
            justify-content: center;
        }

        .empty-message {
            text-align: center;
            padding: 40px;
            color: #FFF;
            font-size: 1.1em;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }
            
            .btn {
                width: 100%;
            }
            
            .header h2 {
                font-size: 1.5em;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Pending and Overdue Borrowings</h2>
        </div>

        <c:if test="${not empty borrowers}">
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Book Title</th>
                            <th>User</th>
                            <th>Role</th>
                            <th>Pick Up Date</th>
                            <th>Return Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="borrower" items="${borrowers}">
                            <tr>
                                <td>${borrower.book.title}</td>
                                <td>${borrower.reader.firstName} ${borrower.reader.lastName}</td>
                                <td><span class="role-badge">${borrower.reader.role}</span></td>
                                <td><fmt:formatDate value="${borrower.pickup_date}" pattern="yyyy-MM-dd" /></td>
                                <td><fmt:formatDate value="${borrower.dueDate}" pattern="yyyy-MM-dd" /></td>
                                <td>
                                    <a href="returnBook?id=${borrower.id}" class="return-btn">Return</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

        <c:if test="${empty borrowers}">
            <div class="empty-message">
                No borrowings found.
            </div>
        </c:if>

        <div class="button-container">
            <button type="button" onclick="window.location.href='librarianPage.jsp';" 
                    class="btn btn-back">Back to Dashboard</button>
        </div>
    </div>
</body>
</html>
