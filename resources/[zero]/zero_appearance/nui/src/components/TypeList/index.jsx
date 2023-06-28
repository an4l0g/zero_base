import React, { useContext, useRef } from "react";

import * as S from "../GenericalStyles";
import AppearanceContext from "../../contexts/AppearanceContext";

function TypeList({ indexType, handleChangeType, types }) {
  const { appearance } = useContext(AppearanceContext);
  const headerListRef = useRef();

  return (
    <S.TypeList ref={headerListRef}>
      {appearance.barbershop.drawables.map((item, index) => (
        <S.TypeItem
          key={index}
          className={index === indexType ? "active" : ""}
          onClick={() => handleChangeType(index, item[types[index].path])}
        >
          <S.TypeImage
            src={`http://189.0.88.222/zero_appearance/barbershop/${index}.png`}
          />
          <S.TypeTitle>{types[index].title}</S.TypeTitle>
        </S.TypeItem>
      ))}
    </S.TypeList>
  );
}

export default TypeList;
