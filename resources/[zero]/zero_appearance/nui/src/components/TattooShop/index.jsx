import { useContext, useEffect, useRef, useState } from "react";
import * as S from "../GenericalStyles";
import Types from "./types.json";
import AppearanceContext from "../../contexts/AppearanceContext";
import Header from "../Header";
import TypeList from "../TypeList";
import Footer from "../Footer";
import Customization from "../Customization";
import ItemList from "../ItemList";
import { BsScissors } from "react-icons/bs";
import useResult from "../../hooks/useResult";

function TattooShop() {
  const firstRender = useRef(true);
  const { appearance } = useContext(AppearanceContext);
  const { calculateTotal, buyCustomizations } = useResult();

  const [customization, setCustomization] = useState(false);
  const [labelType, setLabelType] = useState(Types[0].path);
  const [indexType, setIndexType] = useState(0);
  const [limit, setLimit] = useState(0);

  useEffect(() => {
    setLabelType(Types[0].path);
    setIndexType(0);
    setLimit(appearance.tattooshop.drawables[0].part.length);
  }, [appearance]);

  const handleChangeType = (index) => {
    firstRender.current = true;
    setLabelType(Types[index].path);
    setIndexType(index);
    setLimit(appearance.tattooshop.drawables[index].part.length);
  };

  return (
    <>
      {appearance.tattooshop && (
        <>
          <S.Container>
            <S.Content>
              <Header title="Tattoo" icon={<BsScissors />} />
              <S.Shop>
                <TypeList
                  indexType={indexType}
                  handleChangeType={handleChangeType}
                  types={Types}
                  shop={"tattooshop"}
                />
                <S.RightWrap>
                  <S.OptionsListWrap>
                    <ItemList
                      shop={"tattooshop"}
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
                buyCustomizations={() => buyCustomizations("tattoo")}
                total={calculateTotal(Types)}
              />
            </S.Content>
          </S.Container>
          {customization && (
            <Customization
              indexType={indexType}
              labelType={labelType}
              types={Types}
            />
          )}
        </>
      )}
    </>
  );
}

export default TattooShop;
