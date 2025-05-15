const express = require('express');
const bodyParser = require('body-parser');
const botRoutes = require('./routes/botRoutes');

const app = express();
const PORT = 3000;

// Middleware
app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static('public'));

// Routes
app.use('/', botRoutes);

// Start Server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});