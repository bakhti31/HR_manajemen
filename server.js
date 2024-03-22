// // server.js

// const express = require('express');
// const sqlite3 = require('sqlite3').verbose();

// const app = express();
// const port = 3000;

// // Connect to SQLite database
// const db = new sqlite3.Database(':memory:');

// // Create table for employee performance
// db.serialize(() => {
//     db.run("CREATE TABLE IF NOT EXISTS performance (id INTEGER PRIMARY KEY, employee_id INTEGER, performance TEXT)");
// });

// // Get performance data for a specific employee
// app.get('/performance/:employeeId', (req, res) => {
//     const employeeId = req.params.employeeId;

//     db.all("SELECT * FROM performance WHERE employee_id = ?", [employeeId], (err, rows) => {
//         if (err) {
//             res.status(500).json({ error: err.message });
//             return;
//         }
//         res.json(rows);
//     });
// });

// // Start server
// app.listen(port, () => {
//     console.log(`Server is running on http://localhost:${port}`);
// });




//////////////////////////////////// 
// Its First version that error tho
/////////////////////////////////////
// server.js

const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const bodyParser = require('body-parser');
var cors = require('cors')

const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use(cors())
// Connect to SQLite database
const db = new sqlite3.Database('manajemen.db');

// Create tables
db.serialize(() => {
    db.run("CREATE TABLE IF NOT EXISTS employees (id INTEGER PRIMARY KEY, name TEXT, position TEXT)");
    db.run("CREATE TABLE IF NOT EXISTS performance (id INTEGER PRIMARY KEY, employee_id INTEGER, month INTEGER, year INTEGER, rating TEXT)");
    db.run("CREATE TABLE IF NOT EXISTS attendance (id INTEGER PRIMARY KEY, employee_id INTEGER, date TEXT)");
});

// Register employee
app.post('/register', (req, res) => {
    console.log("Registering");
    const { name, position } = req.body;

    db.run("INSERT INTO employees (name, position) VALUES (?, ?)", [name, position], function(err) {
        if (err) {
            res.status(500).json({ error: err.message });
            return;
        }
        console.log("Registered : "+name+" With Position:"+position);
        res.json({ id: this.lastID });
    });
});

// Input performance
app.post('/performance', (req, res) => {
    const { employee_id, month, year, rating } = req.body;

    db.run("INSERT INTO performance (employee_id, month, year, rating) VALUES (?, ?, ?, ?)", [employee_id, month, year, rating], function(err) {
        if (err) {
            res.status(500).json({ error: err.message });
            return;
        }
        res.json({ id: this.lastID });
    });
});

// Input attendance
app.post('/attendance', (req, res) => {
    const { employee_id, date } = req.body;

    db.run("INSERT INTO attendance (employee_id, date) VALUES (?, ?)", [employee_id, date], function(err) {
        if (err) {
            res.status(500).json({ error: err.message });
            return;
        }
        res.json({ id: this.lastID });
    });
});

// Get employee performance for a specific month and year
app.get('/performance/:employeeId/', (req, res) => {
    const { employeeId } = req.params;
    console.log("Accessing");
    db.all("SELECT * FROM performance WHERE employee_id = ?", [employeeId], (err, rows) => {
        if (err) {
            res.status(500).json({ error: err.message });
            return;
        }
        res.json(rows);
    });
});
app.get('/employees', (req, res) => {
    db.all("SELECT * FROM employees", (err, rows) => {
        if (err) {
            res.status(500).json({ error: err.message });
            return;
        }
        res.json(rows);
    });
});



// Start server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
