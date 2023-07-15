const express = require('express');
const app = express();
const port = process.env.PORT || 8000;
const passport = require("passport");
const path = require("path");

const Register = require("./model/register");
const cors = require("cors");
const oneDay = 1000 * 60 * 60 * 24;
const session = require("express-session");
const cookieParser = require("cookie-parser");
const publicDirectoryPath = path.join(__dirname, "./public/");


const connectDB = require("./db/connect");
const notFoundMiddleware = require("./middleware/not-found");
const errorHandlerMiddleware = require("./middleware/error-handler");
const upload = require("./middleware/upload");
const tasks = require("./routes/tasks");
const flash = require("connect-flash");
// app.use(notFoundMiddleware);
app.use(errorHandlerMiddleware);
// app.use(passport.initialize());
// app.use(passport.authenticate("session"));

//Setup static directory to serve
app.use(express.static(publicDirectoryPath));
app.use(flash());

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use("/users", tasks);


app.post('/register', async(req, res) => {
      console.log(req.body.email);
      res.send("HEllo");
      const registerUser = await Register.create({email:req.body.email});
});
  

const start = async () => {
  try {
    await connectDB(
      "mongodb+srv://aspiring_minds:happy123@cluster0.sokemj9.mongodb.net/Aspiring-Minds?retryWrites=true&w=majority"
    );

    app.listen(port, function () {
      console.log(`Express server listening on port ${port} `);
    });

  } catch (error) {
    console.log(error);
  }
};

start();