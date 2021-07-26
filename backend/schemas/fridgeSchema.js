import {FoodSchema} from '../schemas/foodSchema';

//Schema for fridges 
const mongoose = require('mongoose'); 

const FridgeSchema = mongoose.Schema( 
    { 
        fridgeName: {type: String, required: true, uniquie: true}, 
        fridgeCount: {type: Number, default: 0}, 
        cardColor: String, 
        foodList: [{foodItem: {type: FoodSchema, default: []},}]
    }, 
    { collection: 'fridges'}
);

module.exports = mongoose.model('FridgeSchema', FridgeSchema);