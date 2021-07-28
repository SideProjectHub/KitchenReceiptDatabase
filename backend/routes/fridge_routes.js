const express = require('express'); 
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
        var data = [];
        console.log(user.fridgeList);
        Object.entries(user.fridgeList).forEach(async function(ele) { 
            console.log(ele[1]);
            await Fridge.findOne({_id: ele[1]}, '-foodList')
            .then(fridgeEle => { 
                console.log(fridgeEle);
                data.push(fridgeEle); 
            }).catch(() =>{ 
                res.status(404);
            });
            return data;
        }).then(data => { 
            console.log(data); 
            res.send(data);
        });
    }).catch(err => { 
        res.status(404).send('UserProfile currently unavailable ' + err);
    });
}); 

//TODO: Adds a new fridge to user's fridge list 
fridge_router.post('/addFridge', (req, res) => {  

});

module.exports = fridge_router; 