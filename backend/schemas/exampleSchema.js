//Current files shows example of schema checking using mongoose
const mongoose = require('mongoose'); 

const PostSchema = mongoose.Schema({
    title: {
        //Input validation
        type: String, 
        required: true
    }, 
    description: String, 
    date: Date, 
}); 

module.exports = mongoose.model('exampleSchema');

