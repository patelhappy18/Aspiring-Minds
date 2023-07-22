const mongoose = require("mongoose");

const TaskSchema = new mongoose.Schema({
  email: {
    type: String,
    required: [true, "Email must be provide name"],
    trim: true,
    unique: true,
  },

  password: {
    type: String,
    required: [true, " Password must provide name"],
    trim: true,
    maxlength: [100, "Cannot be more than 20 characters"],
  },

  firstname: {
    type: String,
    trim: true,
  },
  lastname: {
    type: String,
    trim: true,
  },
  purchasedCourses: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Course", // This refers to the Course model
    },
  ],
});

module.exports = mongoose.model("Register", TaskSchema); //This name is used with adding 's' behind the name for naming the collection