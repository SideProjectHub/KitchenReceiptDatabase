const Food = require("./foodSchema");

//Schema for fridges 
const mongoose = require('mongoose'); 

const FridgeSchema = mongoose.Schema( 
    { 
        fridgeName: {type: String, required: true, unique: true}, 
        fridgeCount: {type: Number, default: 0}, 
        cardColor: String, 
        foodList: [{foodItem: {type: Food.Schema, default: []},}]
    }, 
    { collection: 'fridges'}
);

module.exports = mongoose.model('FridgeSchema', FridgeSchema);