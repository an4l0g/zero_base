import { useCallback, useEffect, useState } from "react";
import useRequest from "./hooks/useRequest";
import * as S from "./styles";
import { ThemeProvider } from "styled-components";
import Item from "./components/Item";

function App() {
  const [spawns, setSpawns] = useState({});
  const { request } = useRequest();

  const nuiMessage = useCallback(
    (event) => {
      const { action, listSpawns } = event.data;
      if (action === "open") {
        console.log(listSpawns);
        setSpawns(listSpawns);
      }
    },
    [setSpawns]
  );

  useEffect(() => {
    window.addEventListener("message", nuiMessage);
    window.onkeydown = async (data) => {
      if (data.keyCode == 27) {
        setSpawns({});
        request("close");
      }
    };

    return () => {
      window.removeEventListener("message", nuiMessage);
    };
  }, [nuiMessage, request, setSpawns]);

  const handleSetSpawn = (index) => {
    request("setSpawn", {
      index,
    });
    setSpawns({});
  };

  return (
    <>
      {Object.keys(spawns).length > 0 && (
        <ThemeProvider theme={S.theme}>
          <S.GlobalStyle />
          <S.Wrap>
            <S.Background>
              <S.Logo src="https://media.discordapp.net/attachments/1059878373737893918/1125947172165255178/zero_small.png?width=988&height=346" />
            </S.Background>
            <S.Filter>
              <S.Title>Escolha uma localização:</S.Title>
              <S.List>
                {Object.keys(spawns).map((item) => (
                  <Item
                    key={item}
                    data={spawns[item] ?? {}}
                    onClick={() => handleSetSpawn(item)}
                  />
                ))}
              </S.List>
              <S.ActionList>
                <S.Button onClick={() => handleSetSpawn("lastLocation")}>
                  Última localização
                </S.Button>
              </S.ActionList>
            </S.Filter>
          </S.Wrap>
        </ThemeProvider>
      )}
    </>
  );
}

export default App;
