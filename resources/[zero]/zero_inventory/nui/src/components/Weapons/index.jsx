import React, { useEffect, useMemo } from "react";
import * as S from "./styles";
import * as Inventory from "../Inventory/styles";
import Item from "../Item";
import useBags from "../../hooks/useBags";

function Weapons() {
  const { weapons } = useBags();
  const title = "Armamento";

  const generateSlots = useMemo(() => {
    const maxSlots = 14;
    let currentSlots = [];
    for (let i = 0; i < maxSlots; i++) {
      if (weapons[i]) {
        currentSlots = [...currentSlots, weapons[i]];
      } else {
        currentSlots = [...currentSlots, {}];
      }
    }

    return currentSlots;
  }, [weapons]);

  return (
    <>
      {weapons.length > 0 && (
        <S.Container>
          <Inventory.Head>
            <Inventory.HeadTitle>{title}</Inventory.HeadTitle>
            <Inventory.Line />
          </Inventory.Head>
          <S.WrapItems>
            {generateSlots.map((item, index) => (
              <Item
                bagType="weapons"
                key={`${title}${index}`}
                pos={index}
                data={item}
              />
            ))}
          </S.WrapItems>
        </S.Container>
      )}
    </>
  );
}

export default Weapons;
