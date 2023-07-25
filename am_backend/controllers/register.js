const Register = require("../model/register");
const asyncWrapper = require("../middleware/asyncWrapper");
const bcrypt = require("bcryptjs");
const Otp = require("../model/otp");
require("dotenv").config();
const { google } = require("googleapis");
var nodemailer = require("nodemailer");

const CLIENT_ID = process.env.CLIENT_ID;
const CLIENT_SECRET = process.env.CLIENT_SECRET;
const REDIRECT_URI = process.env.REDIRECT_URI;
const REFRESH_TOKEN = process.env.REFRESH_TOKEN;

const oAuth2Client = new google.auth.OAuth2(
  CLIENT_ID,
  CLIENT_SECRET,
  REDIRECT_URI
);
oAuth2Client.setCredentials({ refresh_token: REFRESH_TOKEN });

const createUser = asyncWrapper(async (req, res) => {
  const firstname = req.body.firstname;
  const lastname = req.body.lastname;
  const email = req.body.email;
  const tasks = await Register.findOne({ email: email });
  if (!tasks) {
    req.body.password = await bcrypt.hash(req.body.password, 12);
    const registerUser = await Register.create(req.body);
    // console.log(registerUser['_id']);
    // req.session.userId = registerUser['_id'];
    // req.session.email = req.body.email;
    // req.session.pname = req.body.pname;
    console.log(registerUser);
    // console.log(req.session);
    res.json(registerUser);
    // res.render("home-2",{records:provider,bills:files,ques:ques});
  } else {
    res.send(404);
    // res.redirect('/register');
  }
});

const getUser = asyncWrapper(async (req, res) => {
  const email = req.body.email;
  const password = req.body.password;
  console.log(email);
  console.log(password);
  const tasks = await Register.findOne({ email }).then((user) => {
    if (!user) {
      res.status(404).json("User Not Found");
    }
    bcrypt.compare(password, user?.password, async (err, data) => {
      //if error than throw error
      if (err) {
        res.send(402);
      }

      //if both match than you can do anything
      if (data) {
        res.json(user);
      } else {
        return res.status(401).json({ msgs: "Invalid Credentials" });
      }
    });
  });
});

const searchUsers = asyncWrapper((req, res) => {
  const searchQuery = req.query.q; // The search query parameter from the request query
  const currentUser = req.body.userId;
  console.log("currentUser", currentUser);
  // Using regular expression to perform a case-insensitive search on both firstname and lastname
  Register.find({
    $or: [
      { firstname: { $regex: searchQuery, $options: "i" } },
      { lastname: { $regex: searchQuery, $options: "i" } },
    ],
  })
    .then((users) => {
      const filteredUsers = users
        .map((user) => user.toObject({ getters: true }))
        .filter((user) => user.id !== currentUser);
      res.status(200).json(filteredUsers);
    })
    .catch((error) => {
      res.status(500).json({ error: "Failed to fetch users" });
    });
});

const emailSend = asyncWrapper(async (req, res) => {
  const data = await Register.findOne({ email: req.body.email });
  const response = {};

  if (data) {
    let otpCode = Math.floor(100000 + Math.random() * 900000);
    let otpData = new Otp({
      email: req.body.email,
      code: otpCode,
      expireIn: new Date().getTime() + 1000 * 180,
    });
    let otpResponse = await otpData.save();
    console.log(otpCode);
    const data = sendMail(req.body.email, otpCode);
    req.session.updateEmailPassword = req.body.email;
    if (data) {
      res.json("Success");
    } else {
      return res.status(401).json({ msg: "Email Not send" });
    }
  } else {
    req.flash("emailNotFound", "Email Incorrect or Not Registered with us");
    res.redirect("/reset-password");
    // res.json({status:fail})
    // res.status(401).json('Email not sent');
  }
});

async function sendMail(email, Otp) {
  try {
    const accessToken = await oAuth2Client.getAccessToken();

    let transport = nodemailer.createTransport({
      service: "gmail",
      port: 465,
      secure: true, // true for 465, false for other ports
      logger: true,
      debug: true,
      secureConnection: true,
      ignoreTLS: true, // add this
      auth: {
        type: "OAuth2",
        user: "testinghappy.18@gmail.com",
        clientId: CLIENT_ID,
        clientSecret: CLIENT_SECRET,
        accessToken: accessToken,
        refreshToken: REFRESH_TOKEN,
      },
    });

    const mailOptions = {
      from: "Aspiring-Minds <testinghappy.18@gmail.com>", // Cer address
      to: email, // List of recipients
      subject: "OTP to reset Password", // Subject line
      text: "Hello from Aspiring Minds!", // Plain text body
      html:
        "<h1>Hey !! </h1>" +
        Otp +
        "<h1>  is  the otp to reset your password</h1>",
    };

    const result = await transport.sendMail(mailOptions);
    return result;
  } catch (err) {
    console.log(err);
    return err;
  }
}

const changePassword = asyncWrapper(async (req, res) => {
  let data = await Otp.findOne({
    email: req.body.email,
    code: req.body.otpCode,
  });
  console.log(data);
  if (data) {
    let currentTime = new Date().getTime();
    let diffTime = data.expireIn - currentTime;
    if (diffTime < 0) {
      req.flash("expired", "OTP you entered Expired");
      return res.status(401).json({ msg: "OTP you entered expired !" });
    } else {
      res.json("Success");
    }
  } else {
    return res.status(402).json({ msg: "Invalid OTP Entered !" });
  }
});

const updatePasswordGoogle = asyncWrapper(async (req, res) => {
  let user = await Register.findOne({ email: req.body.email });
  user.password = await bcrypt.hash(req.body.password, 12);
  user.save();
  res.json("Success");
});

const purchasedCourse = asyncWrapper(async (req, res) => {
  const userId = req.params.userId;
  const courseId = req.body.courseId;

  Register.findById(userId)
    .then((user) => {
      if (!user) {
        return res.status(404).json({ error: "User not found" });
      }

      user.purchasedCourses.push(courseId);

      user
        .save()
        .then((savedUser) => {
          res.status(200).json(savedUser);
        })
        .catch((error) => {
          res.status(500).json({ error: "Failed to purchase course" });
        });
    })
    .catch((error) => {
      res.status(500).json({ error: "Failed to find user" });
    });
});

const purchasedModule = asyncWrapper(async (req, res) => {
  const userId = req.params.userId;
  const moduleId = req.body.moduleId;
  console.log("requested");

  Register.findById(userId)
    .then((user) => {
      if (!user) {
        return res.status(404).json({ error: "User not found" });
      }

      user.purchasedModules.push(moduleId);

      user
        .save()
        .then((savedUser) => {
          res.status(200).json(savedUser);
        })
        .catch((error) => {
          res.status(500).json({ error: "Failed to purchase module" });
        });
    })
    .catch((error) => {
      res.status(500).json({ error: "Failed to find user" });
    });
});

const sendFriendRequest = asyncWrapper(async (req, res) => {
  const { senderUserId, receiverUserId } = req.body;
  console.log(senderUserId, receiverUserId);

  try {
    // Find the sender and receiver users by their IDs
    const senderUser = await Register.findById(senderUserId);
    const receiverUser = await Register.findById(receiverUserId);

    if (!senderUser || !receiverUser) {
      return res.status(404).json({ message: "User not found" });
    }

    console.log(senderUser, receiverUser);
    // Check if the friend request has already been sent
    const isFriendRequestSent = senderUser.connections.some(
      (connection) => connection.user.toString() === receiverUserId
    );

    if (isFriendRequestSent) {
      return res.status(400).json({ message: "Friend request already sent" });
    }
    console.log(isFriendRequestSent);

    // Add the receiver's user ID to the sender's connections array with status "pending"
    senderUser.connections.push({
      user: receiverUserId,
      status: "pending",
      isSent: true,
    });
    await senderUser.save();

    receiverUser.connections.push({
      user: senderUserId,
      status: "pending",
      isSent: false,
    });
    await receiverUser.save();
    console.log(
      "senderUser.connections",
      senderUser.connections,
      "receiverUser.connections",
      receiverUser.connections
    );

    res.status(200).json({ message: "Friend request sent successfully" });
  } catch (error) {
    console.error("Error sending friend request:", error);
    res.status(500).json({ message: "Server error" });
  }
});

const acceptFriendRequest = asyncWrapper(async (req, res) => {
  try {
    const userId = req.body.userId;
    const requestId = req.body.requestId; // The ID of the connection request to accept
    const status = req.body.status; // The ID of the connection request to accept
    console.log(userId, requestId, status);
    // Find the user by their ID
    const user = await Register.findById(userId);

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    // Find the connection request in the user's connections array
    const connectionRequest = user.connections.find(
      (connection) => connection._id.toString() === requestId
    );
    console.log(connectionRequest);

    if (!connectionRequest) {
      return res.status(404).json({ message: "Connection request not found" });
    }

    // Update the status of the connection request to "accepted"
    connectionRequest.status = status;
    console.log(connectionRequest);
    await user.save();
    // if (status === "accepted") {
    const receiverUser = await Register.findById(
      connectionRequest.user.toString()
    );
    console.log(receiverUser);

    if (!receiverUser) {
      return res.status(404).json({ message: "Receiver not found" });
    }

    // Find the connection request in the user's connections array
    const receiverConnectionRequest = receiverUser.connections.find(
      (connection) => connection.user.toString() === userId
    );

    if (!receiverConnectionRequest) {
      return res.status(404).json({ message: "Connection request not found" });
    }

    // Update the status of the connection request to "accepted"
    receiverConnectionRequest.status = status;
    console.log(receiverConnectionRequest);
    await receiverUser.save();
    // }
    res.status(200).json({ message: "Connection request updated" });
  } catch (err) {
    res.status(500).json({ message: "Server error" });
  }
});

const getConnectionList = asyncWrapper(async (req, res) => {
  try {
    const userId = req.params.userId;

    // Find the user by their ID and populate the connections with the "accepted" status
    const user = await Register.findById(userId).populate("connections.user");
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    const filteredUsers = user.connections.filter(
      (item) => item.status === "accepted"
    );
    console.log("user.connections", filteredUsers);
    res.status(200).json(filteredUsers);
  } catch (err) {
    res.status(500).json({ message: "Server error" });
  }
});

const getRequestList = asyncWrapper(async (req, res) => {
  try {
    const userId = req.params.userId;

    // Find the user by their ID and populate the connections with the "accepted" status
    const user = await Register.findById(userId).populate("connections.user");

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    const filteredUsers = user.connections.filter(
      (item) => item.status === "pending" && item.isSent === false
    );
    console.log("user.connections", filteredUsers);
    res.status(200).json(filteredUsers);
  } catch (err) {
    res.status(500).json({ message: "Server error" });
  }
});

module.exports = {
  getUser,
  createUser,
  emailSend,
  changePassword,
  updatePasswordGoogle,
  searchUsers,
  purchasedCourse,
  purchasedModule,
  sendFriendRequest,
  acceptFriendRequest,
  getConnectionList,
  getRequestList,
};
