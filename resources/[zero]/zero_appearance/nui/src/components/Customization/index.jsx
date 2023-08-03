import { useContext } from "react";
import ColorPicker from "../ColorPicker";
import * as S from "../GenericalStyles";
import ResultContext from "../../contexts/ResultContext";
import useResult from "../../hooks/useResult";
import Slider from "../Slider";
import VariationsContext from "../../contexts/VariationsContext";

function Customization({ indexType, types, labelType, maxVariation = 0 }) {
  const { result } = useContext(ResultContext);
  const { variations } = useContext(VariationsContext);
  const { handleSetResult } = useResult();

  return (
    <>
      <S.Customization>
        {types[indexType].main_color && (
          <ColorPicker
            label="Cor 1"
            value={result.current[labelType].main_color}
            setValue={(val) => handleSetResult(labelType, { main_color: val })}
          />
        )}
        {types[indexType].secondary_color && (
          <ColorPicker
            label="Cor 2"
            value={result.current[labelType].secondary_color}
            setValue={(val) =>
              handleSetResult(labelType, { secondary_color: val })
            }
          />
        )}
        {types[indexType].opacity && (
          <Slider
            label="Opacidade"
            value={result.current[labelType].opacity}
            setValue={(val) => handleSetResult(labelType, { opacity: val })}
            min={0}
            max={0.99}
            step={0.01}
            ruler={true}
          />
        )}
        {types[indexType].var && (
          <Slider
            label="Variação"
            value={result.current[labelType].var}
            setValue={(val) => handleSetResult(labelType, { var: val })}
            min={0}
            max={variations[labelType] - 1}
            step={1}
            ruler={true}
          />
        )}
      </S.Customization>
    </>
  );
}

export default Customization;
