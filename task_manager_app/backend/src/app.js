const express = require("express");
const cors = require("cors");
const helmet = require("helmet");
const cookieParser = require("cookie-parser");
const { authRouter } = require("./routes/auth.js");
const { taskRouter } = require("./routes/task.js");

const app = express();

// for security middleware
app.use(helmet());

//to excess the api for client server i.e UI/UX without cors backend is blocked
app.use(
  cors({
    origin: true,
    credentials: true,
  }),
);
// reciving the data in json formate from ui
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Cookies
app.use(cookieParser());

//Routes
app.use("/auth", authRouter);
app.use("/task", taskRouter);
console.log("task route registered");

module.exports = app;
