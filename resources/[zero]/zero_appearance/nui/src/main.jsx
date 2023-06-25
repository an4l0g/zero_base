import ReactDOM from "react-dom/client";
import App from "./App.jsx";
import { AppearanceProvider } from "./contexts/AppearanceContext.jsx";

ReactDOM.createRoot(document.getElementById("root")).render(
  <AppearanceProvider>
    <App />
  </AppearanceProvider>
);
