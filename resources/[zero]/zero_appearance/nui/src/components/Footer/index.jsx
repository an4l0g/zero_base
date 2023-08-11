import { useContext, useEffect } from "react";
import * as S from "../GenericalStyles";
import Rotation from "../Rotation";
import { IoMdColorPalette } from "react-icons/io";
import { AiOutlineShoppingCart } from "react-icons/ai";

function Footer({
  customization,
  setCustomization,
  hasCustom,
  total,
  buyCustomizations,
}) {
  return (
    <S.Actions>
      <S.WrapAction>
        <Rotation />
      </S.WrapAction>
      <S.WrapAction>
        {hasCustom && (
          <>
            <S.CustomButton
              onClick={() => setCustomization((old) => !old)}
              customization={customization}
            >
              <IoMdColorPalette />
            </S.CustomButton>
          </>
        )}
        <S.BtnAction onClick={buyCustomizations}>
          <AiOutlineShoppingCart /> R$ {total},00
        </S.BtnAction>
      </S.WrapAction>
    </S.Actions>
  );
}

export default Footer;
