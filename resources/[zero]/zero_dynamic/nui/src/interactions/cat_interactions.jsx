import { RiPlayFill } from "react-icons/ri";
import { AiOutlineHeart } from "react-icons/ai";

export default [
  {
    title: "Enviar dinheiro",
    icon: <RiPlayFill />,
    type: "action",
    action: "enviar",
    closeLater: true,
    category: "interactions",
  },
  {
    title: "Casal",
    icon: <AiOutlineHeart />,
    type: "category",
    value: "couple",
    category: "interactions",
  },
  {
    title: "Colocar capuz",
    icon: <RiPlayFill />,
    type: "action",
    action: "capuz",
    value: "colocar",
    closeLater: true,
    category: "interactions",
  },
  {
    title: "Retirar capuz",
    icon: <RiPlayFill />,
    type: "action",
    action: "capuz",
    closeLater: true,
    category: "interactions",
  },
];
