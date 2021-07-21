// Schema for user
const mongoose = require('mongoose'); 

const UserSchema = mongoose.Schema(
    {
    userName: {type: String, required: true, unique: true},
    fridge: {type: [], required: true} 
    },
    { collection: 'users'}
    );

module.exports = mongoose.model('UserSchema', UserSchema);