import React, { useEffect, useMemo } from "react";
import Item from "../Item";
import * as S from "./styles";
import * as Inventory from "../Inventory/styles";
import useBags from "../../hooks/useBags";

function Bag({
  bagType,
  title,
  slotsAmount,
  slots,
  capacity = 0,
  dropType,
  lootId = null,
}) {
  const { hotbar, getCurrentType } = useBags();

  const generateWeight = useMemo(() => {
    let currentSlots = slots;

    if (bagType.includes("bag")) {
      currentSlots = [...Object.values(slots), ...Object.values(hotbar.slots)];
    } else {
      currentSlots = Object.values(slots);
    }

    if (currentSlots !== undefined) {
      let totalWeight = 0;
      currentSlots.map((item) => {
        if (item !== null) totalWeight += item.weight * item.amount;
      });

      return totalWeight.toFixed(1);
    }
    return 0;
  }, [slots, hotbar]);

  const generateSlots = useMemo(() => {
    let currentSlots = [];
    if (slots !== undefined) {
      for (let i = 0; i < slotsAmount; i++) {
        const currentItem = slots[i];
        if (currentItem !== null) {
          currentSlots = [...currentSlots, currentItem];
        } else {
          currentSlots = [...currentSlots, {}];
        }
      }
    } else {
      for (let i = 0; i < slotsAmount; i++) {
        currentSlots = [...currentSlots, {}];
      }
    }

    return currentSlots;
  }, [slots]);

  const isRenderedBag = useMemo(() => {
    return (
      dropType === "ground" ||
      dropType === "bag" ||
      dropType === "player" ||
      dropType === "chest" ||
      +capacity > 0
    );
  }, [capacity, bagType]);

  return (
    <>
      {isRenderedBag && (
        <S.Container>
          <Inventory.Head>
            <Inventory.HeadTitle>{title}</Inventory.HeadTitle>
            <Inventory.Line />
            {bagType !== "ground" && capacity !== 0 && (
              <Inventory.Kg>
                {generateWeight}/{capacity}KG
              </Inventory.Kg>
            )}
          </Inventory.Head>
          <S.WrapItems className={getCurrentType(bagType)}>
            {generateSlots.map((item, index) => (
              <Item
                key={`${title}${index}`}
                pos={index}
                data={item}
                bagType={bagType}
                dropType={dropType}
                lootId={lootId}
              />
            ))}
          </S.WrapItems>
        </S.Container>
      )}
    </>
  );
}

export default Bag;
