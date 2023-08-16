import { useCallback, useContext, useEffect, useState } from "react";
import Appearance from "./components/Appearance";
import Pov from "./components/Pov";
import { CharacterProvider } from "./contexts/CharacterContext";
import * as S from "./styles";
import CreationContext from "./contexts/CreationContext";
import LamarScreen from "./components/LamarScreen";

function App() {
  const { creation, setCreation } = useContext(CreationContext);
  const [lamar, setLamar] = useState(false);

  const nuiMessage = useCallback(
    (event) => {
      const { action } = event.data;

      if (action === "open") setCreation(true);
      else if (action === "openLamar") setLamar(true);
      else if (action === "close") setCreation(false);
    },
    [setCreation, setLamar]
  );

  useEffect(() => {
    window.addEventListener("message", nuiMessage);

    return () => {
      window.removeEventListener("message", nuiMessage);
    };
  }, [nuiMessage]);

  return (
    <>
      <S.GlobalStyle />
      {lamar && <LamarScreen setLamar={setLamar} />}
      {creation && (
        <>
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
