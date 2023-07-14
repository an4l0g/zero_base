import { useCallback, useContext, useEffect } from "react";
import { BagsContext } from "../contexts/BagsContext";
import { ConfirmModalContext } from "../contexts/ConfirmModalContext";
import useRequest from "./useRequest";

function useBags() {
  const { bags, setBags } = useContext(BagsContext);
  const { confirmModal, setConfirmModal } = useContext(ConfirmModalContext);
  const { request } = useRequest();

  const dropItem = useCallback(
    async (item, pos, amount) => {
      request("dropItem", {
        item,
        pos,
        amount,
      });
    },
    [bags]
  );

  const getDroppedItem = useCallback(
    async (item, _, amount) => {
      isAbleChangePosition("bag", item, amount, () => {
        request("getDroppedItem", {
          id: item.id,
          amount,
        });
      });
    },
    [bags]
  );

  const isAbleChangePosition = (nBagType, cItem, cAmount, cb) => {
    let nBagWeight = 0;
    var nBag = bags[nBagType];

    Object.values(nBag.slots).map((currentItem) => {
      nBagWeight += currentItem.weight * currentItem.amount;
    });
    if (
      nBagWeight + cAmount * cItem.weight <= nBag.max_weight ||
      nBagType === "hotbar"
    ) {
      cb();
    } else {
      request("closeInventory", {
        message: "Verifique o peso dos itens!",
      });
    }
  };

  const getCurrentType = (bagType) => {
    if (bagType !== "bag" && bagType !== "player" && bagType !== "hotbar")
      return "chest";
    return bagType;
  };

  const changeItemPosition = (cItem, cPos, nItem, nPos) => {
    if (cItem.bagType !== nItem.bagType) {
      if (cItem.amount > 1) {
        setConfirmModal({
          item: cItem,
          action: (item, _, amount) => {
            isAbleChangePosition(nItem.dropType, cItem, amount, () => {
              request("changeItemPosition", {
                cItem,
                cPos,
                nItem,
                nPos,
                amount,
              });
            });
          },
        });
      } else {
        isAbleChangePosition(nItem.dropType, cItem, 1, () => {
          request("changeItemPosition", {
            cItem,
            cPos,
            nItem,
            nPos,
            amount: 1,
          });
        });
      }
    } else {
      if (cItem.amount > 1 && (!nItem.index || cItem.index == nItem.index)) {
        setConfirmModal({
          item: cItem,
          action: (item, _, amount) => {
            request("changeItemPosition", {
              cItem,
              cPos,
              nItem,
              nPos,
              amount,
            });
          },
        });
      } else {
        request("changeItemPosition", {
          cItem,
          cPos,
          nItem,
          nPos,
          amount: 1,
        });
      }
    }
  };

  const handleUnequipWeapon = async (index) => {
    request("unequipWeapon", {
      index,
    });
  };

  const dropTypes = (bagType) => {
    return (
      {
        bag: bags.item_types,
        chest: bags.item_types,
        weapons: "",
        hotbar: ["common", "food", "drink", "drug"],
      }[bagType] ?? bags.item_types
    );
  };

  const bag = bags.bag ?? {};
  const chest = bags.chest ?? {};
  const hotbar = bags.hotbar ?? {};
  const weapons = bags.weapons ?? {};
  const maxSlots = 120;
  const inVehicle = bags.inVehicle;

  return {
    changeItemPosition,
    dropItem,
    getCurrentType,
    getDroppedItem,
    handleUnequipWeapon,
    bag,
    chest,
    hotbar,
    weapons,
    maxSlots,
    dropTypes,
    inVehicle,
  };
}

export default useBags;
