import Title from "../Title";
import * as S from "./styles";
import { GiComb, GiBeard } from "react-icons/gi";
import { BiBody } from "react-icons/bi";
import { RiBrushLine } from "react-icons/ri";
import useData from "../../../hooks/useData";
import Slider from "../../Slider";
import ColorPicker from "../../ColorPicker";

function Hair() {
  const {
    hairModel,
    firstHairColor,
    secondHairColor,
    beardModel,
    beardColor,
    beardOpacity,
    chestModel,
    chestColor,
    chestOpacity,
    blushModel,
    blushColor,
    blushOpacity,
    lipstickModel,
    lipstickColor,
    lipstickOpacity,
    blemishesModel,
    blemishesOpacity,
    ageingModel,
    ageingOpacity,
    complexionModel,
    complexionOpacity,
    sundamageModel,
    sundamageOpacity,
    frecklesModel,
    frecklesOpacity,
    makeupModel,
    makeupOpacity,
  } = useData();

  return (
    <S.Container>
      <Title icon={<GiComb />} title="Cabelo" />
      <Slider
        label="Modelo de cabelo"
        value={hairModel.get}
        setValue={hairModel.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <ColorPicker
        label="Cor de cabelo 1"
        value={firstHairColor.get}
        setValue={firstHairColor.set}
      />
      <ColorPicker
        label="Cor de cabelo 2"
        value={secondHairColor.get}
        setValue={secondHairColor.set}
      />
      <Title icon={<GiBeard />} title="Barba" space={true} />
      <Slider
        label="Modelo de barba"
        value={beardModel.get}
        setValue={beardModel.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <ColorPicker
        label="Cor da barba"
        value={beardColor.get}
        setValue={beardColor.set}
      />
      <Slider
        label="Opacidade da barba"
        value={beardOpacity.get}
        setValue={beardOpacity.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Title icon={<BiBody />} title="Pelos corporais" space={true} />
      <Slider
        label="Modelo dos pelos"
        value={chestModel.get}
        setValue={chestModel.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <ColorPicker
        label="Cor dos pelos"
        value={chestColor.get}
        setValue={chestColor.set}
      />
      <Slider
        label="Opacidade dos pelos"
        value={chestOpacity.get}
        setValue={chestOpacity.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Title icon={<RiBrushLine />} title="Maquiagem" space={true} />
      <Slider
        label="Modelo de blush"
        value={blushModel.get}
        setValue={blushModel.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <ColorPicker
        label="Cor do blush"
        value={blushColor.get}
        setValue={blushColor.set}
      />
      <Slider
        label="Opacidade de blush"
        value={blushOpacity.get}
        setValue={blushOpacity.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Modelo do batom"
        value={lipstickModel.get}
        setValue={lipstickModel.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <ColorPicker
        label="Cor do batom"
        value={lipstickColor.get}
        setValue={lipstickColor.set}
      />
      <Slider
        label="Opacidade do batom"
        value={lipstickOpacity.get}
        setValue={lipstickOpacity.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Modelo de Manchas"
        value={blemishesModel.get}
        setValue={blemishesModel.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Opacidade de Manchas"
        value={blemishesOpacity.get}
        setValue={blemishesOpacity.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Modelo de envelhecimento"
        value={ageingModel.get}
        setValue={ageingModel.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Intensidade de envelhecimento"
        value={ageingOpacity.get}
        setValue={ageingOpacity.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Aspecto"
        value={complexionModel.get}
        setValue={complexionModel.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Opacidade de aspecto"
        value={complexionOpacity.get}
        setValue={complexionOpacity.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Danos de sol"
        value={sundamageModel.get}
        setValue={sundamageModel.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Intensidade dos danos de sol"
        value={sundamageOpacity.get}
        setValue={sundamageOpacity.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Sardas"
        value={frecklesModel.get}
        setValue={frecklesModel.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Intensidade das sardas"
        value={frecklesOpacity.get}
        setValue={frecklesOpacity.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Maquiagem"
        value={makeupModel.get}
        setValue={makeupModel.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Opacidade da maquiagem"
        value={makeupOpacity.get}
        setValue={makeupOpacity.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
    </S.Container>
  );
}

export default Hair;
