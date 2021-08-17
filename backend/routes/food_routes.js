const express = require('express'); 
const food_router = express.Router(); 
const Food = require('../schemas/foodSchema.js');
const Fridge = require('../schemas/fridgeSchema');
const User = require('../schemas/userSchema')

//Get the food page for the fridge
food_router.get('/getFood/:id', (req, res) => { 
    let id = req.params.id
    if (id == null || id == undefined){ 
        res.status(400).send('Missing Fridge ID')
        return; 
    }
    Fridge.findOne({_id: id})
    .then(user => {
        res.send(user.foodList);
    }).catch(err => {
        res.status(400).send('UserProfile currently unavailable ' + err);
    });
    
});


// Route for addition of food item to food items in database
food_router.post('/addfood/:fridgeID', async function(req, res) {
    console.log(req.body);
    let fridgeID = req.params.fridgeID 
    let food = new Food.Model({    
        quantity: req.body.quantity, 
        foodName: req.body.foodName,
        description: req.body.description,
        category: req.body.category
    });  

    // MUST DO:
        // Loop through fridge's users and increment their foodCount by 1 (Added to Code)
        // Add food to fridge's food list (Done, BUT some questions about the way we are storing it)
    try{
        //Updates fridge Count
        let data = await Fridge.updateOne(
            {
                _id: fridgeID
            }, 
            {
                $push: { foodList: food },
                $inc: { fridgeCount: req.body.quantity },
            }, 
        );
        //Updates user food Count
        let query = await Fridge.findOne({_id: fridgeID}, 'userList -_id')
        await User.updateMany( 
            {
                uid:  { $in: query.userList }
            },
            {
                $inc: { foodTotal: req.body.quantity }
            }
         )

        res.json({data : data, foodId : food._id});    
    } catch (err) {
        res.json({message:err});
    };
}) 

//Route which processes foods from receipt,
//Validates food items, and stores in database 
food_router.post('/addReceipt/:fridgeID', async function(req, res) { 
    //TODO Parse text from receipt 
    //TODO Clean data for relevant text 
    //TODO Validate items 
    //TODO Store in Database
});


//Delete food from the fridge  
food_router.delete('/deleteFood/:fridgeID/:foodId', async function(req, res) {   

    let foodId = req.params.foodId.toString();  
    let fridgeId = req.params.fridgeID;  
    console.log(foodId);
    console.log(fridgeId);
    if(fridgeId == null || fridgeId == undefined) { 
        res.status(400).send('Missing Fridge ID'); 
        return; 
    }
    try {
        let query = await Fridge.findOne({_id: fridgeId});
        await Fridge.updateOne(
            {
                _id: fridgeId
            }, 
            {
                $pull: {foodList: {_id: foodId}}, 
                $inc: {fridgeCount: -1}
            });
        await User.updateMany( 
            {
                uid:  { $in: query.userList }
            },
            {
                $inc: { foodTotal: -1, eatenTotal: 1 }
            }
        );
        res.status(200).json({message: "success"});
    } catch (err) { 
        res.json({message: err})
    }
})

module.exports = food_router; 

