const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const PORT = 3000;

// Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.set('view engine', 'ejs');

// Data sementara untuk menyimpan informasi dari bot
let botData = {
    gems: 0,
    worlds: 0,
    seeds: 0,
    storage: 0,
    packs: 0
};

// Endpoint untuk menerima data dari script Lua
app.post('/api/data', (req, res) => {
    botData = req.body; // Simpan data yang diterima
    console.log('Data diterima:', botData);
    res.status(200).send('Data berhasil diterima');
});

// Endpoint untuk menampilkan dashboard
app.get('/', (req, res) => {
    res.render('index', { botData });
});

// Jalankan server
app.listen(PORT, () => {
    console.log(`Server berjalan di http://localhost:${PORT}`);
});
