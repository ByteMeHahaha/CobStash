export interface StashEntry {
  resCode: string;
  id?: number;
  title?: string;
  desc?: string;
  error?: string;
}

export class ApiHandler {
  public static async read(stashId: number): Promise<StashEntry> {
    const res = await fetch(`http://localhost:3000/api/stash/${stashId}`);

    if (!res.ok) {
      throw new Error(`API Request Failed: ${res.status}`)
    }

    return res.json();
  }
}
