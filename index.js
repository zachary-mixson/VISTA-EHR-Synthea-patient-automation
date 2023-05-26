const axios = require('axios');
const fs = require('fs');
const path = require('path');

const directoryPath = './json/fhir';
const url = 'edu2.opensourcevista.net:9290/addpatient?load1/';

fs.readdirSync(directoryPath).forEach(file => {
    if (path.extname(file) === '.json') {
        const filePath = path.join(directoryPath, file);
        const jsonData = JSON.parse(fs.readFileSync(filePath, 'utf-8'));

        axios.post(url, jsonData)
            .then(response => {
                console.log(`POST request sent for ${file}: ${response.data}`);
            })
            .catch(error => {
                console.error(`Error sending POST request for ${file}: ${error.response.data}`);
            });
    }
});
