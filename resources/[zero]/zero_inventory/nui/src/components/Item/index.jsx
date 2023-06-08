import React, { useCallback, useContext } from "react";
import { useDrag, useDrop } from "react-dnd";
import { ConfirmModalContext } from "../../contexts/ConfirmModalContext";
import useBags from "../../hooks/useBags";
import ContentItem from "./ContentItem";
import * as S from "./styles";

function Item({
  icon,
  bagType = "bag",
  pos = null,
  data = {},
  dropType,
  lootId = null,
}) {
  const {
    changeItemPosition,
    getDroppedItem,
    dropItem,
    dropTypes,
    bag,
    chest,
    hotbar,
    weapons,
  } = useBags();
  const { setConfirmModal } = useContext(ConfirmModalContext);

  const [{ canDrop }, dropRef] = useDrop(
    useCallback(() => ({
      accept: dropTypes(dropType),
      drop: () => ({
        pos,
        item: data.index
          ? { ...data, bagType: bagType, dropType: dropType }
          : { bagType: bagType, dropType: dropType },
      }),
      collect: (monitor) => ({
        isOver: monitor.isOver(),
        canDrop: monitor.canDrop(),
      }),
    })),
    [data, pos, bag, chest, hotbar, weapons]
  );

  const [{ isDragging }, dragRef] = useDrag(
    useCallback(() => ({
      type: data.type ?? "common",
      item: { ...data, bagType: bagType, dropType: dropType, lootId },
      end: (item, monitor) => {
        const dropper = monitor.getDropResult();
        if (item && dropper) {
          if (pos === dropper.pos && item.bagType === dropper.item.bagType)
            return;
          if (item.bagType === dropper.item.bagType) {
            if (item.bagType === "ground") return;
            changeItemPosition(item, pos, dropper.item, dropper.pos);
          } else {
            if (dropper.item.bagType === "ground" && item.bagType === "hotbar")
              return;
            if (
              dropper.item.bagType === "ground" &&
              item.bagType !== "hotbar"
            ) {
              setConfirmModal({
                item,
                pos,
                action: dropItem,
              });
              return;
            }

            if (item.bagType === "ground") {
              setConfirmModal({
                item,
                pos,
                action: getDroppedItem,
              });
              return;
            }
            changeItemPosition(item, pos, dropper.item, dropper.pos);
          }
        }
      },
      collect: (monitor) => ({
        isDragging: monitor.isDragging(),
        handlerId: monitor.getHandlerId(),
      }),
    })),
    [bag, chest, hotbar, weapons]
  );

  return (
    <>
      <S.Container>
        <S.Slot
          ref={dropRef}
          style={{
            backgroundColor: canDrop
              ? "rgba(255, 255, 255, 0.1)"
              : "rgba(255, 255, 255, 0.05)",
          }}
        >
          {!data.index && icon && icon}
          {data.index && (
            <ContentItem
              dragRef={bagType !== "weapons" ? dragRef : null}
              item={data}
              bagType={bagType}
              dropType={dropType}
            />
          )}
        </S.Slot>
      </S.Container>
    </>
  );
}

export default Item;
