const express = require('express'); 
const user_router = express.Router(); 
const User = require('../schemas/userSchema');


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