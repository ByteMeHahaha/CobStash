// import express from "express";
import { runCobol } from "./cobol";

// const app = express();

// app.listen(3000, () => {
//     console.log("API server running on port 3000");
// });

runCobol("READ|1")
  .then(console.log)
  .catch(console.error);
