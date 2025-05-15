const botData = {
    gems: 0,
    worlds: 0,
    seeds: 0,
    storage: 0,
    packs: 0
};

// Simulate fetching data from the Lucifer bot system
function fetchBotData() {
    // Replace this mock data with actual API calls or integrations
    return {
        gems: Math.floor(Math.random() * 10000), // Random data for demonstration
        worlds: 15,
        seeds: 120,
        storage: 50,
        packs: 30
    };
}

// Controller for displaying the dashboard
exports.getDashboard = (req, res) => {
    const data = fetchBotData();
    res.render('index', { botData: data });
};

// Controller for executing "Select All Bots"
exports.executeAllBots = (req, res) => {
    console.log('Executing "Select All Bots" command...');
    res.redirect('/');
};