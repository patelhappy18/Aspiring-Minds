const Register = require("../model/register");
const asyncWrapper = require("../middleware/asyncWrapper");
const bcrypt = require("bcryptjs");

const createUser = asyncWrapper(async (req, res) => {
  const firstname = req.body.firstname;
  const lastname = req.body.lastname;
  const email = req.body.email;
  const tasks = await Register.findOne({ email: email });

  if (!tasks) {
    req.body.password = await bcrypt.hash(req.body.password, 12);
    const registerUser = await Register.create(req.body);
    // console.log(registerUser['_id']);
    // req.session.userId = registerUser['_id'];
    // req.session.email = req.body.email;
    // req.session.pname = req.body.pname;

    // console.log(req.session);
    res.json("Done");
    // res.render("home-2",{records:provider,bills:files,ques:ques});
  } else {
    req.flash("message", "This email address is already registered with us");
    // res.redirect('/register');
  }
});

const getUser = asyncWrapper(async (req, res) => {
  const email = req.body.email;
  const password = req.body.password;

  const tasks = await Register.findOne({ email }).then((user) => {
    if (!user) {
      res.status(404).json({ error: "User not found" });
    }
    bcrypt.compare(password, user.password, async (err, data) => {
      //if error than throw error
      if (err) {
        res.send(402);
      }

      //if both match than you can do anything
      if (data) {
        res.json(user);
      } else {
        return res.status(401).json({ msg: "Invalid credential" });
      }
    });
  });
});

module.exports = {
  getUser,
  createUser,
};