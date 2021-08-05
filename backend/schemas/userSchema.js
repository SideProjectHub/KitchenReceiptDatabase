// Schema for user
const mongoose = require('mongoose'); 

const UserSchema = mongoose.Schema(
    {
    uid: {type: String, required: true, unique: true}, 
    email:{type: String, required: true, unique: true}, 
    displayName:{type: String, required: true, unique: true},
    fridgeList: [{type: String, unique: false}],  
    fridgeTotal: {type: Number, default: 0},
    foodTotal: {type: Number, default: 0},
    eatenTotal: {type: Number, default: 0}
    },
    { collection: 'users'}
);

module.exports = mongoose.model('UserSchema', UserSchema);