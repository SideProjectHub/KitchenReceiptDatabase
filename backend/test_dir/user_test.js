var common = require('./common');
var assert = require('assert');

module.exports = function suite() { 
  //Intialize testing environment
  before('ClearDatabase for testing', async function start() { 
      this.db.collection("users").drop(function(err, log){ 
        if (err) console.log("Error in dropping database");
        if (log) console.log("Intialized User Collection");
      });
  });

  describe("Testing POST_USER_API", function() { 
    it('Create Test User1', async function() { 
      axios = common.standardInstance();
      await axios.post('/routes/addUser', { 
        uid: 'user1', 
        displayName:  'test', //Display name doesn't need to be unique
        email: 'test1@test.com'
      });
      const query = await this.db.collection("users").findOne({uid: "user1"});
      assert.strictEqual(query.uid, 'user1')
    });

    it('Create Test User2', async function() { 
      axios = common.standardInstance();
      await axios.post('/routes/addUser', { 
        uid: 'user2', 
        displayName:  'test',   //Display name doesn't need to be unique
        email: 'test2@test.com'
      });
      const query = await this.db.collection("users").findOne({uid: "user2"});
      assert.strictEqual(query.uid, 'user2');
    }); 
  });

  describe("Testing GET_USER_API", function() { 
    it('Test GET for User1', async function() { 
      axios = common.standardInstance(); 
      var response = await axios.get('/routes/getProfile/user1', {}); 
      assert.strictEqual(response.data.fridgeTotal, 0);
      assert.strictEqual(response.status, 200); 
    }); 

    it('Test GET for User2', async function() { 
      axios = common.standardInstance(); 
      var response = await axios.get('/routes/getProfile/user2', {}); 
      assert.strictEqual(response.data.fridgeTotal, 0);
      assert.strictEqual(response.status, 200); 
    }); 
  });
}

