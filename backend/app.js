
//Express is a framework that simplifies core features of a server
const express = require('express');
const app = express(); 
const mongoose = require('mongoose');
require("dotenv/config")

//Port Number
app.listen(3000); 

//Reference specific route
const exampleRoute = require('./routes/exampleRoute'); 

//Example of running middleware on routes
app.use('/', exampleRoute);

//Connect to DB 
mongoose.connect(process.env.DB_CONNECTION, {useNewUrlParser}, 
     () => console.log('Connected to DB!')
);

