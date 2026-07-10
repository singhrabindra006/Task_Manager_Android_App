const express = require("express");
const cors = require("cors");
const helmet = require("helmet");
const cookieParser = require("cookie-parser");
const { authRouter } = require("./routes/auth.js");

const app = express();

// for security middleware
app.use(helmet());

//to excess the api for client server i.e UI/UX without cors backend is blocked
app.use(
  cors({
    origin: process.env.CLIENT_URL,
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

module.exports = app;
