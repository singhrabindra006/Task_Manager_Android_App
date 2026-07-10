const User = require("../models/user");
const jwt = require("jsonwebtoken");
const { JWT_SECRET } = require("../config/env");

const auth = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) {
      return res
        .status(401)
        .json({ message: "No token, authorization denied" });
    }

    const verified = jwt.verify(token, JWT_SECRET);
    const user = await User.findById(verified.id).select("-password");

    if (!user) {
      return res.status(401).json({ message: "User no longer exists" });
    }

    req.user = user;
    req.token = token;
    next();
  } catch (err) {
    return res.status(401).json({ message: "Token is not valid" });
  }
};

module.exports = auth;
