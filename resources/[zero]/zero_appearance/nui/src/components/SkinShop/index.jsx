import { useContext, useEffect, useRef, useState } from "react";
import * as S from "../GenericalStyles";
import Types from "./types.json";
import AppearanceContext from "../../contexts/AppearanceContext";
import { RiTShirt2Line } from "react-icons/ri";
import Header from "../Header";
import TypeList from "../TypeList";
import Footer from "../Footer";
import Customization from "../Customization";
import ItemList from "../ItemList";
import useResult from "../../hooks/useResult";
import VariationsContext from "../../contexts/VariationsContext";

function SkinShop() {
  const firstRender = useRef(true);
  const { appearance } = useContext(AppearanceContext);
  const { variations } = useContext(VariationsContext);
  const { calculateTotal, buyCustomizations } = useResult();

  const [customization, setCustomization] = useState(false);
  const [hasCustom, setHasCustom] = useState(false);
  const [labelType, setLabelType] = useState(
    Types[appearance.skinshop.sex][0].path
  );
  const [indexType, setIndexType] = useState(0);
  const [limit, setLimit] = useState(0);

  useEffect(() => {
    setLabelType(Types[appearance.skinshop.sex][0].path);
    setIndexType(0);
    setLimit(appearance.skinshop.drawables[0].amount);
  }, [appearance]);

  useEffect(() => {
    if (variations[labelType] - 1 === 0) {
      setCustomization(false);
      setHasCustom(false);
    } else {
      setHasCustom(true);
    }
  }, [labelType, variations]);

  const handleChangeType = (index, customLimit) => {
    firstRender.current = true;
    setLabelType(Types[appearance.skinshop.sex][index].path);
    setIndexType(index);
    setLimit(customLimit.amount);
  };

  return (
    <>
      <S.Container>
        <S.Content>
          <Header title="Roupas" icon={<RiTShirt2Line />} />
          <S.Shop>
            <TypeList
              indexType={indexType}
              handleChangeType={handleChangeType}
              types={Types[appearance.skinshop.sex]}
              shop={"skinshop"}
            />
            <S.RightWrap>
              <S.OptionsListWrap>
                <ItemList
                  shop={"skinshop"}
                  labelType={labelType}
                  limit={limit}
                  types={Types[appearance.skinshop.sex]}
                  indexType={indexType}
                />
              </S.OptionsListWrap>
            </S.RightWrap>
          </S.Shop>
          <Footer
            customization={customization}
            setCustomization={setCustomization}
            buyCustomizations={() => buyCustomizations("skin")}
            hasCustom={hasCustom}
            total={calculateTotal(Types[appearance.skinshop.sex])}
          />
        </S.Content>
      </S.Container>
      {customization && (
        <Customization
          indexType={indexType}
          labelType={labelType}
          types={Types[appearance.skinshop.sex]}
        />
      )}
    </>
  );
}

export default SkinShop;
