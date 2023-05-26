const axios = require('axios');
const fs = require('fs');
const path = require('path');

const directoryPath = './json';
const url = 'http://localhost:3000/data';

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
