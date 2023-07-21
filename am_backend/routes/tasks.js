const express = require("express");
const router = express.Router();


const passport = require('passport');
const {

  createUser,
  getUser,emailSend,changePassword,updatePasswordGoogle
  
} = require("../controllers/register");

router.route("/registerNewUser").post(createUser);

router.route("/getUser").post(getUser);

router.route("/email-send").post(emailSend);

router.route("/change-password").post(changePassword);

router.route("/update-password-google").post(updatePasswordGoogle);


// router.route("/fetchuser").post(createUser);

module.exports = router;
