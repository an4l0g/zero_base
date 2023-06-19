import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App.jsx";
import { ThemeProvider } from "styled-components";
import { theme } from "./styles.js";
import { CreationProvider } from "./contexts/CreationContext.jsx";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <CreationProvider>
      <ThemeProvider theme={theme}>
        <App />
      </ThemeProvider>
    </CreationProvider>
  </React.StrictMode>
);
