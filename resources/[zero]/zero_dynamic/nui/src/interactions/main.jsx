import { GiMedicalPack, GiMechanicGarage } from "react-icons/gi";
import { HiOutlineUsers } from "react-icons/hi";
import { MdOutlineLocalPolice } from "react-icons/md";
import { IoIosBody } from "react-icons/io";
import { LuCar } from "react-icons/lu";
import { BsFillHouseFill } from "react-icons/bs";

const interactions = [
  {
    title: "Interações",
    icon: <HiOutlineUsers />,
    type: "category",
    category: "main",
    value: "interactions",
  },
  {
    title: "Animações",
    icon: <IoIosBody />,
    type: "category",
    category: "main",
    value: "animations",
  },
  {
    title: "Casa",
    icon: <BsFillHouseFill />,
    type: "category",
    category: "main",
    value: "homes",
  },
  {
    title: "Carro",
    icon: <LuCar />,
    type: "category",
    category: "main",
    value: "car",
  },
  {
    title: "Polícia",
    icon: <MdOutlineLocalPolice />,
    type: "category",
    category: "main",
    value: "police",
  },
  {
    title: "Medicina",
    icon: <GiMedicalPack />,
    type: "category",
    category: "main",
    value: "medic",
  },
  {
    title: "Mecânico",
    icon: <GiMechanicGarage />,
    type: "category",
    category: "main",
    value: "mechanic",
  },
];

export default interactions;
