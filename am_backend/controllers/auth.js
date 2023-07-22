var GoogleStrategy = require("passport-google-oauth2").Strategy;
const Register = require("../model/register");
const passport = require("passport");
const { google } = require('googleapis');
var nodemailer = require('nodemailer');
require('dotenv').config();
const jwt = require('jsonwebtoken');

const GOOGLE_CLIENT_ID = process.env.GOOGLE_CLIENT_ID;
const GOOGLE_CLIENT_SECRET = process.env.GOOGLE_CLIENT_SECRET;
const REDIRECT_URI = process.env.REDIRECT_URI;
const REFRESH_TOKEN = process.env.REFRESH_TOKEN;


const CALL_BACK_URL = process.env.CALL_BACK_URL;

const ADMIN_EMAIL = process.env.ADMIN_EMAIL;
const AUTH_EMAIL = process.env.AUTH_EMAIL;



// const oAuth2Client = new google.auth.OAuth2(GOOGLE_CLIENT_ID,GOOGLE_CLIENT_SECRET,REDIRECT_URI)
// oAuth2Client.setCredentials({refresh_token:REFRESH_TOKEN});

passport.use(new GoogleStrategy({
  clientID: GOOGLE_CLIENT_ID,
  clientSecret: GOOGLE_CLIENT_SECRET,
  callbackURL: CALL_BACK_URL,
},
async (accessToken, refreshToken, profile, done) => {
  try {
    let user = await User.findOne({ googleId: profile.id });
    if (!user) {
      user = new User({
        googleId: profile.id,
        name: profile.displayName,
        email: profile.emails[0].value,
      });
      await user.save();
    }
    return done(null, user);
  } catch (error) {
    return done(error);
  }
}
));

function generateToken(user) {
  return jwt.sign({ userId: user._id }, SECRET_KEY);
}


// passport.use(
//   new GoogleStrategy(
//     {
//       clientID: GOOGLE_CLIENT_ID,
//       clientSecret: GOOGLE_CLIENT_SECRET,
//       callbackURL: CALL_BACK_URL,  //https://billshaper.com/google/callback,
//       passReqToCallback: true,
//     },
//     async function (req, accessToken, refreshToken, profile, done) {


//       const tasks = await Register.findOne({ email: profile.email });

//         if (!tasks) {

//           const body = new Register({
//             email: profile.email,
//             password: profile.id,
//             firstname: profile.given_name,
//             lastname: profile.family_name,
//           });
//           const registerUser = await Register.create(body);
  
//           //registerUser["email"];


//           return done(null, true, {
//             userid: registerUser["_id"],
//             email: registerUser["email"],
//             firstname: registerUser["firstname"],
//             lastname: registerUser["lastname"],
//           });
  
//           // return done(null, profile);
//         } else {

//           return done(null, true, {
//             userid: tasks["_id"],
//             email: tasks["email"],
//             firstname: tasks["firstname"],
//             lastname: tasks["lastname"],
//           });
//         }
      
//     }
//   )
// );

passport.serializeUser(function (user, done) {
  done(null, user);
});

passport.deserializeUser(function (user, done) {
  done(null, user);
});

async function sendAskTheExpertEmail(username,email,question,provider,note){
  try{
    const accessToken = await oAuth2Client.getAccessToken();

    let transport = nodemailer.createTransport({

      service: 'gmail',
      port:465,
      secure: true, // true for 465, false for other ports
      logger: true,
      debug: true,
      secureConnection: true,
      ignoreTLS: true, // add this 
      auth: {
        type: 'OAuth2',
        user: AUTH_EMAIL,
        clientId:CLIENT_ID,
        clientSecret:CLIENT_SECRET,
        accessToken:accessToken,
        refreshToken:REFRESH_TOKEN
      }

    
   });

   const mailOptions = {
    from: `Ask the Expert <${ADMIN_EMAIL}>`, // Cer address
    to: ADMIN_EMAIL, // billshaperus@gmail.com
    subject: question, // Subject line
    // text: msg, // Plain text body
    html:'<h3>UserName : </h3>'+username+'<h3>Email : </h3>'+email+'<h3>Question : </h3>'+question+'<h3>Provider : </h3>'+provider+'<h3>Extra Note </h3>'+ '<h3>'+note+'</h3>'
  };

 const result = await transport.sendMail(mailOptions);
 return result;
    
  }catch(err){
    console.log(err)
    return err;
  }
};
