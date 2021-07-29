// Schema for user
const mongoose = require('mongoose'); 

const UserSchema = mongoose.Schema(
    {
    uid: {type: String, required: true, unique: false}, 
    email:{type: String, required: true, unique: false}, 
    displayName:{type: String, required: true, unique: false},
    fridgeList: [{fridge: {type: mongoose.Schema.Types.ObjectId, unique: false}}],  
    fridgeTotal: {type: Number, default: 0},
    foodTotal: {type: Number, default: 0},
    eatenTotal: {type: Number, default: 0}
    },
    { collection: 'users'}
);

module.exports = mongoose.model('UserSchema', UserSchema);