const mongoose = require('mongoose');
const Register = require('./register'); // Replace './path/to/register' with the actual path to your 'register.js' file

const messageSchema = new mongoose.Schema({
  sender: {
    type: mongoose.Schema.Types.ObjectId,
    ref: Register, // Use 'Register' instead of 'User'
    required: true,
  },
  receiver: {
    type: mongoose.Schema.Types.ObjectId,
    ref: Register, // Use 'Register' instead of 'User'
    required: true,
  },
  content: {
    type: String,
    required: true,
  },
  timestamp: {
    type: Date,
    default: Date.now,
  },
});

const Message = mongoose.model('Message', messageSchema);

module.exports = Message;
