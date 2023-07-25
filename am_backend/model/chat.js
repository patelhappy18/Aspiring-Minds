const mongoose = require("mongoose");

const TaskSchema = new mongoose.Schema({

  senderId: {
    type: String,
    required: true,
  },
  receiverId: {
    type: String,
    trim: true,
  },

  msgs : [{sent_msg: String, time: String,date:String,receive_msg:String}],


});

module.exports = mongoose.model("Chat", TaskSchema); //This name is used with adding 's' behind the name for naming the collection
