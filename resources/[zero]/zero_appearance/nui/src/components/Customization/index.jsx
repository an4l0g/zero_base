import { useContext, useEffect } from "react";
import ColorPicker from "../ColorPicker";
import * as S from "../GenericalStyles";
import ResultContext from "../../contexts/ResultContext";
import useBarbershop from "../../hooks/useBarbershop";
import Slider from "../Slider";

function Customization({ showCustomization, indexType, types, labelType }) {
  const { result } = useContext(ResultContext);
  const { handleSetResult } = useBarbershop();

  useEffect(() => {}, [result, labelType]);

  return (
    <>
      {showCustomization && (
        <S.Customization>
          {types[indexType].main_color && (
            <ColorPicker
              label="Cor 1"
              value={result.current[labelType].main_color}
              setValue={(val) => handleSetResult(labelType, "main_color", val)}
            />
          )}
          {types[indexType].secondary_color && (
            <ColorPicker
              label="Cor 2"
              value={result.current[labelType].secondary_color}
              setValue={(val) =>
                handleSetResult(labelType, "secondary_color", val)
              }
            />
          )}
          {types[indexType].opacity && (
            <Slider
              label="Opacidade"
              value={result.current[labelType].opacity}
              setValue={(val) => handleSetResult(labelType, "opacity", val)}
              min={0}
              max={0.99}
              step={0.01}
              ruler={true}
            />
          )}
        </S.Customization>
      )}
    </>
  );
}

export default Customization;
