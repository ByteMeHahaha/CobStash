import { Route, Routes } from "react-router-dom";
import { Home } from "./pages/Home/Home";
import { NoPage } from "./pages/NoPage/NoPage";

export default function App() {
  return (
    <Routes>
      <Route index element={<Home />} />
      <Route path="*" element={<NoPage />} />
    </Routes>
  );
}
