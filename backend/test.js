
require("dotenv/config");
const {MongoClient} = require('mongodb');
var assert = require('assert');

//Connect to DB 
const uri = process.env.DB_CONNECTION; 
const client = new MongoClient(uri, { useUnifiedTopology: true }); 

describe ('DB_TEST', async function() {
  //Calls database 
  before(async function() {
    try{ 
    // Connect to the MongoDb cluster 
    await client.connect(); 
    db = await client.db('myFirstDatabase'); 
    this.test.parent.ctx.db = db
    } catch (e) {
      console.log(e);
    }
  });
  
  //COMMENT OUT TEST MODULES HERE
  importTest("User_routes", './test_dir/user_test');
  importTest("Fridge_routes", './test_dir/fridge_test');
  importTest("Food_routes", './test_dir/food_test');

  //Closes database
  after('Close', async function() {await client.close();})

})
  
//Handles importing test cases from other files
function importTest(name, path) { 
  return describe(name, function(){ 
      require(path)(this);
  })
}



