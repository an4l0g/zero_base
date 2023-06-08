import { useCallback, useContext, useEffect } from "react";
import Appearance from "./components/Appearance";
import Pov from "./components/Pov";
import { CharacterProvider } from "./contexts/CharacterContext";
import * as S from "./styles";
import CreationContext from "./contexts/CreationContext";

function App() {
  const { creation, setCreation } = useContext(CreationContext);

  const nuiMessage = useCallback(
    (event) => {
      const { action } = event.data;
      console.log("TESTE", action);

      if (action === "open") setCreation(true);
    },
    [setCreation]
  );

  useEffect(() => {
    window.addEventListener("message", nuiMessage);

    return () => {
      window.removeEventListener("message", nuiMessage);
    };
  }, [nuiMessage]);

  return (
    <>
      {creation && (
        <>
          <S.GlobalStyle />
          <CharacterProvider>
            <S.WrapCreation>
              <Appearance />
              <Pov />
            </S.WrapCreation>
          </CharacterProvider>
        </>
      )}
    </>
  );
}

export default App;
