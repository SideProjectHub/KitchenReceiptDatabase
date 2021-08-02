const express = require('express'); 
const mongoose = require('mongoose');
const fridge_router = express.Router(); 
const Fridge = require('../schemas/fridgeSchema'); 
const User = require('../schemas/userSchema'); 

//Get the basic information of all fridges user has 
fridge_router.get('/getFridge/:uid', async function(req, res) { 
    var uid = req.params.uid
    if (uid == null || uid == undefined){ 
        res.status(400).send('Missing User UID')
        return; 
    }

    //Intialize json list to hold fridge
    User.findOne({uid: uid}, '-_id fridgeList')
    .then(async function(user){ 
        try{
            console.log(user.fridgeList);
            var data = await Fridge.find({_id : {$in: user.fridgeList}});
            console.log(data);
            res.send(data);
        } catch{ 
            res.status(404).send('Cant get fridge data');
        };
    }).catch(err => { 
        res.status(404).send('UserProfile currently unavailable ' + err);
    });
}); 

//TODO: Adds a new fridge to user's fridge list 
fridge_router.post('/addFridge', (req, res) => {  

});

module.exports = fridge_router; 