const mongoose = require("mongoose");

const moduleSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  items: {
    type: [String],
    required: true,
  },
  module_price: {
    type: Number,
    required: true,
  },
});

const courseSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  author: {
    type: String,
    required: true,
  },
  rating: {
    type: Number,
    required: true,
  },
  price: {
    type: Number,
    required: true,
  },
  modules: {
    type: [moduleSchema],
    required: true,
  },
});

const Course = mongoose.model("Course", courseSchema);

module.exports = Course;
