
//Express is a framework that simplifies core features of a server
const express = require('express');
const app = express(); 
const mongoose = require('mongoose');
const bodyparser = require('body-parser'); 
const cors = require("cors");

require("dotenv/config");

//Port Number
app.listen(5000, function (){
     console.log("Did it");
}); 

//Reference specific route
const routes = require('./routes/routes'); 
const bodyParser = require('body-parser');

// Require cors
app.use(cors());

//Middleware that parses req.body and turns it into json form
app.use(bodyParser.json());

//Example of running middleware on routes
app.use('/routes', routes);

app.get('/' , (req,res) => {
     res.send('Welcome to our app')
}); 

//Connect to DB 
mongoose.connect(process.env.DB_CONNECTION, 
     { useNewUrlParser: true },
     () => console.log('Connected to DataBase!')
);