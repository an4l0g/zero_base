import { useCallback, useContext, useEffect } from "react";
import Dynamic from "./components/Dynamic";
import * as GS from "./styles";
import useRequest from "./hooks/useRequest";
import DynamicContext from "./contexts/DynamicContext";

function App() {
  const { dynamic, setDynamic } = useContext(DynamicContext);

  const { request } = useRequest();

  const nuiMessage = useCallback(
    (event) => {
      const { action } = event.data;
      1;
      if (action === "open") setDynamic(true);
    },
    [setDynamic]
  );

  useEffect(() => {
    window.addEventListener("message", nuiMessage);
    window.onkeydown = async (data) => {
      if (data.keyCode == 27) {
        setDynamic(false);
        await request("close");
      }
    };

    return () => {
      window.removeEventListener("message", nuiMessage);
    };
  }, [nuiMessage, request]);

  return (
    <>
      {dynamic && (
        <>
          <GS.GlobalStyle />
          <GS.Wrap>
            <Dynamic />
          </GS.Wrap>
        </>
      )}
    </>
  );
}

export default App;
