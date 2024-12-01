<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Membership" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pending Memberships | AUCA Library</title>
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

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 12px 20px;
            border: none;
            border-radius: 10px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-approve {
            background: linear-gradient(45deg, #8B4513, #D2691E);
            color: white;
        }

        .btn-decline {
            background: transparent;
            border: 1px solid rgba(210, 105, 30, 0.5);
            color: #D2691E;
        }

        .btn-add {
            background: linear-gradient(45deg, #8B4513, #D2691E);
            color: white;
        }

        .btn-back {
            background: transparent;
            border: 1px solid rgba(210, 105, 30, 0.5);
            color: #D2691E;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(210, 105, 30, 0.4);
        }

        .button-container {
            display: flex;
            gap: 20px;
            margin-top: 30px;
            justify-content: center;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }
            
            .action-buttons {
                flex-direction: column;
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
            <h2>Pending Memberships</h2>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Membership ID</th>
                        <th>User</th>
                        <th>Membership Type</th>
                        <th>Registration Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="membership" items="${pendingMemberships}">
                        <tr>
                            <td>${membership.membershipId}</td>
                            <td>${membership.reader.firstName} ${membership.reader.lastName}</td>
                            <td>${membership.membershipType.membershipName}</td>
                            <td>${membership.reg_date}</td>
                            <td>
                                <form method="post" action="viewPendingMemberships">
                                    <input type="hidden" name="id" value="${membership.membershipId}" />
                                    <div class="action-buttons">
                                        <button type="submit" name="action" value="approve" class="btn btn-approve">Approve</button>
                                        <button type="submit" name="action" value="decline" class="btn btn-decline">Decline</button>
                                    </div>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="button-container">
            <button type="button" onclick="window.location.href='librarianPage.jsp';" 
                    class="btn btn-back">Back to Dashboard</button>
        </div>
    </div>
</body>
</html>
