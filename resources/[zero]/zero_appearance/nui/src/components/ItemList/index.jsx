import React, { useContext, useMemo } from "react";
import * as S from "../GenericalStyles";
import Item from "../Item";
import ResultContext from "../../contexts/ResultContext";
import useBarbershop from "../../hooks/useBarbershop";

function ItemList({ limit, types, indexType, labelType }) {
  const { result } = useContext(ResultContext);
  const { handleSetResult } = useBarbershop();

  const renderItems = useMemo(() => {
    return new Array(limit).fill(null);
  }, [limit]);

  return (
    <S.OptionsList>
      {renderItems.map((_, index) => (
        <Item
          key={index}
          index={index}
          // className={
          //   result.current[types[indexType].path].model === index
          //     ? "active"
          //     : ""
          // }
          labelType={labelType}
          handleClick={() => {
            handleSetResult(labelType, "model", index);
          }}
        />
      ))}
    </S.OptionsList>
  );
}

export default ItemList;
