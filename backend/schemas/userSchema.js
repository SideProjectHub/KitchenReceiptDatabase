// Schema for user
const mongoose = require('mongoose'); 

const UserSchema = mongoose.Schema(
    {
    uid: {type: String, required: true, unique: true}, 
    email:{type: String, required: true, unique: true}, 
    displayName:{type: String, required: true, unique: false},
    fridgeList: [{fridge: {type: mongoose.Schema.Types.ObjectId, unique: true}}] 

    },
    { collection: 'users'}
);

module.exports = mongoose.model('UserSchema', UserSchema);