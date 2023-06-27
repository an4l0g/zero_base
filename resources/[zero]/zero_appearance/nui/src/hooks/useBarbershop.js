import { useContext } from "react";
import ResultContext from "../contexts/ResultContext";

const useBarbershop = () => {
  const { setResult } = useContext(ResultContext);

  const createResult = (drawables) => {
    drawables.map((item) => {
      setResult((old) => ({
        ...old,
        [item.path]: {
          model: item.model,
          opacity: item.opacity,
          main_color: item.main_color,
          secondary_color: item.secondary_color,
        },
      }));
    });
  };

  return {
    createResult,
  };
};

export default useBarbershop;
