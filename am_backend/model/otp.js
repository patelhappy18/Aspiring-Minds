const mongoose = require("mongoose");

const otpSchema = new mongoose.Schema({
    email:String,
    code:String,
    expireIn:Number
},{
    timestamps:true
})
  
module.exports = mongoose.model("otp", otpSchema)  //This name is used with adding 's' behind the name for naming the collection

//   module.exports = mongoose.model("otp", otpSchema,"otp") //this last option is for customized name of table in mongoDb.