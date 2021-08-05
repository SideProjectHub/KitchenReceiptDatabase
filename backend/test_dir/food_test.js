var common = require('./common');
var assert = require('assert');
const {
  default: axios
} = require('axios');

module.exports = function suite() {
  describe("Testing POST_FOOD_API", function() {
    //Create food1 and put it into User 1
    it('Create Food1 for User1\'s Fridge1', async function() {
      //Get the id for Fridge 1
      const user_query = await this.db.collection("users").findOne({
        uid: "user1"
      });
      const fridge_query = await this.db.collection("fridges").findOne({
        _id: user_query.fridgeList[0]
      })

      axios = common.standardInstance();
      await axios.post('/routes/addFood/' + fridge_query._id, {
        quantity: 1,
        foodName: "Apple",
        category: "fruits"
      });

      const result = await this.db.collection("fridges").findOne({
        _id: user_query.fridgeList[0]
      });
      assert.strictEqual(result.foodList[0].foodName, "Apple");
    });
    //Create food2 and put it into User1
    it('Create Food2 for User1\'s Fridge1', async function() {
      const user_query = await this.db.collection("users").findOne({
        uid: "user1"
      });
      const fridge_query = await this.db.collection("fridges").findOne({
        _id: user_query.fridgeList[0]
      })

      axios = common.standardInstance();
      await axios.post('/routes/addFood/' + fridge_query._id, {
        quantity: 2,
        foodName: "Oranges",
        category: "fruits",
        description: "A list of words"
      });

      const result = await this.db.collection("fridges").findOne({
        _id: user_query.fridgeList[0]
      });
      assert.strictEqual(result.foodList[0].foodName, "Apple");
      assert.strictEqual(result.foodList[1].foodName, "Oranges");
      assert.strictEqual(result.foodList[2].foodName, "Oranges");
    });
    //Check Foodcount for user 1
    it('Check Foodcount for user 1', async function() {
      const user_query = await this.db.collection("users").findOne({
        uid: "user1"
      });
      assert.strictEqual(user_query.foodTotal, 3);
    });
    //Check FridgeCount for User's Fridge1
    it('Check FridgeCount for User\'s Fridge1', async function() {
      const user_query = await this.db.collection("users").findOne({
        uid: "user1"
      });
      const fridge_query = await this.db.collection("fridges").findOne({
        _id: user_query.fridgeList[0]
      });
      assert.strictEqual(fridge_query.fridgeCount, 3);
    });
    //Create food and put it in user 2
    it('Create Food1 for User2\'s Fridge1', async function() {
      //Get the id for Fridge 1
      const user_query = await this.db.collection("users").findOne({
        uid: "user2"
      });
      const fridge_query = await this.db.collection("fridges").findOne({
        _id: user_query.fridgeList[0]
      })

      axios = common.standardInstance();
      await axios.post('/routes/addFood/' + fridge_query._id, {
        quantity: 1,
        foodName: "Apple",
        category: "fruits"
      });

      const result = await this.db.collection("fridges").findOne({
        _id: user_query.fridgeList[0]
      });
      assert.strictEqual(result.foodList[0].foodName, "Apple");
    });
  });
  describe("Testing GET_FOOD_API", function() {
    //Get foodlist for user1
    it('Test GET for User1\'s Fridge1 foodList', async function() { 
      const user_query = await this.db.collection("users").findOne({
        uid: "user1"
      });
      const fridge_query = await this.db.collection("fridges").findOne({
        _id: user_query.fridgeList[0]
      }); 

      axios = common.standardInstance(); 
      var response = await axios.get('/routes/getFood/' + fridge_query._id, {}); 
      assert.strictEqual(response.data[0].foodName, 'Apples');
      assert.strictEqual(response.data[1].foodName, 'Oranges');
      assert.strictEqual(response.status, 200); 
    }); 
  });

  describe("Testing DEL_FOOD_API", function() {
    //Delete food1 from user1
    it('Test DEL for User1\'s Fridge1 foodList', async function() { 
      const user_query = await this.db.collection("users").findOne({
        uid: "user1"
      });
      const fridge_query = await this.db.collection("fridges").findOne({
        _id: user_query.fridgeList[0]
      }); 

      axios = common.standardInstance(); 
      var response = await axios.get('/routes/deleteFood/' + fridge_query._id, {
        foodID: fridge_query.foodList[0]._id
      }); 

      const result = await this.db.collection("fridges").findOne({
        _id: user_query.fridgeList[0]
      }); 
      assert.strictEqual(result.foodList[0].foodName, "Orange")
      assert.strictEqual(response.status, 200); 
    
    }); 
    //Check Food totals for User's Fridge1
    it('Check FridgeCount for User\'s Fridge1', async function() {
      const user_query = await this.db.collection("users").findOne({
        uid: "user1"
      });
      const fridge_query = await this.db.collection("fridges").findOne({
        _id: user_query.fridgeList[0]
      });
      assert.strictEqual(fridge_query.fridgeCount, 2);
      assert.strictEqual(user_query.foodTotal, 2);
      assert.strictEqual(user_query.eatenTotal, 1);
    });
  });
}