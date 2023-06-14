import { RiPlayFill } from "react-icons/ri";
import { AiOutlineHeart } from "react-icons/ai";

export default [
  {
    title: "Saquear",
    icon: <RiPlayFill />,
    type: "action",
    category: "interactions",
  },
  {
    title: "Roubar",
    icon: <RiPlayFill />,
    type: "action",
    category: "interactions",
  },
  {
    title: "Algemar/Desalgemar",
    icon: <RiPlayFill />,
    type: "action",
    action: "handcuff",
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
];
