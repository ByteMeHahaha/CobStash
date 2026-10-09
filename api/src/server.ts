import express from "express";
import { runCobol } from "./cobol";

const app = express();

// GET request to fetch a specific stash
app.get("/api/stash/:id", async (req, res) => {
  try {
    // Store the ID from the above API endpoint
    const id = req.params.id;

    // Run the backend to fetch the specified stash entry
    const result = await runCobol(`READ|${id}`);

    // Send the result to the frontend
    res.status(200).send(result);
  } catch (err) {
    console.error(err);
    res.status(500).send("CobStash backend failed\n");
  }
});

// Make the API server listen on port 3000
const server = app.listen(3000, () => {
  console.log("API server running on port 3000\n");
});

// When the user hits CTRL+C
process.on("SIGINT", () => {
  // Display a message indicating shutdown
  console.log("\nShutting down CobStash API...");

  // Close the server and its connections
  server.close(() => {
    // Display a message indicating the server is shutdown
    console.log("Server shut down.");
    // End the program
    process.exit(0);
  });
});
