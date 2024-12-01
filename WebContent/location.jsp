<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Select Location</title>
    <script>
   
    let locationData = [];  // This will store the array of provinces from the JSON

    window.onload = function () {
        fetch('/Webtech_Mid_exam/location/rwandaLocations.json')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                console.log("JSON data loaded:", data); // Log to verify
                locationData = data.data;  // Set locationData to the array of provinces
                populateProvinces();
            })
            .catch(error => {
                console.error("Error loading JSON file:", error);
            });
    };

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
    <div id="error" style="color:red; display:none;"></div>
    <form action="register" method="post">
<select id="province" name="province" onchange="populateDistricts();">
    <option value="">Select Province</option>
</select>

<select id="district" name="district" onchange="populateSectors();">
    <option value="">Select District</option>
</select>

<select id="sector" name="sector" onchange="populateCells();">
    <option value="">Select Sector</option>
</select>

<select id="cell" name="cell" onchange="populateVillages();">
    <option value="">Select Cell</option>
</select>

<select id="village" name="village">
    <option value="">Select Village</option>
</select>

<input type="submit" value="Submit" onclick="validateSelections(event)">

    </form>
</body>

</html>
