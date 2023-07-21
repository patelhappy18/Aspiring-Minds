const express = require("express");
const router = express.Router();


const passport = require('passport');
const {

  createUser,
  getUser,
  
} = require("../controllers/register");

router.route("/registerNewUser").post(createUser);

router.route("/getUser").post(getUser);



// router.route("/fetchuser").post(createUser);

module.exports = router;
