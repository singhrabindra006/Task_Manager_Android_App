const app = require("./app.js");
const connect_db = require("./config/db.js");
const { PORT } = require("./config/env.js");

connect_db();

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT || 8000}`);
});
