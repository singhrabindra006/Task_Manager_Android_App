const app = require("./app.js");
const connect_db = require("./config/db.js");
const { PORT } = require("./config/env.js");

connect_db();

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server running on port ${PORT || 8000}`);
  console.log(
    `Phone can connect via Wi-Fi at http://192.168.1.66:${PORT || 8000}`,
  );
});
