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
      const { action, favorites, status } = event.data;
      if (action === "open") {
        setDynamic({
          favorites,
          status,
        });
      }
    },
    [setDynamic]
  );

  useEffect(() => {
    window.addEventListener("message", nuiMessage);
    window.onkeydown = async (data) => {
      if (data.keyCode == 27) {
        setDynamic({});
        request("close");
      }
    };

    return () => {
      window.removeEventListener("message", nuiMessage);
    };
  }, [nuiMessage, request, setDynamic]);

  return (
    <>
      {dynamic.status && (
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
