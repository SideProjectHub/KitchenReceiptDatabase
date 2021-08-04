
# How Testing Works
--- 

In order to create test modules you must export mocha test interfaces wrapped in a `suite()` function. This will allow `test.js` to pass intialized *initialized db connection* into the context of the new module. After that simply state your test cases within the `suite()`:

```javascript
    module.exports = function suite() { 
        ...
    }
```
In the `test.js` folder simply add in the test cases in the `main()` function as follows: 

```javascript
  importTest("Fridge_routes", './test_dir/fridge_test');
  importTest("Food_routes", './test_dir/food_test');
  //importTest(MODULE DESCRIPTION, PATH); 
  ...
```

### Folders 
--- 
- **common.js** -- Global Variables shared between all modules 
- **user_test** -- Testing *GET, POST, DELETE* API calls to User Schema
- **fridge_test** -- Testing *GET, POST, DELETE* API calls to Fridge Schema
- **food_test** -- Testing *GET, POST, DELETE* API calls to Food Schema