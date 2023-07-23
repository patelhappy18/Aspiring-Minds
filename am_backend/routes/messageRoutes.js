const express = require('express');
const router = express.Router();
const {
  saveMessage,
  getMessagesBetweenUsers,getMessagesForReceiver,getSpecificMessages,getMySendedMessages,getSenderMessages,getReceiverMessages,sendCustomerServiceRequest
} = require('../controllers/message');

// Define the routes for saving a new message and getting messages between users
router.post('/messages', saveMessage);

// router.get('/getSpecificUsermessages', getMessagesBetweenUsers);

router.post('/getSpecificUsermessages', getMessagesForReceiver);

router.post('/getSpecificMessages', getSpecificMessages);

router.post('/getMySendedMessages', getMySendedMessages);

router.post('/getSenderMessages', getSenderMessages);

router.post('/getReceiverMessages', getReceiverMessages);

router.route("/sendCustomerServiceRequest").post(sendCustomerServiceRequest);


module.exports = router;
