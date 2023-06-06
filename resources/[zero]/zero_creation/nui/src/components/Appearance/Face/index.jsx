import useData from "../../../hooks/useData";
import Slider from "../../Slider";
import Title from "../Title";
import * as S from "./styles";
import { AiOutlineEye } from "react-icons/ai";
import { VscEye } from "react-icons/vsc";
import { GiNoseFront } from "react-icons/gi";
import { CgSmileNoMouth } from "react-icons/cg";
import { GiLips } from "react-icons/gi";
import { SiEgghead } from "react-icons/si";
import ColorPicker from "../../ColorPicker";

function Face() {
  const {
    eyesColor,
    eyesOpening,
    eyebrowsHeight,
    eyebrowsWidth,
    eyebrowsModel,
    eyebrowsColor,
    eyebrowsOpacity,
    noseWidth,
    noseHeight,
    noseLength,
    noseBridge,
    noseTip,
    noseShift,
    cheekboneHeight,
    cheekboneWidth,
    cheeksWidth,
    lips,
    jawWidth,
    jawHeight,
    chinLength,
    chinPosition,
    chinWidth,
    chinShape,
  } = useData();

  return (
    <S.Container>
      <Title icon={<AiOutlineEye />} title="Olhos" />
      <Slider
        label="Cor dos olhos"
        value={eyesColor.get}
        setValue={eyesColor.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Abertura dos olhos"
        value={eyesOpening.get}
        setValue={eyesOpening.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Title icon={<VscEye />} title="Sobrancelhas" space={true} />
      <Slider
        label="Altura das Sobrancelhas"
        value={eyebrowsHeight.get}
        setValue={eyebrowsHeight.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Largura das Sobrancelhas"
        value={eyebrowsWidth.get}
        setValue={eyebrowsWidth.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Modelo das Sobrancelhas"
        value={eyebrowsModel.get}
        setValue={eyebrowsModel.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <ColorPicker
        label="Cor das Sobrancelhas"
        value={eyebrowsColor.get}
        setValue={eyebrowsColor.set}
      />
      <Slider
        label="Opacidade das Sobrancelhas"
        value={eyebrowsOpacity.get}
        setValue={eyebrowsOpacity.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Title icon={<GiNoseFront />} title="Nariz" space={true} />
      <Slider
        label="Largura do nariz"
        value={noseWidth.get}
        setValue={noseWidth.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Altura do nariz"
        value={noseHeight.get}
        setValue={noseHeight.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Comprimento do nariz"
        value={noseLength.get}
        setValue={noseLength.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Ponte nasal"
        value={noseBridge.get}
        setValue={noseBridge.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Ponta do nariz"
        value={noseTip.get}
        setValue={noseTip.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Variação do nariz"
        value={noseShift.get}
        setValue={noseShift.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Title icon={<CgSmileNoMouth />} title="Bochechas" space={true} />
      <Slider
        label="Altura dos ossos da bochecha"
        value={cheekboneHeight.get}
        setValue={cheekboneHeight.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Largura dos ossos da bochecha"
        value={cheekboneWidth.get}
        setValue={cheekboneWidth.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Largura da bochecha"
        value={cheeksWidth.get}
        setValue={cheeksWidth.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Title icon={<GiLips />} title="Boca" space={true} />
      <Slider
        label="Lábios"
        value={lips.get}
        setValue={lips.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Largura da mandíbula"
        value={jawWidth.get}
        setValue={jawWidth.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Altura da mandíbula"
        value={jawHeight.get}
        setValue={jawHeight.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Title icon={<SiEgghead />} title="Queixo" space={true} />
      <Slider
        label="Comprimento do queixo"
        value={chinLength.get}
        setValue={chinLength.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Posição do queixo"
        value={chinPosition.get}
        setValue={chinPosition.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Largura do queixo"
        value={chinWidth.get}
        setValue={chinWidth.set}
        min={-1}
        middle={0}
        max={1}
        step={0.01}
        ruler={true}
        defaultValue={[0]}
      />
      <Slider
        label="Formato do queixo"
        value={chinShape.get}
        setValue={chinShape.set}
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

export default Face;
