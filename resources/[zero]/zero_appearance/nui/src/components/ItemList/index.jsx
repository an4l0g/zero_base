import React, {
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useRef,
  useState,
} from "react";
import * as S from "../GenericalStyles";
import Item from "../Item";
import ResultContext from "../../contexts/ResultContext";
import useResult from "../../hooks/useResult";
import AppearanceContext from "../../contexts/AppearanceContext";

function ItemList({ shop, limit, indexType, labelType }) {
  const { appearance } = useContext(AppearanceContext);
  const { result } = useContext(ResultContext);
  const { handleSetResult } = useResult();
  const [currentSelect, setCurrentSelect] = useState(0);
  const itemRefs = useRef({});

  const scrollTo = useCallback(() => {
    const item = itemRefs.current[`item${currentSelect}`];
    if (item) {
      item.scrollIntoView({
        behavior: "smooth",
      });
    }
  }, [currentSelect]);

  useEffect(() => {
    scrollTo();
    if (!appearance.tattooshop)
      handleClick(renderItems[currentSelect], currentSelect);
  }, [currentSelect]);

  useEffect(() => {
    if (appearance.tattooshop) {
      setCurrentSelect(0);
    } else {
      setCurrentSelect(result.current[labelType].model);
    }
  }, [labelType, appearance]);

  const renderItems = useMemo(() => {
    if (appearance.tattooshop) {
      return appearance.tattooshop.drawables[indexType].part.map(
        (item) => item
      );
    }
    return new Array(limit).fill(0);
  }, [limit]);

  const interactions = {
    ArrowLeft: () => {
      setCurrentSelect((old) => {
        if (old > -1) {
          return old - 1;
        }
        return old;
      });
    },
    ArrowRight: () => {
      setCurrentSelect((old) => {
        if (old !== renderItems.length - 1) return old + 1;
        return old;
      });
    },
    ArrowUp: () => {
      setCurrentSelect((old) => {
        if (old - 3 > -1) {
          return old - 3;
        }
        return old;
      });
    },
    ArrowDown: () => {
      setCurrentSelect((old) => {
        if (old + 3 !== renderItems.length - 1) return old + 3;
        return old;
      });
    },
    Enter: useCallback(() => {
      handleClick(renderItems[currentSelect], currentSelect);
    }, [renderItems, currentSelect]),
  };

  const handleKeyDown = useCallback(
    (event) => {
      interactions[event.key] && interactions[event.key]();
    },
    [interactions]
  );

  useEffect(() => {
    window.addEventListener("keydown", handleKeyDown);

    return () => {
      window.removeEventListener("keydown", handleKeyDown);
    };
  }, [handleKeyDown]);

  const handleClick = useCallback(
    (item, index) => {
      setCurrentSelect(index);
      handleSetResult(labelType, {
        model: appearance.tattooshop ? item : index,
        var: 0,
      });
    },
    [appearance, labelType, setCurrentSelect]
  );

  const renderClassName = useCallback(
    (index, active) => {
      if (currentSelect === index) return "current " + active;
      return active;
    },
    [currentSelect]
  );

  const verifyActiveItem = useCallback(
    (index, item = null) => {
      if (appearance.tattooshop) {
        const filter = result.current[indexType].filter(
          (cItem) => cItem.name === item.name && cItem.part === item.part
        );
        if (filter.length > 0) return "active";
        return "";
      }
      return result.current[labelType].model === index ? "active" : "";
    },
    [result, labelType]
  );

  return (
    <S.OptionsList>
      {!appearance.tattooshop && (
        <Item
          ref={(el) => (itemRefs.current[`item${-1}`] = el)}
          key={-1}
          index={-1}
          shop={shop}
          className={renderClassName(-1, verifyActiveItem(-1, -1))}
          labelType={labelType}
          handleClick={() => handleClick(-1, -1)}
        />
      )}
      {renderItems.map((item, index) => (
        <Item
          ref={(el) => (itemRefs.current[`item${index}`] = el)}
          key={index}
          index={index}
          shop={shop}
          className={renderClassName(
            index,
            verifyActiveItem(index, item, currentSelect)
          )}
          labelType={labelType}
          tattooImage={item.name}
          handleClick={() => handleClick(item, index)}
        />
      ))}
    </S.OptionsList>
  );
}

export default ItemList;
