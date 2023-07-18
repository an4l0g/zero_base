import { useCallback, useContext, useEffect, useMemo } from "react";
import ResultContext from "../contexts/ResultContext";
import Types from "../components/BarberShop/types.json";
import useRequest from "./useRequest";
import AppearanceContext from "../contexts/AppearanceContext";

const useSkinshop = () => {
  const { result, setResult } = useContext(ResultContext);
  const { setAppearance } = useContext(AppearanceContext);
  const { request } = useRequest();

  useEffect(() => {
    request("changeBarbershopDemo", {
      drawables: result.current,
    });
  }, [result, request]);

  const createResult = (drawables) => {
    let newResult = {};
    drawables.map((item, index) => {
      newResult = {
        default: {
          ...newResult.default,
          [Types[index].path]: {
            model: item.model ?? null,
            opacity: item.opacity ?? null,
            main_color: item.main_color ?? null,
            secondary_color: item.secondary_color ?? null,
          },
        },
        current: {
          ...newResult.current,
          [Types[index].path]: {
            model: item.model ?? null,
            opacity: item.opacity ?? null,
            main_color: item.main_color ?? null,
            secondary_color: item.secondary_color ?? null,
          },
        },
      };
    });

    setResult(newResult);
  };

  const handleSetResult = (typeLabel, field, value) => {
    setResult((old) => ({
      ...old,
      current: {
        ...old.current,
        [typeLabel]: {
          ...old.current[typeLabel],
          [field]: value,
        },
      },
    }));
  };

  const calculateTotal = useMemo(() => {
    let total = 0;
    if (result.current) {
      Types.map((item) => {
        if (
          JSON.stringify(result.default[item.path]) !==
          JSON.stringify(result.current[item.path])
        ) {
          total += 5000;
        }
      });
    }

    return total;
  }, [result]);

  const buyCustomizations = useCallback(() => {
    request("buyBarbershopCustomizations", {
      drawables: result.current,
      total: calculateTotal,
    });
    setAppearance({});
  }, [result, calculateTotal, request, setAppearance]);

  return {
    createResult,
    handleSetResult,
    calculateTotal,
    buyCustomizations,
  };
};

export default useSkinshop;
