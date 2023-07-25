const express = require("express");
const {
  getCourses,
  createCourse,
  getCourseById,
  getUserCourses,
} = require("../controllers/courseControllers");
const router = express.Router();

router.route("/").post(createCourse);

router.route("/").get(getCourses);
router.route("/user/:userId").get(getUserCourses);
router.route("/:id").get(getCourseById);

module.exports = router;
