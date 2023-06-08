import { useState, useContext, useEffect } from "react";
import { ThemeProvider } from "styled-components";
import GlobalStyle from "./styles";
import theme from "./styles/theme";
import * as S from "./styles/scomponents";
import Inventory from "./components/Inventory";
import { BsMouse } from "react-icons/bs";
import { BagsContext } from "./contexts/BagsContext";
import { DndProvider } from "react-dnd";
import { TouchBackend } from "react-dnd-touch-backend";
import ConfirmModal from "./components/ConfirmModal";
import ConfirmModalProvider from "./contexts/ConfirmModalContext";
import useRequest from "./hooks/useRequest";

function App() {
  const [showInventory, setShowInventory] = useState();
  const { setBags } = useContext(BagsContext);
  const { request } = useRequest();

  useEffect(() => {
    const action = (e) => {
      const { action, bag, chest, hotbar, item_types, weapons } = e.data;
      if (action === "open" || action === "update") {
        setBags((oldBags) => ({
          ...oldBags,
          bag,
          chest,
          weapons,
          hotbar,
          item_types,
        }));

        if (action === "open") {
          setShowInventory(true);
        }
      } else if (action === "close") {
        setShowInventory(false);
      }
    };

    window.addEventListener("message", action);
    window.onkeydown = async (data) => {
      if (data.keyCode == 27) {
        setShowInventory(false);
        await request("closeInventory");
      }
    };
  }, []);

  const close = async () => {
    setShowInventory(false);
    await request("closeInventory");
  };

  return (
    <>
      {showInventory && (
        <ConfirmModalProvider>
          <ThemeProvider theme={theme}>
            <DndProvider
              backend={TouchBackend}
              options={{
                enableMouseEvents: true,
              }}
            >
              <GlobalStyle />
              <ConfirmModal />
              <S.Page>
                <S.BgImage />
                <S.Filter>
                  <S.HeadInventory>
                    <S.HeadInventoryTitle>Inventário</S.HeadInventoryTitle>
                    <S.HeadInventoryDescription>
                      Para fechar a mochila, utilize <S.Key>Esc</S.Key>
                    </S.HeadInventoryDescription>
                    <S.HeadInventoryDescription>
                      Para interagir com seus itens, utize{" "}
                      <S.Key>
                        <BsMouse /> Botâo Direito
                      </S.Key>
                    </S.HeadInventoryDescription>
                  </S.HeadInventory>
                  <Inventory />
                </S.Filter>
              </S.Page>
            </DndProvider>
          </ThemeProvider>
        </ConfirmModalProvider>
      )}
    </>
  );
}

export default App;
