import useRequest from "./hooks/useRequest";
import { ThemeProvider } from "styled-components";
import { useCallback, useEffect } from "react";
import * as GS from "./styles";
import Painel from "./components/Painel";

function App() {
  const { request } = useRequest();

  const nuiMessage = useCallback((event) => {
    const { action } = event.data;
    if (action === "open") {
      // teste
    }
  }, []);

  useEffect(() => {
    window.addEventListener("message", nuiMessage);
    window.onkeydown = async (data) => {
      if (data.keyCode == 27) {
        request("close");
      }
    };

    return () => {
      window.removeEventListener("message", nuiMessage);
    };
  }, [nuiMessage, request]);

  return (
    <ThemeProvider theme={GS.theme}>
      <GS.GlobalStyle />
      <GS.Wrap>
        <Painel />
      </GS.Wrap>
    </ThemeProvider>
  );
}

export default App;
