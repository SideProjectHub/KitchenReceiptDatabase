const express = require('express'); 
const fridge_router = express.Router(); 
const Fridge = require('../schemas/fridgeSchema'); 
const User = require('../schemas/userSchema'); 

//Get the basic information of all fridges user has 
fridge_router.get('/GetFridge/:uid', (req, res) => { 
    var uid = req.params.uid
    if (uid == null || uid == undefined){ 
        res.status(400).send('Missing User UID')
        return; 
    }

    //Intialize json list to hold fridge
    User.findOne({uid: uid}, '-_id fridge')
    .then(user => { 
        let data = []; 
        user.fridge.foreach(ele => { 
            try {
                let fridgeEle = await Fridge.findOne({_id: ele._id}, '-foodList').exec();
                data.push(fridgeEle); 
            } catch{ 
                res.status(404).send('Server Parse error (FridgeList)');
            }; 
        });
        console.log(data); 
        res.send(data);
    }).catch(err => { 
        res.status(404).send('UserProfile currently unavailable ' + err);
    });
}); 

//TODO: Adds a new fridge to user's fridge list 
fridge_router.post('/Add Fridge', (req, res) => { 

});

module.exports = fridge_router; 