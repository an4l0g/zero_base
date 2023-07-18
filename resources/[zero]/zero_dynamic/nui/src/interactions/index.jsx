// import React from "react";
import { AiFillStar } from "react-icons/ai";
import { useContext, useMemo } from "react";
import DynamicContext from "../contexts/DynamicContext";

import Main from "./main";
import Interactions from "./cat_interactions";
import Couple from "./cat_couple";
import Car from "./cat_car";
import Police from "./cat_police";
import Mechanic from "./cat_mechanic";
import Homes from "./cat_homes";

export const AllInteractions = () => {
  const { dynamic } = useContext(DynamicContext);

  const interactionsList = useMemo(() => {
    return [
      ...Main,
      ...Interactions,
      ...Couple,
      ...Car,
      ...Police,
      ...Mechanic,
      ...Homes,
    ];
  }, []);

  const isFavorite = (action, value) => {
    return dynamic.favorites.some((item) => {
      if (value) {
        return item === action + ":" + value;
      } else {
        return item === action;
      }
    });
  };
  const formattedWithFavorites = () => {
    if (dynamic.favorites.length > 0) {
      return [
        {
          title: "Favoritos",
          icon: <AiFillStar />,
          type: "category",
          value: "favorites",
          category: "main",
        },
        ...interactionsList.map((item) => {
          if (isFavorite(item.action, item.value)) {
            return {
              ...item,
              category: item.category + `,favorites`,
            };
          }

          return item;
        }),
      ];
    }
    return interactionsList;
  };

  return {
    formattedWithFavorites,
    isFavorite,
  };
};

export default AllInteractions;
