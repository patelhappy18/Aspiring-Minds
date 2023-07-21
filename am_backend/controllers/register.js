const Register = require("../model/register");
const asyncWrapper = require('../middleware/asyncWrapper');
const bcrypt = require('bcryptjs')

const createUser = asyncWrapper(async (req, res) => {
  const firstname = req.body.firstname;
  const lastname = req.body.lastname;
  const email = req.body.email;
  const tasks = await Register.findOne({email: email });


    if(!tasks){
      req.body.password = await bcrypt.hash(req.body.password,12);
      const registerUser = await Register.create(req.body);
      // console.log(registerUser['_id']);
      // req.session.userId = registerUser['_id'];
      // req.session.email = req.body.email;
      // req.session.pname = req.body.pname;
      
      // console.log(req.session);
      res.json("Done")
      // res.render("home-2",{records:provider,bills:files,ques:ques});

    }
    else{
      req.flash('message','This email address is already registered with us')
      // res.redirect('/register');
    }
  
});



// const getUserDetails = asyncWrapper(async (req, res) => {

//   const user = await Register.find({_id:req.params.id});
//   console.log(user);

// })

module.exports = {
  createUser,
  //getUser  
};