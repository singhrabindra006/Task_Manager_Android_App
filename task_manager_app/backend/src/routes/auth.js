const express = require("express");
const User = require("../models/user");
const authRouter = express.Router();
const bcryptjs = require("bcryptjs");
const { BCRYPT_SALT_ROUNDS, JWT_SECRET, JWT_EXPIRE } = require("../config/env");
const jwt = require("jsonwebtoken");
const auth = require("../middleware/authMiddleware");

//signup api
authRouter.post("/signup", async (req, res) => {
  try {
    // get request body
    const { name, email, password } = req.body;
    // check if user already exists
    const existingUser = await User.findOne({ email });

    if (existingUser) {
      return res.status(400).json({
        message: "User already exists!",
      });
    }
    // hash password
    const hashedPassword = await bcryptjs.hash(
      password,
      Number(BCRYPT_SALT_ROUNDS),
    );
    // create new user and store in database
    const user = await User.create({
      name,
      email,
      password: hashedPassword,
    });

    res.status(201).json({
      message: "User created successfully!",
      user: {
        id: user._id,
        name: user.name,
        email: user.email,
      },
    });
  } catch (e) {
    res.status(500).json({
      error: e.message,
    });
  }
});

//login api
authRouter.post("/login", async (req, res) => {
  try {
    // get request body
    const { email, password } = req.body;
    // check if user does not exists
    const existingUser = await User.findOne({ email });

    if (!existingUser) {
      return res.status(400).json({
        message: "User with this email does not exist!",
      });
    }
    // mached password
    const isMatch = await bcryptjs.compare(password, existingUser.password);

    if (!isMatch) {
      return res.status(400).json({
        message: "Incorrect Password!",
      });
    }

    const token = jwt.sign({ id: existingUser._id }, JWT_SECRET, {
      expiresIn: JWT_EXPIRE,
    });
    res.status(200).json({
      message: "Login successful!",
      token,
      user: {
        id: existingUser._id,
        name: existingUser.name,
        email: existingUser.email,
      },
    });
  } catch (e) {
    res.status(500).json({
      error: e.message,
    });
  }
});

//api for handle token expire
authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    //get the header
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    //verify if the token is valid
    const verifed = jwt.verify(token, JWT_SECRET);
    const user = await User.findById(verifed.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json(false);
  }
});

authRouter.get("/", auth, async (req, res) => {
  try {
    const user = await User.findById(req.user._id).select("-password");
    if (!user) {
      return res.status(401).json({ message: "User no longer exists" });
    }
    res.json({ user });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = {
  authRouter,
};
