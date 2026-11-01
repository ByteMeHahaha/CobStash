import { useEffect, useState } from "react";
import { Page } from "../../components/Page/Page";
import { ApiHandler, type StashEntry } from "../../services/ApiHandler";

export function Home() {
  const [entry, setEntry] = useState<StashEntry | null>(null);

  useEffect(() => {
    (async function fetchEntry() {
      try {
        const result = await ApiHandler.read(0);
        setEntry(result);
      } catch (error) {
        console.error("Failed to fetch stash entry:", error);
        setEntry({ resCode: "ERR", error: `${error} ` });
      }
    })();
  }, []);

  return (
    <Page headerText="Welcome to CobStash">
      {entry && (
        <div>
          <p>Response Code: {entry.resCode}</p>
          {entry.id && <p>ID: {entry.id}</p>}
          {entry.title && <p>Title: {entry.title}</p>}
          {entry.desc && <p>Description: {entry.desc}</p>}
          {entry.error && <p>Error message: {entry.error}</p>}
        </div>
      )}
    </Page>
  );
}
