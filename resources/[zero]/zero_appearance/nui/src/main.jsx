import ReactDOM from "react-dom/client";
import App from "./App.jsx";
import { AppearanceProvider } from "./contexts/AppearanceContext.jsx";
import { ResultProvider } from "./contexts/ResultContext.jsx";
import { CamProvider } from "./contexts/CamContext.jsx";

ReactDOM.createRoot(document.getElementById("root")).render(
  <AppearanceProvider>
    <CamProvider>
      <ResultProvider>
        <App />
      </ResultProvider>
    </CamProvider>
  </AppearanceProvider>
);
