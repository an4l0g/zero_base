import { ThemeProvider } from "styled-components";
import * as S from "./styles";
import { useCallback, useContext, useEffect } from "react";
import useRequest from "./hooks/useRequest";
import AppearanceContext from "./contexts/AppearanceContext";
import BarberShop from "./components/BarberShop";
import TattooShop from "./components/TattooShop";
import SkinShop from "./components/SkinShop";
import useResult from "./hooks/useResult";
import VariationsContext from "./contexts/VariationsContext";

function App() {
  const { request } = useRequest();
  const { appearance, setAppearance } = useContext(AppearanceContext);
  const { setVariations } = useContext(VariationsContext);
  const { createResult } = useResult();

  const nuiMessage = useCallback(
    (event) => {
      const { action, data } = event.data;
      if (action === "openBarberShop") {
        setAppearance({ barbershop: data });
        createResult("barber", data.sex, data.drawables);
      } else if (action === "openSkinShop") {
        setAppearance({ skinshop: data });
        createResult("skin", data.sex, data.drawables);
      } else if (action === "openTattooShop") {
        setAppearance({ tattooshop: data });
        createResult("tattoo", data.sex, data.drawables);
      } else if (action === "setVariations") {
        setVariations(data);
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
  }, [nuiMessage, request, setAppearance, setVariations]);

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
          {appearance.tattooshop && <TattooShop />}
        </S.Wrap>
      )}
    </ThemeProvider>
  );
}

export default App;
