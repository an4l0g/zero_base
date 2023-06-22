import { useCallback, useContext, useEffect, useState } from "react";
import Production from "./components/Production";
import * as S from "./styles";
import useRequest from "./hooks/useRequest";
import ProductionContext from "./contexts/ProductionContext";

function App() {
  const { production, setProduction } = useContext(ProductionContext);
  const { request } = useRequest();

  const nuiMessage = useCallback((event) => {
    const { action, products, title, type } = event.data;
    console.log(event.data);
    if (action === "open") {
      setProduction({
        title,
        products,
        type,
      });
    }
  }, []);

  useEffect(() => {
    window.addEventListener("message", nuiMessage);
    window.onkeydown = async (data) => {
      if (data.keyCode == 27) {
        setProduction({});
        request("close");
      }
    };

    return () => {
      window.removeEventListener("message", nuiMessage);
    };
  }, [nuiMessage, request]);

  return (
    <>
      <S.GlobalStyle />
      {production.title && (
        <S.Wrap>
          <Production data={production} />
        </S.Wrap>
      )}
    </>
  );
}

export default App;
