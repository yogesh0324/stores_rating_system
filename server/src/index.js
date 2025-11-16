import { app } from "./app.js";
import { config } from "./config/env.js";
import "./config/db.js";
import { testQuery } from "./utils/testQuery.js";

testQuery();

app.listen(config.port, () => {
    console.log(`Server running on port ${config.port}`);
});
