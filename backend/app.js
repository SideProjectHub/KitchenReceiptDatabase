
//Express is a framework that simplifies core features of a server
const express = require('express');
const app = express(); 
const mongoose = require('mongoose');
const bodyparser = require('body-parser'); 
require("dotenv/config")

//Port Number
app.listen(3000); 

//Reference specific route
const exampleRoute = require('./routes/exampleRoute'); 
const bodyParser = require('body-parser');

//Example of running middleware on routes
app.use('/', exampleRoute);

//Middleware that parses req.body and turns it into json form
app.use(bodyParser.json());

//Connect to DB 
mongoose.connect(process.env.DB_CONNECTION, {useNewUrlParser}, 
     () => console.log('Connected to DB!')
);

