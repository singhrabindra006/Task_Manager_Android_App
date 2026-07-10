const mongoose = require("mongoose");
const { MONGO_URI } = require("./env");

const connect_db = async () => {
  try {
    await mongoose.connect(MONGO_URI);
    console.log("MondoDB Connected.");
  } catch (e) {
    console.log("MongoDB connection failed.");
  }
};

module.exports = connect_db;
