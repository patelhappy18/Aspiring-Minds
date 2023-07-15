const Register = require("../model/register");
const asyncWrapper = require('../middleware/asyncWrapper');
const bcrypt = require('bcryptjs')

const createUser = asyncWrapper(async (req, res) => {

  const username = req.body.username;
  const email = req.body.email;
  const tasks = await Register.findOne({email: email });


    if(!tasks){
      req.body.password = await bcrypt.hash(req.body.password,12);
      const registerUser = await Register.create(req.body);

      if(req.session.Question_Data){

        console.log("Signup with Question Data");

              let date_time = new Date();
              let date = ("0" + date_time.getDate()).slice(-2);
              let month = ("0"+(date_time.getMonth() + 1)).slice(-2);
              let year = date_time.getFullYear();
              var hours = date_time.getHours();
              var minutes = date_time.getMinutes();
              var ampm = hours >= 12 ? 'PM' : 'AM';
              hours = hours % 12;
              hours = hours ? hours : 12; // the hour '0' should be '12'
              minutes = minutes < 10 ? '0'+minutes : minutes;
              var strTime = hours + ':' + minutes + ' ' + ampm;
              date_time.setMonth(month - 1);
              let Month_Name = date_time.toLocaleString('en-US', { month: 'short' });
              let finalDate = (Month_Name + " " + date +"," + year);
              
              req.session.Question_Data.dateCreated =finalDate ;
              req.session.Question_Data.time = strTime ;
              req.session.Question_Data.dateClosed = "TBD";
              req.session.Question_Data.status = "";
              req.session.Question_Data.userid = registerUser['_id'];
              req.session.Question_Data.answer = "";
              req.session.Question_Data.timeClosed = "TBD"
              const registerquestion = await Questions.create(req.session.Question_Data);

              console.log()
              const data = await sendAskTheExpertEmail(req.body.pname,req.body.email,req.session.Question_Data.user_question,req.session.Question_Data.user_provider,req.session.Question_Data.extranote);

      }
      req.session.userId = registerUser['_id'];
      req.session.email = req.body.email;
      req.session.pname = req.body.pname;

      const provider = await Provider.find({});
      const files = await MultipleFile.find({userid:req.session.userId})
      const ques  = await Questions.find({userid:req.session.userId});
      
      res.redirect('/lower-new-bill');
      
      // res.render("home-2",{records:provider,bills:files,ques:ques});

    }
    else{
      req.flash('message','This email address is already registered with us')
      res.redirect('/register');
    }
  
});

const getUser = asyncWrapper(async (req, res) => {
  const email = req.body.email;
  const password = req.body.password;
  const question = req.session.Question_Data;
  console.log("-==========",req.session.Question_Data);

  // const tasks = await Register.findOne({email: email , password : password });

  const tasks =await Register.findOne({ email })
  .then(user => {
      if (!user){
            req.flash('message','User not exist')
            res.redirect('/login');
      }
      bcrypt.compare(password, user.password, async(err, data) => {
          //if error than throw error
          if (err) {
            req.flash('wrong_password','Password you entered is incorrect')
            res.redirect('/login');
          }

          //if both match than you can do anything
          if (data) {
            // console.log();
            
            req.session.userId = user._id;
            req.session.email = user.email;
            req.session.pname = user.pname;

              console.log("=============." +req.session.Question_Data);

            if(req.session.Question_Data){

              console.log("Login with Question Data");

              let date_time = new Date();
              let date = ("0" + date_time.getDate()).slice(-2);
              let month = ("0"+(date_time.getMonth() + 1)).slice(-2);
              let year = date_time.getFullYear();
              var hours = date_time.getHours();
              var minutes = date_time.getMinutes();
              var ampm = hours >= 12 ? 'PM' : 'AM';
              hours = hours % 12;
              hours = hours ? hours : 12; // the hour '0' should be '12'
              minutes = minutes < 10 ? '0'+minutes : minutes;
              var strTime = hours + ':' + minutes + ' ' + ampm;
              date_time.setMonth(month - 1);
              let Month_Name = date_time.toLocaleString('en-US', { month: 'short' });
              let finalDate = (Month_Name + " " + date +"," + year);
              req.session.Question_Data.userid = user._id;
              req.session.Question_Data.dateCreated =finalDate ;
              req.session.Question_Data.time = strTime ;
              req.session.Question_Data.dateClosed = "TBD";
              req.session.Question_Data.status = "";
              req.session.Question_Data.answer = "";

              const registerquestion = await Questions.create(req.session.Question_Data);
              const data = await sendAskTheExpertEmail(req.session.pname,req.session.email,req.session.Question_Data.user_question,req.session.Question_Data.user_provider,req.session.Question_Data.extranote);

            }
            

            const provider = await Provider.find({});
            const files = await MultipleFile.find({userid:req.session.userId})
            const ques  = await Questions.find({userid:req.session.userId});
            const savedAmount =  await MultipleFile.find({userid:req.session.userId}).select('filesavedamount');
            const total_files = Object.keys(files).length;

              let amount_saved = 0;

                for (let i = 0; i < savedAmount.length; i++) {
                  amount_saved += parseInt(savedAmount[i]['filesavedamount']);
                }

            res.render("home-2",{records:provider,bills:files,ques:ques,amountSaved:amount_saved,totalFiles:total_files,userName:req.session.pname,QUESTION_DATA:req.session.Question_Data});
              // return res.status(200).json({ msg: "Login success" })
          } 
          else {
            req.flash('message','Incorrect Password')
            res.redirect('/login');
              // return res.status(401).json({ msg: "Invalid credencial" })
          }

      })

  })
  
});

const getUserDetails = asyncWrapper(async (req, res) => {

  const user = await Register.find({_id:req.params.id});
  console.log(user);

})

module.exports = {
  createUser,getUser,getUserDetails  
};