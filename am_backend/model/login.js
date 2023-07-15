const mongoose = require("mongoose");

const TaskSchema = new mongoose.Schema({
    email:{
        type: String,
        required: [true, "must provide name"],
        trim:true,
    },

    password:{
      type: String,
      required: [true, "must provide name"],
      trim:true,
      maxlength:[20,"Cannot be more than 20 characters"]
    },
  })
  
  
  module.exports = mongoose.model("users", TaskSchema)  //This name is used with adding 's' behind the name for naming the collection