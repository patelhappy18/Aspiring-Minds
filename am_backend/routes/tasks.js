const express = require("express");
const router = express.Router();

const passport = require("passport");
const {
  createUser,
  getUser,
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
} = require("../controllers/register");

router.route("/registerNewUser").post(createUser);

router.route("/getUser").post(getUser);

router.route("/searchUsers").post(searchUsers);

router.route("/email-send").post(emailSend);

router.route("/change-password").post(changePassword);

router.route("/update-password-google").post(updatePasswordGoogle);

router.route("/:userId/purchased-course").post(purchasedCourse);

router.route("/:userId/purchased-module").post(purchasedModule);
// router.route("/fetchuser").post(createUser);
router.route("/sendFriendRequest").post(sendFriendRequest);

router.route("/acceptFriendRequest").post(acceptFriendRequest);

router.route("/connections/accepted/:userId").get(getConnectionList);

router.route("/connections/pending/:userId").get(getRequestList);

module.exports = router;
