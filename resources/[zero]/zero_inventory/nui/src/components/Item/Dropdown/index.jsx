import React, { useCallback, useContext } from "react";
import * as S from "./styles";
import { FiCornerUpRight, FiSend, FiTrash2 } from "react-icons/fi";
import { ConfirmModalContext } from "../../../contexts/ConfirmModalContext";
import useRequest from "../../../hooks/useRequest";
import useBags from "../../../hooks/useBags";

function Dropdown({ item, posX, posY, closeDropdown }) {
  const { setConfirmModal } = useContext(ConfirmModalContext);
  const { request } = useRequest();
  const { dropItem } = useBags();

  const handleUseItem = useCallback(async () => {
    closeDropdown();
    if (item.type === "common" || item.type === "weapon") {
      request("useItem", {
        item: item.index,
      });
    } else {
      setConfirmModal({
        item,
        pos: "_",
        action: (item, pos, amount) => {
          request("useItem", {
            item: item.index,
            amount: amount,
          });
        },
      });
    }
  }, [item]);

  const handleSendItem = useCallback(() => {
    setConfirmModal({
      item,
      pos: "",
      action: (item, pos, amount) => {
        request("sendItem", {
          item: item.index,
          amount: amount,
        });
      },
    });
    closeDropdown();
  }, [item]);

  const handleDropItem = useCallback(() => {
    setConfirmModal({
      item,
      action: dropItem,
    });
    closeDropdown();
  }, [item]);

  const labels = {
    common: "Usar",
    clothes: "Usar",
    weapon: "Equipar",
    wammo: "Equipar",
    food: "Consumir",
    drink: "Consumir",
    drug: "Consumir",
  };

  return (
    <>
      <S.Backdrop onClick={closeDropdown} />
      <S.Container posX={posX} posY={posY}>
        {(item.usable || item.type === "weapon" || item.type === "wammo") && (
          <S.Option onClick={handleUseItem}>
            <FiCornerUpRight />
            {labels[item.type]}
          </S.Option>
        )}
        <S.Option onClick={handleSendItem}>
          <FiSend />
          Enviar
        </S.Option>
        <S.Option onClick={handleDropItem}>
          <FiTrash2 /> Largar
        </S.Option>
      </S.Container>
    </>
  );
}

export default Dropdown;
