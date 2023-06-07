import Title from "../Title";
import DisplayParents from "./DisplayParents";
import * as S from "./styles";
import { RiParentLine } from "react-icons/ri";
import { BsPaintBucket } from "react-icons/bs";
import ParentsList from "./parents.json";
import Slider from "../../Slider";
import useData from "../../../hooks/useData";

function Parents() {
  const { fatherId, motherId, shapeMix, colorFather, colorMother, skinMix } =
    useData();

  return (
    <S.Container>
      <Title icon={<RiParentLine />} title="Família" />
      <DisplayParents parent1={fatherId.get} parent2={motherId.get} />
      <Slider
        label={ParentsList[fatherId.get].name}
        value={fatherId.get}
        setValue={fatherId.set}
        min={0}
        max={ParentsList.length - 1}
      />
      <Slider
        label={ParentsList[motherId.get].name}
        value={motherId.get}
        setValue={motherId.set}
        min={0}
        max={ParentsList.length - 1}
        defaultValue={[ParentsList.length - 1]}
      />
      <Slider
        label={`Sem. ${ParentsList[fatherId.get].name} / Sem. ${
          ParentsList[motherId.get].name
        }`}
        value={shapeMix.get}
        setValue={shapeMix.set}
        min={0}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Title icon={<BsPaintBucket />} title="Tom de pele" space={true} />
      <Slider
        label={`Cor ${ParentsList[fatherId.get].name}`}
        value={colorFather.get}
        setValue={colorFather.set}
        min={0}
        middle={0}
        max={44}
        step={1}
        ruler={true}
      />
      <Slider
        label={`Cor ${ParentsList[motherId.get].name}`}
        value={colorMother.get}
        setValue={colorMother.set}
        min={0}
        middle={0}
        max={44}
        step={1}
        ruler={true}
      />
      <Slider
        label="Tom de pele"
        value={skinMix.get}
        setValue={skinMix.set}
        min={0}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
    </S.Container>
  );
}

export default Parents;
