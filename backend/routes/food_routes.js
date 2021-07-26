const express = require('express'); 
const food_router = express.Router(); 
const Food = require('../schemas/foodSchema');

// Route for addition of food item to food items in database
food_router.post('/addfood', (req, res) => {
    console.log(req.body);
    const food = new Food({
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

module.exports = food_router; 