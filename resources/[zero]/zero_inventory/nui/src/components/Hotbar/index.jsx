import React, { useMemo } from "react";
import Item from "../Item";
import * as S from "./styles";
import useBags from "../../hooks/useBags";

function Hotbar() {
  const { hotbar } = useBags();
  const title = "Pochete";

  const generateSlots = useMemo(() => {
    const maxSlots = 5;
    let currentSlots = [];
    if (hotbar.slots) {
      for (let i = 0; i < maxSlots; i++) {
        const currentItem = hotbar.slots[i];
        if (currentItem !== null) {
          currentSlots = [...currentSlots, currentItem];
        } else {
          currentSlots = [...currentSlots, {}];
        }
      }
    }
    return currentSlots;
  }, [hotbar]);

  return (
    <S.Container>
      <S.Items>
        {generateSlots.map((item, index) => (
          <Item
            icon={index + 1}
            key={`${title}${index}`}
            pos={index}
            data={item}
            bagType={hotbar.bag_type}
            dropType={hotbar.drop_type}
          />
        ))}
      </S.Items>
    </S.Container>
  );
}

export default Hotbar;
