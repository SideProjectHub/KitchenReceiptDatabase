var common = require('./common');
var assert = require('assert');
var ObjectID = require('mongodb').ObjectID;


module.exports = function suite() { 
  //Intialize testing environment
  before('ClearDatabase for testing', async function start() { 
    this.db.collection("fridges").drop(function(err, log){ 
      if (err) console.log("Error in dropping database");
      if (log) console.log("Intialized Fridge Collection");
    });
  });

  describe("Testing POST_FRIDGE_API", function() { 
    it('Create Fridge1 for User1', async function() { 
        axios = common.standardInstance();
        var response = await axios.post('/routes/addFridge/user1', { 
          fridgeName: "Fridge1", 
          cardColor: "Red"
        });
        const user_query = await this.db.collection("users").findOne({uid: "user1"});
        const fridge_query = await this.db.collection("fridges").findOne({_id: new ObjectID(user_query.fridgeList[0])})
        assert.strictEqual(fridge_query.fridgeName, 'Fridge1'); 
    });

    it('Create Fridge2 for User1', async function() { 
        axios = common.standardInstance();
        await axios.post('/routes/addFridge/user1', { 
          fridgeName: "Fridge2", 
          cardColor: "Red"        
        });
        const user_query = await this.db.collection("users").findOne({uid: "user1"});
        const fridge_query = await this.db.collection("fridges").findOne({_id: new ObjectID(user_query.fridgeList[1])}); 
        assert.strictEqual(fridge_query.fridgeName, 'Fridge2'); 
    });
    
    it('Test the Fridge count for User1', async function() { 
        const user_query = await this.db.collection("users").findOne({uid: "user1"});
        assert.strictEqual(user_query.fridgeTotal, 2); 
    });
    
    it('Create Fridge1 for User2', async function() { 
        axios = common.standardInstance();
        await axios.post('/routes/addFridge/user2', { 
          fridgeName: "Fridge1", //Fridges can have same name  and color
          cardColor: "Red"
        });
        const user_query = await this.db.collection("users").findOne({uid: "user2"});
        const fridge_query = await this.db.collection("fridges").findOne({_id: new ObjectID(user_query.fridgeList[0])});
        assert.strictEqual(fridge_query.fridgeName, 'Fridge1'); 
    });
  });

  describe("Testing GET_FRIDGE_API", function() { 
    it('Test GET for User1 fridgeList', async function() { 
        axios = common.standardInstance(); 
        var response = await axios.get('/routes/getFridge/user1', {}); 
        assert.strictEqual(response.data[0].fridgeName, 'Fridge1');
        assert.strictEqual(response.data[1].fridgeName, 'Fridge2');
        assert.strictEqual(response.status, 200); 
      }); 

      it('Test GET for User2 fridgeList', async function() { 
        axios = common.standardInstance(); 
        var response = await axios.get('/routes/getFridge/user1', {}); 
        assert.strictEqual(response.data[0].fridgeName, 'Fridge1');
        assert.strictEqual(response.status, 200); 
      }); 
  });
}

