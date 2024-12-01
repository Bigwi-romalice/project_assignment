<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Registration | AUCA Library</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            width: 800px;
            max-width: 95%;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 25px 45px rgba(0, 0, 0, 0.2);
        }

        h2 {
            color: #D2691E;
            text-align: center;
            font-size: 2em;
            margin-bottom: 30px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            color: #FFF;
            margin-bottom: 8px;
            font-size: 0.9em;
            letter-spacing: 0.5px;
        }

        input[type="text"],
        input[type="password"],
        select {
            width: 100%;
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            padding: 12px 20px;
            color: #FFF;
            font-size: 1em;
            transition: all 0.3s ease;
        }

        input:focus,
        select:focus {
            background: rgba(255, 255, 255, 0.12);
            border-color: #D2691E;
            outline: none;
            box-shadow: 0 0 0 3px rgba(210, 105, 30, 0.2);
        }

        input::placeholder,
        select::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' fill='%23D2691E'%3E%3Cpath d='M6 8L0 0h12z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 15px center;
            padding-right: 40px;
        }

        select option {
            background: #1E1E1E;
            color: #FFF;
        }

        .location-section {
            background: rgba(210, 105, 30, 0.1);
            padding: 30px;
            border-radius: 15px;
            margin-top: 30px;
            border: 1px solid rgba(210, 105, 30, 0.2);
        }

        .location-section h3 {
            color: #D2691E;
            margin-bottom: 20px;
            font-size: 1.5em;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
        }

        .btn-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-top: 30px;
        }

        .btn {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 12px;
            font-size: 1em;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-register {
            background: linear-gradient(45deg, #8B4513, #D2691E);
            color: white;
        }

        .btn-login {
            background: transparent;
            border: 1px solid #D2691E;
            color: #D2691E;
            text-decoration: none;
            text-align: center;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(210, 105, 30, 0.4);
        }

        #membershipDiv {
            grid-column: span 2;
            padding: 20px;
            background: rgba(210, 105, 30, 0.1);
            border-radius: 12px;
            margin-top: 20px;
            border: 1px solid rgba(210, 105, 30, 0.2);
        }

        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .btn-container {
                grid-template-columns: 1fr;
            }

            #membershipDiv {
                grid-column: span 1;
            }
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
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            fetch('location/rwandaLocations.json')
                .then(response => response.json())
                .then(data => {
                    console.log(data);  // Log to see if data is loaded correctly
                    initializeLocationDropdowns(data.data);
                })
                .catch(error => console.error('Error loading the location data:', error));
        });

        function initializeLocationDropdowns(locationData) {
            const provinceDropdown = document.getElementById('province');
            locationData.forEach(provinceData => {
                const provinceName = Object.keys(provinceData)[0];  // Get the province name
                const option = document.createElement('option');
                option.value = provinceName;
                option.text = provinceName;
                provinceDropdown.add(option);
            });
        }

        // Existing location-based JavaScript functions here
        window.onload = function() {
            fetch('/Webtech_Mid_exam/location/rwandaLocations.json')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    console.log("JSON data loaded:", data);
                    locationData = data.data;
                    populateProvinces();
                })
                .catch(error => {
                    console.error("Error loading JSON file:", error);
                });
                toggleMembership();
            // Initialize membership visibility based on role selection

        };
        function toggleMembership() {
            const roleSelect = document.getElementById("role");
            const membershipDiv = document.getElementById("membershipDiv");

            if (roleSelect.value === "LIBRARIAN" || roleSelect.value === "DEAN" || roleSelect.value === "MANAGER") {

                membershipDiv.style.display = "none";
            } else {
                membershipDiv.style.display = "block";
            }
        }

        function populateProvinces() {
            const provinceDropdown = document.getElementById("province");
            provinceDropdown.innerHTML = '<option value="">Select Province</option>';
            locationData.forEach(provinceObj => {
                let provinceName = Object.keys(provinceObj)[0];  // Get the province name
                let option = document.createElement("option");
                option.text = provinceName;
                option.value = provinceName;
                provinceDropdown.add(option);
            });
        }

        function populateDistricts() {
            const provinceName = document.getElementById("province").value;
            const districtDropdown = document.getElementById("district");
            districtDropdown.innerHTML = '<option value="">Select District</option>';
            districtDropdown.disabled = true;  // Disable in case there's no data

            const provinceObj = locationData.find(p => Object.keys(p)[0] === provinceName);
            
            if (provinceObj && provinceObj[provinceName]) {
                provinceObj[provinceName].forEach(districtObj => {
                    let districtName = Object.keys(districtObj)[0];
                    let option = document.createElement("option");
                    option.text = districtName;
                    option.value = districtName;
                    districtDropdown.add(option);
                });
                districtDropdown.disabled = false;  // Enable if options were added
            } else {
                console.error("No districts found for selected province:", provinceName);
            }

            // Reset and disable the following dropdowns
            resetAndDisable(["sector", "cell", "village"]);
        }

        function populateSectors() {
            const provinceName = document.getElementById("province").value;
            const districtName = document.getElementById("district").value;
            const sectorDropdown = document.getElementById("sector");
            sectorDropdown.innerHTML = '<option value="">Select Sector</option>';
            sectorDropdown.disabled = true;

            const provinceObj = locationData.find(p => Object.keys(p)[0] === provinceName);
            const districtObj = provinceObj[provinceName].find(d => Object.keys(d)[0] === districtName);

            if (districtObj && districtObj[districtName]) {
                districtObj[districtName].forEach(sectorObj => {
                    let sectorName = Object.keys(sectorObj)[0];
                    let option = document.createElement("option");
                    option.text = sectorName;
                    option.value = sectorName;
                    sectorDropdown.add(option);
                });
                sectorDropdown.disabled = false;
            } else {
                console.error("No sectors found for selected district:", districtName);
            }

            resetAndDisable(["cell", "village"]);
        }

        function populateCells() {
            const provinceName = document.getElementById("province").value;
            const districtName = document.getElementById("district").value;
            const sectorName = document.getElementById("sector").value;
            const cellDropdown = document.getElementById("cell");
            cellDropdown.innerHTML = '<option value="">Select Cell</option>';
            cellDropdown.disabled = true;

            // Find the selected province object
            const provinceObj = locationData.find(p => Object.keys(p)[0] === provinceName);
            if (!provinceObj) return;

            // Find the selected district object
            const districtObj = provinceObj[provinceName].find(d => Object.keys(d)[0] === districtName);
            if (!districtObj) return;

            // Find the selected sector object
            const sectorObj = districtObj[districtName].find(s => Object.keys(s)[0] === sectorName);
            if (!sectorObj) return;

            // Populate cells dropdown with options
            if (sectorObj[sectorName]) {
                sectorObj[sectorName].forEach(cell => {
                    let cellName = typeof cell === "object" ? Object.keys(cell)[0] : cell;
                    let option = document.createElement("option");
                    option.text = cellName;
                    option.value = cellName;
                    cellDropdown.add(option);
                });
                cellDropdown.disabled = false;
            } else {
                console.error("No cells found for selected sector:", sectorName);
            }

            resetAndDisable(["village"]);
        }

        function populateVillages() {
            const provinceName = document.getElementById("province").value;
            const districtName = document.getElementById("district").value;
            const sectorName = document.getElementById("sector").value;
            const cellName = document.getElementById("cell").value;
            const villageDropdown = document.getElementById("village");
            villageDropdown.innerHTML = '<option value="">Select Village</option>';
            villageDropdown.disabled = true;

            // Find the selected province object
            const provinceObj = locationData.find(p => Object.keys(p)[0] === provinceName);
            if (!provinceObj) return;

            // Find the selected district object
            const districtObj = provinceObj[provinceName].find(d => Object.keys(d)[0] === districtName);
            if (!districtObj) return;

            // Find the selected sector object
            const sectorObj = districtObj[districtName].find(s => Object.keys(s)[0] === sectorName);
            if (!sectorObj) return;

            // Find the selected cell object
            const cellObj = sectorObj[sectorName].find(c => (typeof c === "object" ? Object.keys(c)[0] : c) === cellName);
            if (!cellObj) return;

            // Populate villages dropdown with options
            if (cellObj[cellName] && Array.isArray(cellObj[cellName])) {
                cellObj[cellName].forEach(village => {
                    let villageName = typeof village === "object" ? Object.keys(village)[0] : village;
                    let option = document.createElement("option");
                    option.text = villageName;
                    option.value = villageName;
                    villageDropdown.add(option);
                });
                villageDropdown.disabled = false;
            } else {
                console.error("No villages found or villages data is not an array for cell:", cellName);
            }
        }



        // Utility function to reset and disable specified dropdowns
        function resetAndDisable(ids) {
            ids.forEach(id => {
                const dropdown = document.getElementById(id);
                dropdown.innerHTML = `<option value="">Select ${id.charAt(0).toUpperCase() + id.slice(1)}</option>`;
                dropdown.disabled = true;
            });
        }

        function validateSelections(event) {
            const province = document.getElementById("province").value;
            const district = document.getElementById("district").value;
            const sector = document.getElementById("sector").value;
            const cell = document.getElementById("cell").value;
            const village = document.getElementById("village").value;

            if (!province || !district || !sector || !cell || !village) {
                alert("Please make a selection in each dropdown.");
                event.preventDefault();  // Prevent form submission if any dropdown is unselected
            }
        }
        
    </script>
</head>
<body>
    <div class="container">
        <h2>Create Your Account</h2>
        <form action="register" method="post">
            <div class="form-grid">
                <div class="form-group">
                    <label for="firstName">First Name</label>
                    <input type="text" name="firstName" placeholder="Enter your first name" required/>
                </div>

                <div class="form-group">
                    <label for="lastName">Last Name</label>
                    <input type="text" name="lastName" placeholder="Enter your last name" required/>
                </div>

                <div class="form-group">
                    <label for="gender">Gender</label>
                    <select name="gender" required>
                        <option value="">Select gender</option>
                        <option value="MALE">Male</option>
                        <option value="FEMALE">Female</option>
                        <option value="OTHER">Other</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="phoneNumber">Phone Number</label>
                    <input type="text" name="phoneNumber" placeholder="Enter your phone number" required/>
                </div>

                <div class="form-group">
                    <label for="userName">Username</label>
                    <input type="text" name="userName" placeholder="Choose a username" required/>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" name="password" placeholder="Create a password" required/>
                </div>

                <div class="form-group">
                    <label for="role">Role</label>
                    <select name="role" id="role" onchange="toggleMembership();" required>
                        <option value="">Select role</option>
                        <option value="STUDENT">Student</option>
                        <option value="TEACHER">Teacher</option>
                        <option value="MANAGER">Manager</option>
                        <option value="LIBRARIAN">Librarian</option>
                        <option value="DEAN">Dean</option>
                    </select>
                </div>

                <div id="membershipDiv" style="display: none;">
                    <label for="membership">Membership Type</label>
                    <select name="membershipTypeId" id="membership">
                        <c:forEach var="membership" items="${membershipTypes}">
                            <option value="${membership.membershipTypeId}">
                                ${membership.membershipName}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="location-section">
                <h3>Location Details</h3>
                <div class="form-grid">
                    <div class="form-group">
                        <label for="province">Province</label>
                        <input type="text" id="province" name="province" placeholder="Enter Province" required/>
                    </div>

                    <div class="form-group">
                        <label for="district">District</label>
                        <input type="text" id="district" name="district" placeholder="Enter District" required/>
                    </div>

                    <div class="form-group">
                        <label for="sector">Sector</label>
                        <input type="text" id="sector" name="sector" placeholder="Enter Sector" required/>
                    </div>

                    <div class="form-group">
                        <label for="cell">Cell</label>
                        <input type="text" id="cell" name="cell" placeholder="Enter Cell" required/>
                    </div>

                    <div class="form-group">
                        <label for="village">Village</label>
                        <input type="text" id="village" name="village" placeholder="Enter Village" required/>
                    </div>
                </div>
            </div>

            <div class="btn-container">
                <button type="submit" class="btn btn-register" onclick="validateSelections(event)">Create Account</button>
                <a href="login.jsp" class="btn btn-login">Back to Login</a>
            </div>
        </form>
    </div>
</body>
</html>
