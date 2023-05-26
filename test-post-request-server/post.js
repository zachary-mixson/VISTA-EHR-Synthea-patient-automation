const express = require('express');
const fs = require("fs");

const app = express();
app.use(express.json());

app.post('/data', (req, res) => {
    const jsonData = req.body;

    fs.writeFile('data.json', JSON.stringify(jsonData), (err) => {
        if (err) {
            console.error(err);
            res.status(500).send('Error saving data');
        } else {
            res.status(200).send('Data saved successfully');
        }
    });
});

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});
