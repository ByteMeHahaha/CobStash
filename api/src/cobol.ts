import { spawn } from "node:child_process";

export async function runCobol(command: string): Promise<string> {
  return new Promise((resolve, reject) => {
    const cbl = spawn("../backend/bin/CobStash", [command], {
      cwd: "../backend",
      stdio: ["pipe", "pipe", "pipe"]
    });

    let output = "";
    let err = "";

    cbl.stdout.on("data", (data) => {
      output += data.toString();
    });

    cbl.stderr.on("data", (data) => {
      err += data.toString();
    });

    cbl.on("close", (exitCode) => {
      if (exitCode !== 0) {
        reject(new Error(err || `COBOL exited with code ${exitCode}`));
        return;
      }

      resolve(output);
    });
  });
}
