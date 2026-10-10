import express from "express";
import { runCobol } from "./cobol";
import { resToJsonString } from "./resToJsonString";

const app = express();
app.use(express.json());

// POST request to create a new stash item
app.post("/api/stash", async (req, res) => {
  try {
    // Extract the response parts from the request body
    const { id, title, desc } = req.body;

    // If the ID is empty
    if (String(id).trim() === "") {
      throw new Error("ID cannot be null");
    }

    // If the title is empty
    if (String(title).trim() === "") {
      throw new Error("Title cannot be null")
    }

    // If the description is empty
    if (String(desc).trim() === "") {
      throw new Error("Description cannot be null")
    }

    // Send a create request to the backend
    const result = await runCobol(`ADD|${id}|${title}|${desc}`);

    // If the request was not successful
    if (!result.startsWith("OK")) {
      throw new Error(result.split("|", 2)[1]);
    }

    // Send the result as a JSON object
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

    // If the request was not successful
    if (!result.startsWith("OK")) {
      throw new Error(result.split("|", 2)[1]);
    }

    // Send the result to the frontend
    res.status(200).send(resToJsonString(result));
  } catch (err) {
    console.error(`Unknown Error: ${err}`);
    res.status(404).send(JSON.stringify({ error: "Stash entry not found"}));
  }
});

// PUT Request to update a stash item
app.put("/api/stash/:id", async (req, res) => {
  try {
    // Extract the ID from the API route
    const id = req.params.id;
    // Extract the title and description from the request body
    const { title, desc } = req.body;

    // If the title is empty
    if (String(title).trim() === "") {
      throw new Error("Title cannot be null");
    }

    // If the description is empty
    if (String(desc).trim() === "") {
      throw new Error("Description cannot be null");
    }

    // Run the backend with the update request
    const result = await runCobol(`UPD|${id}|${title}|${desc}`);

    // If the request was not successful
    if (!result.startsWith("OK")) {
      // Extract the backend's error message and throw it as an error
      throw new Error(result.split("|", 2)[1]);
    }

    // Send the backend response as a JSON object
    res.status(200).send(resToJsonString(result));
  } catch (err) {
    if (err instanceof Error) {
      console.error(`Error: ${err}`);
      res.status(400).send(JSON.stringify({ error: err }));
    } else {
      console.error(`Unknown error: ${err}`);
      res.status(500).send(JSON.stringify({ error: err }));
    }
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
