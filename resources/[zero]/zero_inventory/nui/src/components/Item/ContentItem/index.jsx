import React, { useEffect } from "react";
import { useCallback } from "react";
import { useState } from "react";
import Dropdown from "../Dropdown";
import * as S from "../styles";
import { FiX, FiRefreshCw } from "react-icons/fi";
import useBags from "../../../hooks/useBags";

function ContentItem({
  item,
  bagType,
  isPreview = false,
  dragRef = null,
  dropType,
  ...rest
}) {
  const [hasClicked, setHasClicked] = useState(false);
  const { handleUnequipWeapon, chest } = useBags();
  const [showDropdown, setShowDropdown] = useState(false);
  const [posX, setPosX] = useState(0);
  const [posY, setPosY] = useState(0);

  useEffect(() => {
    setHasClicked(false);
  }, [item, chest]);

  const handleContextMenu = useCallback(
    (e) => {
      if (!showDropdown) {
        e.preventDefault();
        setPosX(e.clientX);
        setPosY(e.clientY);
        setShowDropdown(true);
      }
    },
    [showDropdown]
  );

  return (
    <S.ContentItem
      className={isPreview ? "item-list__item" : ""}
      isPreview={isPreview}
      draggable={true}
      ref={dragRef}
      onContextMenu={(e) => {
        handleContextMenu(e);
      }}
      {...rest}
    >
      <S.ItemImage
        src={`http://189.127.164.170/items/${item.index.toLowerCase()}.png`}
      />
      {bagType !== "weapons" && (
        <>
          <S.ItemWeight>
            {(item.amount * item.weight).toFixed(1)}Kg
          </S.ItemWeight>
          <S.ItemAmount>{`${item.amount}x`}</S.ItemAmount>
        </>
      )}
      {bagType === "weapons" && !hasClicked && (
        <>
          <S.ItemAmount>{+item.ammo > 0 && `${item.ammo}x`}</S.ItemAmount>
          <S.BtnUnequip
            onClick={() => {
              setHasClicked(true);
              handleUnequipWeapon(item.index);
            }}
            className="onHoverAppears"
          >
            <FiX />
          </S.BtnUnequip>
        </>
      )}
      {hasClicked && (
        <S.Loading>
          <FiRefreshCw />
        </S.Loading>
      )}
      <S.ItemName>
        {item.name.length > 10 ? item.name.substr(0, 7) + "..." : item.name}
      </S.ItemName>
      {showDropdown && dropType === "bag" && chest.drop_type === "ground" && (
        <Dropdown
          closeDropdown={() => setShowDropdown(false)}
          posX={posX}
          posY={posY}
          item={item}
        />
      )}
    </S.ContentItem>
  );
}

export default ContentItem;
