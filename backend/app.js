//Express is a framework that simplifies core features of a server
const express = require('express');
const mongoose = require('mongoose');
const cors = require("cors");

//Hides private variables in .env file
require("dotenv/config");

const app = express(); 

//Port Number
app.listen(4000, function (){
     console.log("Connected Backend Server to Port 4000");
}); 

//Reference specific route
const food_routes = require('./routes/food_routes'); 
const user_routes = require('./routes/user_routes'); 
const fridge_router = require('./routes/fridge_routes');

// Require cors
app.use(cors());

//Middleware that parses req.body and turns it into json form
app.use(express.json());

//Example of running middleware on routes
app.use('/routes', [food_routes, user_routes, fridge_router]);

app.get('/' , (req,res) => {
     res.send('Welcome to our app')
}); 

//Connect to DB 
mongoose.connect(process.env.DB_CONNECTION, 
     { useNewUrlParser: true, useUnifiedTopology: true },
     () => console.log('Connected to DataBase!')
);