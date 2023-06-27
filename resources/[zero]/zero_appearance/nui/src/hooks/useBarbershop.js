import { useContext, useMemo } from "react";
import ResultContext from "../contexts/ResultContext";
import Types from "../components/BarberShop/types.json";

const useBarbershop = () => {
  const { result, setResult } = useContext(ResultContext);

  const createResult = (drawables) => {
    let newResult = {};
    drawables.map((item, index) => {
      newResult = {
        default: {
          ...newResult.default,
          [Types[index].path]: {
            model: item.model || null,
            opacity: item.opacity || null,
            main_color: item.main_color || null,
            secondary_color: item.secondary_color || null,
          },
        },
        current: {
          ...newResult.current,
          [Types[index].path]: {
            model: item.model || null,
            opacity: item.opacity || null,
            main_color: item.main_color || null,
            secondary_color: item.secondary_color || null,
          },
        },
      };
    });

    setResult(newResult);
  };

  const handleSetResult = (indexType, data) => {
    setResult((old) => ({
      ...old,
      current: {
        ...old.current,
        [Types[indexType].path]: data,
      },
    }));
  };

  const calculateTotal = useMemo(() => {
    let total = 0;
    if (result.current) {
      Types.map((item, index) => {
        console.log(result, item.path);
        if (result.current[item.path] !== result.current[item.path]) {
          total += 5000;
        }
      });
    }

    return total;
  }, [result]);

  return {
    createResult,
    handleSetResult,
    calculateTotal,
  };
};

export default useBarbershop;
