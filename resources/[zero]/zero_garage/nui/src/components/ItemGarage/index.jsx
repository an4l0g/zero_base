import { useState } from "react";
import * as S from "./styles";
import { FaCarSide, FaMotorcycle } from "react-icons/fa";

function ItemGarage({ item, setCar }) {
  const [imageError, setImageError] = useState(false);

  return (
    <S.CarItem key={item.name} onClick={() => setCar(item)}>
      {!imageError ? (
        <S.CarItemImage
          src={`http://localhost/zero_garage/${item.spawn}.png`}
          onError={() => setImageError(true)}
        />
      ) : (
        <>
          {item.type === "car" && <FaCarSide />}
          {item.type === "motocycle" && <FaMotorcycle />}
        </>
      )}

      <S.CarItemTitle>{item.name}</S.CarItemTitle>
      <S.CarItemSubtitle>{item.maker}</S.CarItemSubtitle>
    </S.CarItem>
  );
}

export default ItemGarage;
