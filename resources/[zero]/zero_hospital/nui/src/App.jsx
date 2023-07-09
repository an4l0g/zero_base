import useRequest from "./hooks/useRequest";
import { ThemeProvider } from "styled-components";
import { useCallback, useContext, useEffect } from "react";
import * as GS from "./styles";
import Painel from "./components/Painel";
import PainelContext from "./contexts/PainelContext";

function App() {
  const { painel, setPainel } = useContext(PainelContext);
  const { request } = useRequest();

  const nuiMessage = useCallback(
    (event) => {
      const {
        action,
        pendingServicesAmount,
        dayServices,
        currentService,
        prices,
      } = event.data;
      if (action === "open") {
        setPainel({
          open: true,
          pendingServicesAmount,
          dayServices,
          currentService,
          prices,
        });
      }
    },
    [setPainel]
  );

  useEffect(() => {
    window.addEventListener("message", nuiMessage);
    window.onkeydown = async (data) => {
      if (data.keyCode == 27) {
        request("close");
        setPainel({});
      }
    };

    return () => {
      window.removeEventListener("message", nuiMessage);
    };
  }, [nuiMessage, request, setPainel]);

  return (
    <ThemeProvider theme={GS.theme}>
      <GS.GlobalStyle />
      <GS.Wrap>{painel.open && <Painel />}</GS.Wrap>
    </ThemeProvider>
  );
}

export default App;
