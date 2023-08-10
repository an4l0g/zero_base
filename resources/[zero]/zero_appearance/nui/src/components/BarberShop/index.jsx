import { useContext, useEffect, useState, useCallback } from "react";
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

function BarberShop() {
  const { appearance } = useContext(AppearanceContext);
  const { calculateTotal, buyCustomizations } = useResult();

  const [customization, setCustomization] = useState(false);
  const [labelType, setLabelType] = useState(
    Types[appearance.barbershop.sex][0].path
  );
  const [indexType, setIndexType] = useState(0);
  const [limit, setLimit] = useState(0);

  useEffect(() => {
    if (appearance.barbershop) {
      setLabelType(Types[appearance.barbershop.sex][0].path);
      setIndexType(0);
      setLimit(
        appearance.barbershop.drawables[0][
          Types[appearance.barbershop.sex][0].path
        ]
      );
    }
  }, [appearance]);

  const handleChangeType = useCallback(
    (index) => {
      if (appearance.barbershop) {
        setLabelType(Types[appearance.barbershop.sex][index].path);
        setIndexType(index);
        setLimit(
          appearance.barbershop.drawables[index][
            Types[appearance.barbershop.sex][index].path
          ]
        );
      }
    },
    [appearance]
  );

  return (
    <>
      {appearance.barbershop && (
        <>
          <S.Container>
            <S.Content>
              <Header title="Barbearia" icon={<BsScissors />} />
              <S.Shop>
                <TypeList
                  indexType={indexType}
                  handleChangeType={handleChangeType}
                  types={Types[appearance.barbershop.sex]}
                  shop={"barbershop"}
                />
                <S.RightWrap>
                  <S.OptionsListWrap>
                    <ItemList
                      shop={"barbershop"}
                      labelType={labelType}
                      limit={limit}
                      types={Types[appearance.barbershop.sex]}
                      indexType={indexType}
                    />
                  </S.OptionsListWrap>
                </S.RightWrap>
              </S.Shop>
              <Footer
                customization={customization}
                setCustomization={setCustomization}
                hasCustom={true}
                buyCustomizations={() => buyCustomizations("barber")}
                total={calculateTotal(Types[appearance.barbershop.sex])}
              />
            </S.Content>
          </S.Container>
          {customization && (
            <Customization
              indexType={indexType}
              labelType={labelType}
              types={Types[appearance.barbershop.sex]}
            />
          )}
        </>
      )}
    </>
  );
}

export default BarberShop;
