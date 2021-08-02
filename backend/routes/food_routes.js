const express = require('express'); 
const { Model } = require('mongoose');
const food_router = express.Router(); 
const Food = require('../schemas/foodSchema.js');

const Fridge = require('../schemas/fridgeSchema');

//Get the food page for the fridge
food_router.get('/getFood/:id', (req, res) => { 
    var id = req.params.id
    if (id == null || id == undefined){ 
        res.status(400).send('Missing Fridge ID')
        return; 
    }
    Fridge.findOne({id: id}, '-_id')
    .then(user => { 
        res.send(user);
    }).catch(err => {
        res.status(400).send('UserProfile currently unavailable ' + err);
    });
    
});


// TODO: Refractor for fridge
// Route for addition of food item to food items in database
food_router.post('/addfood', (req, res) => {
    console.log(req.body);
    const food = new Food.Model({
        quantity: req.body.quantity, 
        foodName: req.body.foodName,
        description: req.body.description,
        category: req.body.category
    });

    food.save()
    .then(data => {
        res.json(data);
    })
    .catch(err => {
        res.json({message:err});
    })
}) 


//TODO Delete food from the fridge  
//
food_router.delete('/deleteFood', (req, res) => {   
    //grab the user id  
    //sendin the food_id 
    //lookup the corresponding fridge 
    //inside that fridge I would delete a foodschema or an index of that fridge 
    console.log(req.body); 
    var foodId = req.body.foodId;  
    var fridgeId = req.body.fridgeId;  
    if(fridgeId == null || id == undefined) { 
        res.status(400).send('Missing Fridge ID'); 
        return; 
    }

    Fridge.findOne({id: id}, '-_id') 
    .then( deletingFridge => { 
        deletingFridge.foodList.findOne({_id: foodId})
        .then(foodDeleting => {
            if(foodDeleting == null || foodDeleting == undefined) { 
                res.status(400).send('food not present'); 
                return; 
            } 
            Model.deleteOne(foodDeleting); 
        }) 
        .catch(err => {res.json( {message: err}); 
        })
        
    })
    .catch(err => {res.json( {message: err})
})

})

module.exports = food_router; 

