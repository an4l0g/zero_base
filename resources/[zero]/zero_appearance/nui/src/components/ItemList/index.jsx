import React, { useContext, useMemo } from "react";
import * as S from "../GenericalStyles";
import Item from "../Item";
import ResultContext from "../../contexts/ResultContext";
import useResult from "../../hooks/useResult";

function ItemList({ shop, limit, types, indexType, labelType }) {
  const { result } = useContext(ResultContext);
  const { handleSetResult } = useResult();

  const renderItems = useMemo(() => {
    return new Array(limit).fill(0);
  }, [limit]);

  return (
    <S.OptionsList>
      {renderItems.map((_, index) => (
        <Item
          key={index}
          index={index}
          shop={shop}
          className={
            result.current[types[indexType].path].model === index
              ? "active"
              : ""
          }
          labelType={labelType}
          handleClick={() => {
            handleSetResult(labelType, {
              model: index,
              var: 0,
            });
          }}
        />
      ))}
    </S.OptionsList>
  );
}

export default ItemList;
