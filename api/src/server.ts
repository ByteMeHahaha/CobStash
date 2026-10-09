import express from "express";
import { runCobol } from "./cobol";
import { resToJsonString } from "./resToJsonString";

const app = express();

app.use(express.json());

// POST request to create a new stash item
app.post("/api/stash", async (req, res) => {
  try {
    const { id, title, desc } = req.body;

    if (String(id).trim() === "") {
      throw new Error("ID cannot be null");
    }

    if (String(title).trim() === "") {
      throw new Error("Title cannot be null")
    }

    if (String(desc).trim() === "") {
      throw new Error("Description cannot be null")
    }

    const result = await runCobol(`ADD|${id}|${title}|${desc}`);

    res.status(200).send(resToJsonString(result));
  } catch (err) {
    if (err instanceof Error) {
      console.error(`Error: ${err.message}`);

      res.status(400).send(JSON.stringify({ error: `Invalid Request: ${err.message}` }))
    } else {
      console.error(`Unknown Error: ${err}`);
      res.status(500).send(JSON.stringify({ error: err }))
    }
  }
});

// GET request to fetch a specific stash item
app.get("/api/stash/:id", async (req, res) => {
  try {
    // Store the ID from the above API endpoint
    const id = req.params.id;

    // Run the backend to fetch the specified stash entry
    const result = await runCobol(`READ|${id}`);

    // Send the result to the frontend
    res.status(200).send(resToJsonString(result));
  } catch (err) {
    console.error(`Unknown Error: ${err}`);
    res.status(404).send(JSON.stringify({ error: "Stash entry not found"}));
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
