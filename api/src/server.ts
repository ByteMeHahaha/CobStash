// import express from "express";
import { runCobol } from "./cobol";

// const app = express();

// app.listen(3000, () => {
//     console.log("API server running on port 3000");
// });

runCobol("ADD|1|Ethan|THATS ME!!")
  .then(console.log)
  .catch(console.error);

runCobol("READ|1")
  .then(console.log)
  .catch(console.error);

runCobol("UPD|1|Ethan|That's not me!")
  .then(console.log)
  .catch(console.error);

runCobol("DEL|1")
  .then(console.log)
  .catch(console.error);
