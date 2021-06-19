# Backend Controller 

In order to start server download NodeJS along with it's package manager on the following sites: 
- [NodeJS](https://nodejs.org/en/): Server Manager using Javascript
- [NPM](https://www.npmjs.com/): Node package manager. 

### Initialzing and starting server
In order to start the server run the following commands: 

`npm install`- Installs server dependencies listed in *package.json*. In the event that new dependencies are listed, please also run this command. 

`npm run start` - Starts the server with the listed `address:port` in *app.js*. 

### File Structure 

The NodeJS server depends on the *.env* file listed in root folder to take in database connection address and any other private forms of data. 

The *routes* folder also allows routes to be created in a modular fashion, and uses ExpressJS's Router library in order to connect them to *app.js*