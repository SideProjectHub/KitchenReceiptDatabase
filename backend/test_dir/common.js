const axios = require('axios').default

var host = 'http://localhost:4000'; 

exports.host = host; 
exports.standardInstance = () => { 
    try{ 
        return axios.create({ 
            baseURL: host, 
            timeout: 10000, 
            headers: { 
                'Content-Type': 'application/json', 
                'Accept': 'application/json'
            }});
    } catch (err){ 
        console.log(err);
        return null 
    }
}