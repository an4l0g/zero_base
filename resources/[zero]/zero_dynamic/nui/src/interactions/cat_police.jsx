import { RiPlayFill } from "react-icons/ri";
import { GiClothes } from "react-icons/gi";

export default [
  {
    title: "Retirar vestimenta",
    icon: <GiClothes />,
    type: "category",
    action: "vestimenta",
    value: "vestimenta",
    category: "police",
  },
  {
    title: "Retirar máscara",
    icon: <RiPlayFill />,
    type: "action",
    action: "vestimenta",
    value: "rmascara",
    category: "vestimenta",
  },
  {
    title: "Retirar chápeu",
    icon: <RiPlayFill />,
    type: "action",
    action: "vestimenta",
    value: "rchapeu",
    category: "vestimenta",
  },
];
