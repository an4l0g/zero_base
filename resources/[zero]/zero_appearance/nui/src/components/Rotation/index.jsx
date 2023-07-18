import { useContext } from "react";
import Slider from "../Slider";
import CamContext from "../../contexts/CamContext";

function Rotation() {
  const { cam, setCam } = useContext(CamContext);

  const handleChangeRotation = (val) => {
    setCam((old) => ({ ...old, rotation: val }));
  };

  return (
    <Slider
      label="Rotação"
      value={cam.rotation}
      setValue={handleChangeRotation}
      min={0}
      max={360}
      step={1}
      ruler={true}
    />
  );
}

export default Rotation;
