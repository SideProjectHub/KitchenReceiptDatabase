const express = require('express'); 
const mongoose = require('mongoose');
const fridge_router = express.Router(); 
const Fridge = require('../schemas/fridgeSchema'); 
const User = require('../schemas/userSchema'); 

//Get the basic information of all fridges user has 
fridge_router.get('/getFridge/:uid', async function(req, res) { 
    let uid = req.params.uid
    if (uid == null || uid == undefined){ 
        res.status(400).send('Missing User UID')
        return; 
    }

    //Intialize json list to hold fridge
    User.findOne({uid: uid}, '-_id fridgeList')
    .then(async function(user){ 
        try{
            console.log(user.fridgeList);
            let data = await Fridge.find({_id : {$in: user.fridgeList}}, '-foodList');
            console.log(data);
            res.send(data);
        } catch{ 
            res.status(404).send('Cant get data');
        };
    }).catch(err => { 
        res.status(404).send('UserProfile currently unavailable ' + err);
    });
}); 

//TODO: Adds a new fridge to user's fridge list 
fridge_router.post('/addfridge/:uid', async function(req, res) {  
    console.log(req.body);

    let uid = req.params.uid
    if (uid == null || uid == undefined){ 
        res.status(400).send('Missing User UID')
        return; 
    }

    let fridge = new Fridge({
        fridgeName: req.body.fridgeName, 
        cardColor: req.body.color,
        userList: [uid],
    });

    try{ 
        let data = await fridge.save()
        console.log(data._id.toString());
        await User.updateOne(
            {
                uid: uid
            }, 
            {
                $push: { fridgeList: data._id.toString() },
                $inc: { fridgeTotal: 1 },
            }, 
        )
        res.json(data);
    } catch(err) { 
        res.json({message:err});
    }
});

module.exports = fridge_router;