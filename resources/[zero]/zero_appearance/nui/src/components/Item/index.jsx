import { useContext, useEffect, useState } from "react";

import * as S from "../GenericalStyles";
import { CiImageOff } from "react-icons/ci";
import AppearanceContext from "../../contexts/AppearanceContext";

function Item({ shop, index, className, labelType, handleClick }) {
  const { appearance } = useContext(AppearanceContext);
  const [imageError, setImageError] = useState(false);

  useEffect(() => {
    setImageError(false);
  }, [index, labelType]);

  return (
    <S.OptionItem onClick={handleClick} className={className}>
      {!imageError ? (
        <S.OptionImage
          src={`http://189.0.88.222/zero_appearance/${shop}/${appearance[shop].sex}/${labelType}/${index}.png`}
          onError={() => setImageError(true)}
        />
      ) : (
        <S.WrapBrokenImage>
          <CiImageOff />
        </S.WrapBrokenImage>
      )}
      <S.ItemWrapIcon>{index}</S.ItemWrapIcon>
      <S.ItemWrapMoney>R$ 5000</S.ItemWrapMoney>
    </S.OptionItem>
  );
}

export default Item;
