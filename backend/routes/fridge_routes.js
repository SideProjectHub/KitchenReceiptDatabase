const express = require('express'); 
const fridge_router = express.Router(); 
const Fridge = require('../schemas/fridgeSchema'); 

//TODO: Get the basic information of all fridges user has 
fridge_router.get('/GetFridge', (req, res) => { 

}); 

//TODO: Adds a new fridge to user's fridge list 
fridge_router.post('/Add Fridge', (req, res) => { 

});

module.exports = fridge_router; 