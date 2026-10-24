import { Route, Routes } from "react-router-dom";
import { Home } from "./pages/Home/Home";
import { NoPage } from "./pages/NoPage/NoPage";

export default function App() {
  return (
    <Routes>
      {/* The home page */}
      <Route index element={<Home />} />
      {/* 404 Page */}
      <Route path="*" element={<NoPage />} />
    </Routes>
  );
}
