const Register = require("../model/register");
const asyncWrapper = require('../middleware/asyncWrapper');
const bcrypt = require('bcryptjs')


const fetchVideo = asyncWrapper(async (req,res)=>{
  try {
    const videos = await Video.find({}, 'title url'); // Assuming you have 'title' and 'url' fields in your Video model

    res.json({ success: true, videos });
  } catch (error) {
    console.error('Error fetching video links:', error);
    res.status(500).json({ success: false, message: 'Failed to fetch video links' });
  }
})


module.exports = {
  createUser,fetchVideo 
};