const express = require('express');
const app = express();
const port = 8080; // Replace with your desired port number



app.get('/endpoint', (req, res) => {
    // Handle the incoming request
    // Perform any necessary operations
    // Prepare the response data
    const responseData = { message: 'Hello from back end' };
    console.log("Pressed");
    // Send the response
    res.json(responseData);
  });

const start = async () => {
    try {
      app.listen(port, function(){
        console.log(`Express server listening on port ${port} `);
      });
    } catch (error) {
      console.log(error);
    }
  };
  
  start();