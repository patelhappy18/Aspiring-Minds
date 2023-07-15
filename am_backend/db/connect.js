const mongoose = require('mongoose')

const connectDB = (url) => {

  return mongoose.connect(url, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  ssl: true, // Enable SSL/TLS encryption
});

}


module.exports = connectDB



