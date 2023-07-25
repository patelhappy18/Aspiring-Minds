const asyncWrapper = require("../middleware/asyncWrapper");
require("dotenv").config();
const Message = require("../model/message");
const Register = require("../model/register");
const Chat = require("../model/chat");

const saveMessage = asyncWrapper(async (req, res) => {
  try {
    // console.log(req);
    const { senderId, receiverId, content } = req.body;

    // Create a new message instance
    const newMessage = new Message({
      sender: senderId,
      receiver: receiverId,
      content: content,
    });

    // Save the message to the database
    const savedMessage = await newMessage.save();

    const messages = await Message.find({
      $or: [
        { sender: senderId, receiver: receiverId },
        { sender: receiverId, receiver: senderId },
      ],
    }).sort("timestamp");

    // Return the saved message in the response
    console.log("=======> message", messages);
    res.status(200).json({ success: true, message: messages });
  } catch (error) {
    // Handle errors
    console.error("Error saving message:", error);
    res.status(500).json({ success: false, error: "Server error" });
  }
});

// Controller to get all messages between two users
const getMessagesBetweenUsers = asyncWrapper(async (req, res) => {
  try {
    const { senderId, receiverId } = req.body;

    // Fetch all messages between the two users from the database
    const messages = await Message.find({
      $or: [
        { sender: senderId, receiver: receiverId },
        { sender: receiverId, receiver: senderId },
      ],
    }).sort("timestamp");

    // Return the messages in the response
    res.status(200).json({ success: true, messages });
  } catch (error) {
    // Handle errors
    console.error("Error fetching messages:", error);
    res.status(500).json({ success: false, error: "Server error" });
  }
});

const getMessagesForReceiver = asyncWrapper(async (req, res) => {
  try {
    const { receiverId } = req.body; // Get the receiverId from the URL parameters
    // console.log(req.body);

    const uniqueSenderIds = await Message.find({
      receiver: receiverId,
    }).distinct("sender");

    // Query the Register model to find the firstnames of senders based on their IDs
    const senders = await Register.find({
      _id: { $in: uniqueSenderIds },
    }).select("firstname _id");

    // Construct the response data with sender firstnames
    const responseData = senders.map((sender) => ({
      firstname: sender.firstname,
      _id: sender._id,
    }));

    res.status(200).json({ responseData });
  } catch (error) {
    // Handle errors
    console.error("Error fetching messages:", error);
    res.status(500).json({ success: false, error: "Server error" });
  }
});

const getSpecificMessages = asyncWrapper(async (req, res) => {
  try {
    const { senderId, receiverId } = req.body;

    // Fetch all messages between the two users from the database
    const messages = await Message.find({
      $or: [
        { sender: senderId, receiver: receiverId },
        { sender: receiverId, receiver: senderId },
      ],
    }).sort("timestamp");
    // console.log(messages);
    // Return the messages in the response
    res.status(200).json({ messages });
  } catch (error) {
    // Handle errors
    console.error("Error fetching messages:", error);
    res.status(500).json({ success: false, error: "Server error" });
  }
});

const getMySendedMessages = asyncWrapper(async (req, res) => {
  try {
    // Fetch all messages with the given senderId and receiverId
    const messages = await Message.find({
      $or: [
        { sender: req.body.senderId, receiver: req.body.receiverId }, // Messages sent by sender
        { sender: req.body.receiverId, receiver: req.body.senderId }, // Messages received by sender
      ],
    }).sort("timestamp");

    // Split messages into sent and received messages based on senderId and receiverId
    const sentMessages = messages.filter(
      (message) => message.sender.toString() === req.body.senderId
    );
    const receivedMessages = messages.filter(
      (message) => message.sender.toString() === req.body.receiverId
    );
    // console.log("Sended Messages:" + sentMessages);
    // console.log("Received Messages:" + receivedMessages);

    return { sentMessages, receivedMessages };
  } catch (err) {
    console.error("Error fetching messages:", err);
    throw err;
  }
  // try {
  //     const { senderId } = req.body;

  //     // Fetch all messages between the two users from the database
  //     const messages = await Message.find({
  //       $or: [
  //         { sender: senderId, receiver: receiverId },
  //         { sender: receiverId, receiver: senderId },
  //       ],
  //     }).select('content -_id')
  //     .sort('timestamp');
  //     console.log(messages)
  //     // Return the messages in the response
  //     res.status(200).json({ messages });
  //   } catch (error) {
  //     // Handle errors
  //     console.error('Error fetching messages:', error);
  //     res.status(500).json({ success: false, error: 'Server error' });
  //   }
});

const getSenderMessages = asyncWrapper(async (req, res) => {
  try {
    const { senderId } = req.body;
    const senderMessages = await Message.find({ senderId });
    res.json(senderMessages);
  } catch (err) {
    console.error("Error fetching sender messages:", err);
    throw err;
  }
});
const getReceiverMessages = asyncWrapper(async (req, res) => {
  try {
    const { receiverId } = req.body;
    const receiverMessages = await Message.find({ receiverId });
    res.json(receiverMessages);
  } catch (err) {
    console.error("Error fetching receiver messages:", err);
    throw err;
  }
});

const sendCustomerServiceRequest = asyncWrapper(async (req, res) => {
  let date_time = new Date();
  let data = "";
  let date = ("0" + date_time.getDate()).slice(-2);
  let month = ("0" + (date_time.getMonth() + 1)).slice(-2);
  let year = date_time.getFullYear();
  date_time.setMonth(month - 1);

  let Month_Name = date_time.toLocaleString("en-US", { month: "short" });
  let finalDate = Month_Name + " " + date + "," + year;

  var hours = date_time.getHours();
  var minutes = date_time.getMinutes();
  var ampm = hours >= 12 ? "PM" : "AM";
  hours = hours % 12;
  hours = hours ? hours : 12; // the hour '0' should be '12'
  minutes = minutes < 10 ? "0" + minutes : minutes;

  req.body.time = hours + ":" + minutes + " " + ampm;

  try {
    let oldMsg = "";
    let newMsg = "";
    let newMsgList = "";
    // Check if the message with the given senderId and receiverId exists
    const existingMessage = await Chat.findOne({
      senderId: req.body.senderId,
      receiverId: req.body.receiverId,
    });

    if (existingMessage) {
      // If the message exists, update the content and timestamp
      if (req.body.receive_msg) {
        oldMsg = {
          receive_msg: req.body.receive_msg,
          time: req.body.time,
          date: finalDate,
        };
      }
      if (req.body.sent_msg) {
        oldMsg = {
          sent_msg: req.body.sent_msg,
          time: req.body.time,
          date: finalDate,
        };
      }

      data = await Chat.updateOne(
        { _id: existingMessage._id },
        {
          $push: {
            msgs: oldMsg,
          },
        }
      );
    } else {
      newMsg = await Chat.create(req.body);

      if (req.body.receive_msg) {
        newMsgList = {
          receive_msg: req.body.receive_msg,
          time: req.body.time,
          date: finalDate,
        };
      }
      if (req.body.sent_msg) {
        newMsgList = {
          sent_msg: req.body.sent_msg,
          time: req.body.time,
          date: finalDate,
        };
      }

      data = await Chat.updateOne(
        { _id: newMsg._id },
        {
          $push: {
            msgs: newMsgList,
          },
        }
      );
    }

    res.json({ success: true, message: "Message added/updated successfully." });
  } catch (err) {
    console.error("Error adding/updating message:", err);
    throw err;
  }
});

module.exports = {
  saveMessage,
  getMessagesBetweenUsers,
  getMessagesForReceiver,
  getSpecificMessages,
  getMySendedMessages,
  getSenderMessages,
  getReceiverMessages,
  sendCustomerServiceRequest,
};
