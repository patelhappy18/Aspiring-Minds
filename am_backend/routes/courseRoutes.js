const express = require("express");
const {
  getCourses,
  createCourse,
  getCourseById,
} = require("../controllers/courseControllers");
const router = express.Router();

router.route("/").post(createCourse);

router.route("/").get(getCourses);
router.route("/:id").get(getCourseById);

module.exports = router;
