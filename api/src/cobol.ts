import { spawn } from "node:child_process";

export async function runCobol(command: string): Promise<string> {
  return new Promise((resolve, reject) => {
    // Spawn the backend as a child process
    const cbl = spawn("../backend/bin/CobStash", [command /* CLI Args */], {
      cwd: "../backend", // Change current working directory to the backend folder
      stdio: ["ignore", "pipe", "pipe"] // ignore stdin and pipe stdout and stderr
    });

    // Declare variables for standard output and error output
    let output = "";
    let err = "";

    // When stdout is received from the child process
    cbl.stdout.on("data", (data) => {
      // Append the output from CobStash's backend
      output += data.toString();
    });

    // When stderr is received from the child process
    cbl.stderr.on("data", (data) => {
      // Append stderr from CobStash's backend
      err += data.toString();
    });

    // When the app finishes running
    cbl.on("close", (exitCode) => {
      console.log("CobStash backend exit code:", exitCode);
      console.log("CobStash backend stdout:", JSON.stringify(output), '\n');

      // If the run fails
      if (exitCode !== 0) {
        // Display error output and exit
        reject(new Error(err || `CobStash backend exited with code ${exitCode}`));
        return;
      }

      // Display output via stdout
      resolve(output);
    });
  });
}
