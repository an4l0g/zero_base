import React, { useCallback, useContext, useMemo } from "react";
import * as S from "../GenericalStyles";
import Item from "../Item";
import ResultContext from "../../contexts/ResultContext";
import useResult from "../../hooks/useResult";
import AppearanceContext from "../../contexts/AppearanceContext";

function ItemList({ shop, limit, indexType, labelType }) {
  const { appearance } = useContext(AppearanceContext);
  const { result } = useContext(ResultContext);
  const { handleSetResult } = useResult();

  const renderItems = useMemo(() => {
    if (appearance.tattooshop) {
      return appearance.tattooshop.drawables[indexType].part.map(
        (item) => item
      );
    }
    return new Array(limit).fill(0);
  }, [limit]);

  const handleClick = (item) => {
    handleSetResult(labelType, {
      model: item,
      var: 0,
    });
  };

  const renderClassName = useCallback(
    (index, item = null) => {
      if (appearance.tattooshop) {
        if (result.current[indexType].includes(item)) return "active";
        return "";
      }
      return result.current[labelType].model === index ? "active" : "";
    },
    [result, labelType]
  );

  return (
    <S.OptionsList>
      {renderItems.map((item, index) => (
        <Item
          key={index}
          index={index}
          shop={shop}
          className={renderClassName(index, item)}
          labelType={labelType}
          tattooImage={item.name}
          handleClick={() => handleClick(item)}
        />
      ))}
    </S.OptionsList>
  );
}

export default ItemList;
