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

    var data = [];
    //Intialize json list to hold fridge
    User.findOne({uid: uid}, '_id fridgeList')
    .then(async function(user){ 
        console.log((user._id.toString()));
        console.log(user.fridgeList[1].toString());
        Object.entries(user.fridgeList).forEach(async function(ele) { 
            await Fridge.findOne({_id: ele[1].toString()}, '-foodList')
            .then(fridgeEle => { 
                data.push(fridgeEle); 
            }).catch(err =>{ 
                res.status(404).send(err);
            });
        });
    }).then(() => { 
        console.log(data); 
        res.send(data);
    }).catch(err => { 
        res.status(404).send('UserProfile currently unavailable ' + err);
    });
}); 

//TODO: Adds a new fridge to user's fridge list 
fridge_router.post('/addFridge', (req, res) => {  

});

module.exports = fridge_router; 