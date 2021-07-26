const express = require('express'); 
const user_router = express.Router(); 
const User = require('../schemas/userSchema');

//Gets User profile with UID needed as parameter
user_router.get('/getProfile/:uid', (req, res) => { 
    var uid = req.params.uid;  
    if (uid == null || uid == undefined){ 
        res.status(400).send('Missing User UID')
        return; 
    }

    User.find({uid: uid}, '-_id fridgeTotal foodTotal eatenTotal')
    .then(user => { 
        res.send(user[0]); 
    }).catch(err => {
        res.status(400).send('UserProfile currently unavailable ' + err);
    });
});

//Adds new User with Firebase credentials. 
user_router.post('/addUser', (req, res) => { 
    console.log(req.body); 
    const user = new User({ 
        uid: req.body.uid, 
        displayName:  req.body.displayName, 
        email: req.body.email, 
        fridge: [] 
    }); 
    user.save()
    .then(data => { 
        res.json(data); 
    }) 
    .catch(err => { 
        res.json({message:err}); 
    })
})

module.exports = user_router;