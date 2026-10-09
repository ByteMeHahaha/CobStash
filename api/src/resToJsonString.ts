type splitResObject = {
  resCode: string,
  id: number,
  title?: string,
  desc?: string
};

export function resToJsonString(response: string): string {
  // Parse the response into its parts
  const responseParts: string[] = response.split("|");

  const result: splitResObject = {
    resCode: responseParts[0],
    id: Number(responseParts[1]),
    title: responseParts[2] || "",
    desc: responseParts[3] || ""
  };

  return JSON.stringify(result);
}
