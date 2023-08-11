import { useContext, useEffect, useRef, useState } from "react";
import * as S from "../GenericalStyles";
import Types from "./types.json";
import AppearanceContext from "../../contexts/AppearanceContext";
import Header from "../Header";
import TypeList from "../TypeList";
import Footer from "../Footer";
import Customization from "../Customization";
import ItemList from "../ItemList";
import { RiMarkPenLine } from "react-icons/ri";
import useResult from "../../hooks/useResult";

function TattooShop() {
  const firstRender = useRef(true);
  const { appearance } = useContext(AppearanceContext);
  const { calculateTotal, buyCustomizations } = useResult();

  const [customization, setCustomization] = useState(false);
  const [labelType, setLabelType] = useState(
    Types[appearance.tattooshop.sex][0].path
  );
  const [indexType, setIndexType] = useState(0);
  const [limit, setLimit] = useState(0);

  useEffect(() => {
    setLabelType(Types[appearance.tattooshop.sex][0].path);
    setIndexType(0);
    setLimit(appearance.tattooshop.drawables[0].part.length);
  }, [appearance]);

  const handleChangeType = (index) => {
    firstRender.current = true;
    setLabelType(Types[appearance.tattooshop.sex][index].path);
    setIndexType(index);
    setLimit(appearance.tattooshop.drawables[index].part.length);
  };

  return (
    <>
      {appearance.tattooshop && (
        <>
          <S.Container>
            <S.Content>
              <Header title="Tattoo" icon={<RiMarkPenLine />} />
              <S.Shop>
                <TypeList
                  indexType={indexType}
                  handleChangeType={handleChangeType}
                  types={Types[appearance.tattooshop.sex]}
                  shop={"tattooshop"}
                />
                <S.RightWrap>
                  <S.OptionsListWrap>
                    <ItemList
                      shop={"tattooshop"}
                      labelType={labelType}
                      limit={limit}
                      types={Types[appearance.tattooshop.sex]}
                      indexType={indexType}
                    />
                  </S.OptionsListWrap>
                </S.RightWrap>
              </S.Shop>
              <Footer
                customization={customization}
                setCustomization={setCustomization}
                buyCustomizations={() => buyCustomizations("tattoo")}
                total={calculateTotal(Types[appearance.tattooshop.sex])}
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
