//Schema for food
const mongoose = require('mongoose'); 

const FoodSchema = mongoose.Schema(
    {
    quantity: {type: Number, required: true},
    foodName: {type: String, required: true, unique: true},
    description: {type: String},
    category: {type: String, required: true}
    },

    { collection: 'food'} 
    );

module.exports = mongoose.model('FoodSchema', FoodSchema);