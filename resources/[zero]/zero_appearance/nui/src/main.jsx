import ReactDOM from "react-dom/client";
import App from "./App.jsx";
import { AppearanceProvider } from "./contexts/AppearanceContext.jsx";
import { ResultProvider } from "./contexts/ResultContext.jsx";

ReactDOM.createRoot(document.getElementById("root")).render(
  <AppearanceProvider>
    <ResultProvider>
      <App />
    </ResultProvider>
  </AppearanceProvider>
);
