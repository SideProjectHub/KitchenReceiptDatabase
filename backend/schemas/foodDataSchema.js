
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
const other = [ 
    "Spices and Herbs", "Baby Foods", "Fats and Oils", "Soups, Sauces, and Gravies", "Beverages", "Baked Products", 
    "Sweets", "Fast Foods", "Meals, Entrees, and Side Dishes", "Snacks", "American Indian/Alaska Native Foods", 
    "Restaurant Foods", "Branded Food Products Database", "Quality Control Materials", "Alcoholic Beverages"
];

//Create template for API call 
const food_request = async (query) => {
    const response = await fetch(SITE + "foods/search?api_key=" + API_KEY, {
        method: 'POST', 
        body: {
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
            },
        headers: { 
            'Content-Type': 'application/json',
        }
    });

    //Throw error if response is not 200 
    if(!response.ok){ 
        return null;
    } 

    //logic for looking up the category 
    let result = response.json(); 
    
    //Return none if total hits is zero 
    if(result.totalHits = 0){ 
        return "None";
    } 

    return result.foods[0].foodCategory; 
}

//Create logic for sending the category back 