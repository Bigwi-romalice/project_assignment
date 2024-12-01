<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Province | AUCA Library</title>
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
            width: 500px;
            max-width: 95%;
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

        .form-group input {
            width: 100%;
            padding: 12px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            font-size: 1em;
            color: #FFF;
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            border-color: #D2691E;
            outline: none;
            box-shadow: 0 0 0 3px rgba(210, 105, 30, 0.2);
        }

        .btn {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 10px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-bottom: 15px;
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

        .output {
            margin-top: 30px;
            padding: 20px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            text-align: center;
            font-weight: 500;
            color: #FFF;
        }

        @media (max-width: 480px) {
            .container {
                padding: 30px 20px;
            }
            
            .container h2 {
                font-size: 1.5em;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Search Province</h2>
        <form action="searchProvince" method="post">
            <div class="form-group">
                <label for="phoneNumber">Phone Number</label>
                <input type="text" id="phoneNumber" name="phoneNumber" 
                       placeholder="Enter your phone number" required>
            </div>

            <button type="submit" class="btn btn-primary">Search Province</button>
            <button type="button" onclick="history.back()" 
                    class="btn btn-secondary">Back</button>
        </form>

        <div class="output">
            <%
                String province = request.getAttribute("provinceName") != null 
                                ? (String) request.getAttribute("provinceName") 
                                : "";
                if (!province.isEmpty()) {
                    out.print("Province: " + province);
                }
            %>
        </div>
    </div>
</body>
</html>
