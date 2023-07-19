import { ThemeProvider } from "styled-components";
import * as S from "./styles";
import BarberShop from "./components/BarberShop";
import { useCallback, useContext, useEffect } from "react";
import useRequest from "./hooks/useRequest";
import AppearanceContext from "./contexts/AppearanceContext";
import useBarbershop from "./hooks/useBarbershop";
import SkinShop from "./components/SkinShop";

function App() {
  const { request } = useRequest();
  const { appearance, setAppearance } = useContext(AppearanceContext);
  const { createResult } = useBarbershop();

  const nuiMessage = useCallback(
    (event) => {
      const { action, data } = event.data;
      console.log(data);
      if (action === "openBarberShop") {
        setAppearance({ barbershop: data });
        createResult(data.drawables);
      } else if (action === "openSkinShop") {
        setAppearance({ skinshop: data });
      }
    },
    [setAppearance, createResult]
  );

  useEffect(() => {
    window.addEventListener("message", nuiMessage);
    window.onkeydown = async (data) => {
      if (data.keyCode == 27) {
        setAppearance({});
        request("close");
      }
    };

    return () => {
      window.removeEventListener("message", nuiMessage);
    };
  }, [nuiMessage, request, setAppearance]);

  return (
    <ThemeProvider theme={S.theme}>
      <S.GlobalStyle />
      {appearance != {} && (
        <S.Wrap>
          {appearance.skinshop && (
            <>
              <SkinShop />
            </>
          )}
          {appearance.barbershop && <BarberShop />}
        </S.Wrap>
      )}
    </ThemeProvider>
  );
}

export default App;
