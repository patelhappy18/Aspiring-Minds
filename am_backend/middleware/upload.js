const path = require('path');
const multer = require('multer');

const storage = multer.diskStorage({
  destination: function(req, file, cb) {
    cb(null, 'uploads');
  },
  filename: function(req, file, cb) {
    let ext = path.extname(file.originalname)
    cb(null,new Date().toISOString().replace(/:/g,'-')+ '-' +file.originalname , ext);
  }
});

const upload = multer({
  storage: storage,
  fileFilter:function(req,file,cb){
  //  console.log(typeof(Date.now())) ;
    if (file.originalname.match(/\.(pdf|PDF|jpeg|JPEG|jpg|JPG|PNG|png)$/)) {
      cb(null, true);

    }else{
      console.log('Only JPG and PNG file')
          cb(null, false);
    }

    // if (file.mimetype == 'png' || file.mimetype == 'jpg') {
    //   res.send("EERERER");   
    //    cb(null, true);
    //     } else {
    //       console.log('Only jpg and png file')
    //       cb(null, false);
    //     }
  },
  // limits: {
  //   fileSize: 1024 * 1024 * 2
  // }
});

module.exports = upload