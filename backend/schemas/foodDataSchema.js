const axios = require('axios');

//Hides private variables in .env file
require("dotenv").config({path: '../.env'});

const API_KEY = process.env.FOOD_API_KEY; 
const SITE = "https://api.nal.usda.gov/fdc/v1/"

//Food Category that corresponds to kitchen foodGroups
const fruits = [ 
    "Fruits and Fruit Juices"
]; 
const vegetables = [ 
    "Vegetables and Vegetable Products"
]; 
const meat = [ 
    "Poultry Products", "Sausages and Luncheon Meats", "Pork Products", "Beef Products", "Finfish and Shellfish Products", "Lamb, Veal, and Game Products"
]; 
const grains = [ 
    "Breakfast Cereals", "Nut and Seed Products", "Legumes and Legume Products", "Cereal Grains and Pasta"
]; 
const diary = [ 
    "Dairy and Egg Products"
]; 
// const other = [ 
//     "Spices and Herbs", "Baby Foods", "Fats and Oils", "Soups, Sauces, and Gravies", "Beverages", "Baked Products", 
//     "Sweets", "Fast Foods", "Meals, Entrees, and Side Dishes", "Snacks", "American Indian/Alaska Native Foods", 
//     "Restaurant Foods", "Branded Food Products Database", "Quality Control Materials", "Alcoholic Beverages"
// ];

/**
 * Food_Request validates and checks the food category of the requested food entry against 
 * Food Central's Database under the USDA. It will check foods typed as Foundation as SR Legacy, 
 * and will be further categorized to the groups listed above
 * @param {String} query 
 * @returns 
 *      null -> Request error -> Sends timeout message back to client 
 *      "None" -> Food is invalid 
 *      <FoodGoups> -> Food Group that will be used by client 
 */
const food_request = async (query) => {
    const response = await axios.post(SITE + "foods/search?api_key=" + API_KEY, { 
            "query": query,
            "dataType": [
                "Foundation",
                "SR Legacy"
            ],
            "pageSize": 25,
            "pageNumber": 1,
            "sortBy": "score",
            "sortOrder": "desc", 
            "requireAllWords": false
            }
        );

    //Throw error if response is not 200 
    if(response.status != 200){ 
        return null;
    } 

    //logic for looking up the category 
    let result = response.data; 
    
    //Return none if total hits is zero 
    if(result.totalHits = 0){ 
        return "None";
    } 

    //Logic for checking food category
    let foodCategory = result.foods[0].foodCategory; 
    if (fruits.includes(foodCategory))
        return "Fruits"; 
    else if (vegetables.includes(foodCategory))
        return "Vegetables"; 
    else if (diary.includes(foodCategory)) 
        return "Diary"; 
    else if (meat.includes(foodCategory)) 
        return "Meat"; 
    else if (grains.includes(foodCategory)) 
        return "Grains"; 
    else 
        return "Other"; 
}

exports.food_request = food_request;