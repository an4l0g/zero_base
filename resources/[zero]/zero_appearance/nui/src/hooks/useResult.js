import { useCallback, useContext, useEffect } from "react";
import ResultContext from "../contexts/ResultContext";
import AppearanceContext from "../contexts/AppearanceContext";
import useRequest from "./useRequest";
import BarberTypes from "../components/BarberShop/types.json";
import SkinTypes from "../components/SkinShop/types.json";
import TattooTypes from "../components/TattooShop/types.json";
import VariationsContext from "../contexts/VariationsContext";

function useResult() {
  const { result, setResult } = useContext(ResultContext);
  const { request } = useRequest();
  const { appearance, setAppearance } = useContext(AppearanceContext);
  const { setVariations } = useContext(VariationsContext);

  useEffect(() => {
    console.log("Change result", result);
  }, [result]);

  const prices = {
    barber: 500,
    tattoo: 500,
    skin: 5000,
  };

  const sendDemoPedVariations = useCallback(() => {
    if (appearance.skinshop) {
      request("changeSkinshopDemo", {
        drawables: result.current,
      });
    }

    if (appearance.barbershop) {
      request("changeBarbershopDemo", {
        drawables: result.current,
      });
    }

    if (appearance.tattoo) {
      request("changeTattooDemo", {
        drawables: result.current,
      });
    }
  }, [appearance, result]);

  const createResult = useCallback(
    (shop, sex, drawables) => {
      var newResult = {};
      if (shop === "barber") {
        drawables.forEach((item, index) => {
          newResult = {
            default: {
              ...newResult.default,
              [BarberTypes[sex][index].path]: {
                model: item.model ?? null,
                opacity: item.opacity ?? null,
                main_color: item.main_color ?? null,
                secondary_color: item.secondary_color ?? null,
              },
            },
            current: {
              ...newResult.current,
              [BarberTypes[sex][index].path]: {
                model: item.model ?? null,
                opacity: item.opacity ?? null,
                main_color: item.main_color ?? null,
                secondary_color: item.secondary_color ?? null,
              },
            },
          };
        });
        setResult(newResult);
      }

      if (shop === "skin") {
        drawables.forEach((item, index) => {
          newResult = {
            default: {
              ...newResult.default,
              [SkinTypes[sex][index].path]: {
                model: item.model ?? null,
                var: item.var ?? null,
              },
            },
            current: {
              ...newResult.current,
              [SkinTypes[sex][index].path]: {
                model: item.model ?? null,
                var: item.var ?? null,
              },
            },
          };
        });
        setResult(newResult);
      }

      if (shop === "tattoo") {
        drawables.forEach((item, index) => {
          newResult = {
            default: {
              ...newResult.default,
              [TattooTypes[sex][index].path]: item.model ?? null,
            },
            current: {
              ...newResult.current,
              [TattooTypes[sex][index].path]: item.model ?? null,
            },
          };
        });
        setResult(newResult);
      }
    },
    [appearance, setResult]
  );

  const handleSetResult = useCallback(
    (typeLabel, value) => {
      if (appearance.tattooshop) {
        let hasModel = false;
        const newPathResult = result.current[typeLabel].filter((item) => {
          if (item === value) {
            hasModel = true;
            return false;
          }
        });

        if (hasModel) {
          setResult((old) => ({
            ...old,
            current: {
              ...old.current,
              [typeLabel]: newPathResult,
            },
          }));
        } else {
          setResult((old) => ({
            ...old,
            current: {
              ...old.current,
              [typeLabel]: [...old.current[typeLabel], value],
            },
          }));
        }
      } else {
        setResult((old) => ({
          ...old,
          current: {
            ...old.current,
            [typeLabel]: {
              ...old.current[typeLabel],
              ...value,
            },
          },
        }));
      }
    },
    [appearance, result, setResult]
  );

  const calculateTotal = useCallback(
    (types) => {
      let total = 0;
      if (result.current) {
        types.map((item) => {
          if (
            JSON.stringify(result.default[item.path]) !==
            JSON.stringify(result.current[item.path])
          ) {
            total += prices;
          }
        });
      }

      return total;
    },
    [result, appearance]
  );

  const buyCustomizations = useCallback(
    (shop) => {
      const buys = {
        barber: () => {
          request("buyBarbershopCustomizations", {
            drawables: result.current,
            total: calculateTotal(BarberTypes[appearance.barbershop.sex]),
          });
        },
        skin: () => {
          request("buySkinshopCustomizations", {
            drawables: result.current,
            total: calculateTotal(SkinTypes[appearance.barbershop.sex]),
          });
        },
        tattoo: () => {
          request("buyTattooshopCustomizations", {
            drawables: result.current,
            total: calculateTotal(TattooTypes[appearance.barbershop.sex]),
          });
        },
      };
      buys[shop]();
      setAppearance({});
      setVariations({});
    },
    [result, calculateTotal, request, setAppearance, setVariations]
  );

  useEffect(() => {
    sendDemoPedVariations();
  }, [result]);

  return {
    calculateTotal,
    buyCustomizations,
    createResult,
    handleSetResult,
  };
}

export default useResult;
