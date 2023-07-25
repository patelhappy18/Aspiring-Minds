const asyncWrapper = require("../middleware/asyncWrapper");
const bcrypt = require("bcryptjs");
const { Course } = require("../model/course");
const Register = require("../model/register");

//API for creating courses
const createCourse = asyncWrapper(async (req, res) => {
  const { title, author, rating, price, modules } = req.body;

  const newCourse = new Course({ title, author, rating, price, modules });

  newCourse
    .save()
    .then((savedCourse) => {
      res.status(200).json({ course: savedCourse });
    })
    .catch((error) => {
      res.status(500).json({ error: "Failed to save the course" });
    });
});

const getCourses = asyncWrapper((req, res) => {
  Course.find()
    .then((courses) => {
      res.status(200).json(courses);
    })
    .catch((error) => {
      res.status(500).json({ error: "Failed to fetch courses" });
    });
});

const getCourseById = asyncWrapper((req, res) => {
  const courseId = req.params.id;

  Course.findById(courseId)
    .then((course) => {
      if (!course) {
        return res.status(404).json({ error: "Course not found" });
      }
      res.status(200).json(course);
    })
    .catch((error) => {
      res.status(500).json({ error: "Failed to fetch the course" });
    });
});

const getUserCourses = asyncWrapper((req, res) => {
  const userId = req.params.userId;
  console.log("userId", userId);
  Register.findById(userId)
    .populate("purchasedCourses")
    .then((user, err) => {
      if (err) {
        console.log(err);
        return res.status(500).json({ error: "Failed to fetch user courses" });
      }

      if (!user) {
        return res.status(404).json({ error: "User not found" });
      }

      res.status(200).json(user.purchasedCourses);
    });
});

module.exports = {
  getCourses,
  getCourseById,
  createCourse,
  getUserCourses,
};
