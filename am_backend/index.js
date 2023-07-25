const express = require("express");
const app = express();
const port = process.env.PORT || 8000;
const passport = require("passport");
const path = require("path");
const socketIO = require("socket.io");

const Register = require("./model/register");
const Login = require("./model/login");
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
const courseRoutes = require("./routes/courseRoutes");
const flash = require("connect-flash");
const { log } = require("console");

const http = require('http');
const server = http.createServer(app);
const io = socketIO(server);

const messageRoutes = require("./routes/messageRoutes");

// app.use(notFoundMiddleware);
app.use(errorHandlerMiddleware);
// app.use(passport.initialize());
// app.use(passport.authenticate("session"));
app.use(
  session({
    secret: "keythatwillsignedthecookie",
    saveUninitialized: true,
    resave: false, // RESAVE Means for every request to the server we need new cookie
    cookie: { maxAge: oneDay },
  })
);
app.use(passport.initialize());
app.use(passport.authenticate("session"));

//Setup static directory to serve
app.use(express.static(publicDirectoryPath));
app.use(flash());

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use("/users", tasks);
app.use("/courses", courseRoutes);
app.use("/msg", messageRoutes);


app.get("/get", async (req, res) => {
  res.send("HEllo");
});

app.post("/register", async (req, res) => {
  console.log(req.body.email);
  res.send("HEllo");
  const registerUser = await Register.create({ email: req.body.email });
});

app.post("/login", async (req, res) => {
  console.log(req.body.email);
  console.log(req.body.password);
  res.send(req.body.email + req.body.password);
});

app.post("/getUserDetails", async (req, res) => {
  console.log(req.body.email);
  console.log(req.body.password);

  // const registerUser = await Register.create({email:req.body.email});
});

app.post("/registerNewUser", async (req, res) => {
  const firstname = req.body.firstname;
  const lastname = req.body.lastname;
  const email = req.body.email;
  const tasks = await Register.findOne({ email: email });

  if (!tasks) {
    req.body.password = await bcrypt.hash(req.body.password, 12);
    const registerUser = await Register.create(req.body);

    req.session.userId = registerUser["_id"];
    req.session.email = req.body.email;
    req.session.pname = req.body.pname;

    console.log(req.session);

    // res.render("home-2",{records:provider,bills:files,ques:ques});
  } else {
    req.flash("message", "This email address is already registered with us");
    res.redirect("/register");
  }
});

const start = async () => {
  try {
    await connectDB(
      "mongodb+srv://goral_patel_1508:goral123@cluster0.sokemj9.mongodb.net/Aspiring-Minds?retryWrites=true&w=majority"
    );

    server.listen(port, function () {
      console.log(`Express server listening on port ${port} `);
    });


    io.on('connection', (socket) => {
      console.log('A user connected.');
    
      // Socket.IO message event handling
      socket.on('message', (data) => {
        console.log(`Received message: ${data.message} from ${data.user}`);
    
        // Broadcast the message to all connected clients (including the sender)
        io.emit('message', data);
      });
    
      // Handle disconnection
      socket.on('disconnect', () => {
        console.log('A user disconnected.');
      });
    });

    
  } catch (error) {
    console.log(error);
  }
};

start();
