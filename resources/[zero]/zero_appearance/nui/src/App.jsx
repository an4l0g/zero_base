import { ThemeProvider } from "styled-components";
import * as S from "./styles";
import BarberShop from "./components/BarberShop";
import { useCallback, useContext, useEffect } from "react";
import useRequest from "./hooks/useRequest";
import AppearanceContext from "./contexts/AppearanceContext";

function App() {
  const { request } = useRequest();
  const { appearance, setAppearance } = useContext(AppearanceContext);

  const nuiMessage = useCallback(
    (event) => {
      const { action, data } = event.data;
      if (action === "openBarberShop") {
        setAppearance({ barbershop: data });
      }
    },
    [setAppearance]
  );

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
    <ThemeProvider theme={S.theme}>
      <S.GlobalStyle />
      {appearance !== {} && (
        <S.Wrap>
          <BarberShop />
        </S.Wrap>
      )}
    </ThemeProvider>
  );
}

export default App;
