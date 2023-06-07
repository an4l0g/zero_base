import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import BagsProvider from "./contexts/BagsContext";

ReactDOM.createRoot(document.getElementById("root")).render(
  <BagsProvider>
    <App />
  </BagsProvider>
);
