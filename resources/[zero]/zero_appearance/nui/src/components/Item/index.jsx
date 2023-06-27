import { useContext, useEffect, useState } from "react";

import * as S from "../GenericalStyles";
import { CiImageOff } from "react-icons/ci";
import AppearanceContext from "../../contexts/AppearanceContext";

function Item({ index, customizationType, handleClick }) {
  const { appearance } = useContext(AppearanceContext);
  const [imageError, setImageError] = useState(false);

  useEffect(() => {
    setImageError(false);
  }, [index, customizationType]);

  return (
    <S.OptionItem onClick={handleClick}>
      {!imageError ? (
        <S.OptionImage
          src={`http://localhost/zero_appearance/barbershop/${appearance.barbershop.sex}/${customizationType}/${index}.png`}
          onError={() => setImageError(true)}
        />
      ) : (
        <S.WrapBrokenImage>
          <CiImageOff />
        </S.WrapBrokenImage>
      )}
      <S.ItemWrapIcon>{index}</S.ItemWrapIcon>
    </S.OptionItem>
  );
}

export default Item;
