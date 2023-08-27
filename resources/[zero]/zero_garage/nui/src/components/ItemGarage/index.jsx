import { useState } from "react";
import * as S from "./styles";
import { FaCarSide, FaMotorcycle } from "react-icons/fa";
import { RiVipDiamondLine } from "react-icons/ri";

function ItemGarage({ item, setCar }) {
  const [imageError, setImageError] = useState(false);

  return (
    <S.CarItem key={item.name} onClick={() => setCar(item)}>
      {!imageError ? (
        <S.CarItemImage
          src={`http://104.234.189.131/zero_garage/${item.spawn}.png`}
          loading="lazy"
          onError={() => setImageError(true)}
        />
      ) : (
        <>
          {item.type === "car" && <FaCarSide />}
          {item.type === "motocycle" && <FaMotorcycle />}
          {item.type === "vip" && <RiVipDiamondLine />}
        </>
      )}

      <S.CarItemTitle>{item.name}</S.CarItemTitle>
      <S.CarItemSubtitle>{item.maker}</S.CarItemSubtitle>
      <S.CategoryItem>
        {item.type === "car" && <FaCarSide />}
        {item.type === "motocycle" && <FaMotorcycle />}
        {item.type === "vip" && <RiVipDiamondLine />}
      </S.CategoryItem>
    </S.CarItem>
  );
}

export default ItemGarage;
