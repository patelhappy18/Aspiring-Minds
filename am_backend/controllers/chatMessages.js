const Register = require("../model/register");
const asyncWrapper = require('../middleware/asyncWrapper');
const bcrypt = require('bcryptjs')

const returnChatMessages = asyncWrapper(async (req, res) => {

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


  const reply = asyncWrapper(async (req, res) => {

    const username = req.body.username;
    const email = req.body.email;
    const message = req.body.message;
    const tasks = await Register.findOne({email: email });
console.log(message+username)
  
      
  });
  module.exports = {
    returnChatMessages
  };