const express = require('express'); 
const router = express.Router(); 
const User = require('../schemas/userSchema');
const Food = require('../schemas/foodSchema');

// Route for addition of food item to food items in database
router.post('/addfood', (req, res) => {
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

module.exports = router; 