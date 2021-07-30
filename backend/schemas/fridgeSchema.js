const Food = require("./foodSchema");

//Schema for fridges 
const mongoose = require('mongoose'); 

const FridgeSchema = mongoose.Schema( 
    { 
        fridgeName: {type: String, required: true}, 
        fridgeCount: {type: Number, default: 0}, 
        cardColor: String, 
        foodList: [{type: Food.Schema, default: [], sparse:true}]
    }, 
    { collection: 'fridges'}
);

module.exports = mongoose.model('FridgeSchema', FridgeSchema);