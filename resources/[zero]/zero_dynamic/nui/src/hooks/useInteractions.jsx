import { useContext, useState } from "react";
import interactions from "../interactions";
import useRequest from "./useRequest";
import DynamicContext from "../contexts/DynamicContext";

const useInteractions = () => {
  const { request } = useRequest();
  const [category, setCategory] = useState(["main"]);
  const [search, setSearch] = useState("");
  const { setDynamic } = useContext(DynamicContext);

  const handleClickInteraction = async (interaction) => {
    if (interaction.type === "category") {
      setCategory((old) => [...old, interaction.value]);
      setSearch("");
    } else if (interaction.type === "action") {
      request("handleAction", {
        action: interaction.action,
        value: interaction.value || "",
      });

      if (interaction.closeLater) {
        setDynamic(false);
        request("close");
      }
    }
  };

  return {
    handleClickInteraction,
    interactions,
    search,
    setSearch,
    category,
    setCategory,
  };
};

export default useInteractions;
