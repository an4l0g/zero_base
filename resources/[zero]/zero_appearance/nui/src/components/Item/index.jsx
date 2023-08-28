import React, { useCallback, useContext, useEffect, useState } from "react";

import * as S from "../GenericalStyles";
import { CiImageOff } from "react-icons/ci";
import AppearanceContext from "../../contexts/AppearanceContext";

const Item = React.forwardRef(
  (
    { shop, index, className, labelType, handleClick, tattooImage = null },
    ref
  ) => {
    const { appearance } = useContext(AppearanceContext);
    const [imageError, setImageError] = useState(false);

    useEffect(() => {
      setImageError(false);
    }, [index, labelType]);

    const renderImage = useCallback(() => {
      if (shop === "tattooshop") {
        return (
          <S.OptionImage
            loading="lazy"
            src={`http://104.234.189.131/zero_appearance/${shop}/${appearance[shop].sex}/${tattooImage}.png`}
            onError={() => setImageError(true)}
          />
        );
      }
      return (
        <S.OptionImage
          loading="lazy"
          src={`http://104.234.189.131/zero_appearance/${shop}/${appearance[shop].sex}/${labelType}/${index}.png`}
          onError={() => setImageError(true)}
        />
      );
    }, [shop, appearance, labelType, index, tattooImage]);

    return (
      <S.OptionItem onClick={handleClick} className={className} ref={ref}>
        {index !== -1 ? (
          <>
            {!imageError ? (
              <>{renderImage()}</>
            ) : (
              <S.WrapBrokenImage>
                <CiImageOff />
              </S.WrapBrokenImage>
            )}
          </>
        ) : (
          <S.ItemTitle>Retirar</S.ItemTitle>
        )}
        {index !== -1 && <S.ItemWrapIcon>{index}</S.ItemWrapIcon>}
        <S.ItemWrapMoney>R$ 250</S.ItemWrapMoney>
      </S.OptionItem>
    );
  }
);

export default Item;
