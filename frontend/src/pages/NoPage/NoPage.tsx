import { Link } from "react-router-dom";
import { Page } from "../../components/Page/Page";

export function NoPage() {
  return (
    <Page headerText="Page Not Found">
      <Link to="/">Go Home</Link>
    </Page>
  );
}
