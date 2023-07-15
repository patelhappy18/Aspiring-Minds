const express = require("express");
const router = express.Router();


const passport = require('passport');
const {

  createUser,
  getUser,
  
} = require("../controllers/register");

router.route("/register").post(createUser);

module.exports = router;
