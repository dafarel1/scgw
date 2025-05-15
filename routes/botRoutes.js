const express = require('express');
const router = express.Router();
const botController = require('../controllers/botController');

// Route for displaying the dashboard
router.get('/', botController.getDashboard);

// Route for executing "Select All Bots"
router.post('/execute', botController.executeAllBots);

module.exports = router;

// Route untuk menerima data otomatis dari script Lua
router.post('/api/data', (req, res) => {
    const receivedData = req.body;
    console.log('Data diterima dari script Lua:', receivedData);
    res.status(200).send('Data berhasil diterima');
});
