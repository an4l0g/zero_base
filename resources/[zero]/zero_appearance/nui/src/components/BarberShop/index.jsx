import { useContext, useEffect, useRef, useState } from "react";
import * as S from "../GenericalStyles";
import Types from "./types.json";
import AppearanceContext from "../../contexts/AppearanceContext";
import useBarbershop from "../../hooks/useBarbershop";
import Header from "../Header";
import TypeList from "../TypeList";
import Footer from "../Footer";
import Customization from "../Customization";
import ItemList from "../ItemList";

function BarberShop() {
  const firstRender = useRef(true);
  const { appearance } = useContext(AppearanceContext);
  const { calculateTotal, buyCustomizations } = useBarbershop();

  const [customization, setCustomization] = useState(false);
  const [labelType, setLabelType] = useState(Types[0].path);
  const [indexType, setIndexType] = useState(0);
  const [limit, setLimit] = useState(0);

  useEffect(() => {
    setLabelType(Types[0].path);
    setIndexType(0);
    setLimit(appearance.barbershop.drawables[0][Types[0].path]);
  }, [appearance]);

  const handleChangeType = (index, customLimit) => {
    firstRender.current = true;
    setLabelType(Types[index].path);
    setIndexType(index);
    setLimit(customLimit);
  };

  return (
    <>
      {appearance.barbershop && (
        <>
          <S.Container>
            <S.Content>
              <Header title="Barbearia" />
              <S.Shop>
                <TypeList
                  indexType={indexType}
                  handleChangeType={handleChangeType}
                  types={Types}
                />
                <S.RightWrap>
                  <S.OptionsListWrap>
                    <ItemList
                      labelType={labelType}
                      limit={limit}
                      types={Types}
                      indexType={indexType}
                    />
                  </S.OptionsListWrap>
                </S.RightWrap>
              </S.Shop>
              <Footer
                customization={customization}
                setCustomization={setCustomization}
                buyCustomizations={buyCustomizations}
                total={calculateTotal}
              />
            </S.Content>
          </S.Container>
          <Customization
            showCustomization={customization}
            indexType={indexType}
            labelType={labelType}
            types={Types}
          />
        </>
      )}
    </>
  );
}

export default BarberShop;
