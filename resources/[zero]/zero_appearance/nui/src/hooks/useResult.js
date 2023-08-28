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

  const prices = {
    barber: 250,
    tattoo: 250,
    skin: 250,
  };

  const currentPrice = useCallback(() => {
    if (appearance.barbershop) return prices.barber;
    if (appearance.tattooshop) return prices.tattoo;
    if (appearance.skinshop) return prices.skin;
  }, [appearance]);

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

    if (appearance.tattooshop) {
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
        setResult((old) => {
          let hasModel = false;
          const newPathResult = old.current[typeLabel].filter((item) => {
            if (!hasModel) {
              if (item.name === value.model.name) {
                hasModel = true;
                return false;
              }
            }
            return true;
          });
          if (hasModel) {
            return {
              ...old,
              current: {
                ...old.current,
                [typeLabel]: newPathResult,
              },
            };
          } else {
            return {
              ...old,
              current: {
                ...old.current,
                [typeLabel]: [...old.current[typeLabel], value.model],
              },
            };
          }
        });
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
    [appearance, setResult]
  );

  const calculateTotal = useCallback(
    (types) => {
      let total = 0;
      if (result.current) {
        if (appearance.tattooshop) {
          types.map((item, index) => {
            result.current[index].map((cItem) => {
              if (!result.default[index].includes(cItem)) {
                total += currentPrice();
              }
            });

            result.default[index].map((dItem) => {
              if (
                !result.current[index].includes(dItem) &&
                !result.default[index].includes(dItem)
              ) {
                total -= currentPrice();
              }
            });
          });
        } else {
          types.map((item) => {
            if (
              JSON.stringify(result.default[item.path]) !==
              JSON.stringify(result.current[item.path])
            ) {
              total += currentPrice();
            }
          });
        }
      }

      return total;
    },
    [result, appearance, currentPrice]
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
            total: calculateTotal(SkinTypes[appearance.skinshop.sex]),
          });
        },
        tattoo: () => {
          request("buyTattooshopCustomizations", {
            drawables: result.current,
            total: calculateTotal(TattooTypes[appearance.tattooshop.sex]),
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
