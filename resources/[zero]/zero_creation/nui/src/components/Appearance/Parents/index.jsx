import Title from "../Title";
import DisplayParents from "./DisplayParents";
import * as S from "./styles";
import { RiParentLine } from "react-icons/ri";
import { BsPaintBucket } from "react-icons/bs";
import ParentsList from "./parents.json";
import Slider from "../../Slider";
import { useContext } from "react";
import CharacterContext from "../../../contexts/CharacterContext";

function Parents() {
  const { character, setCharacter } = useContext(CharacterContext);

  return (
    <S.Container>
      <Title icon={<RiParentLine />} title="Família" />
      <DisplayParents
        parent1={character.fatherId}
        parent2={character.motherId}
      />
      <Slider
        label={ParentsList[character.fatherId].name}
        value={character.fatherId}
        setValue={(val) => setCharacter((old) => ({ ...old, fatherId: val }))}
        min={0}
        max={ParentsList.length - 1}
      />
      <Slider
        label={ParentsList[character.motherId].name}
        value={character.motherId}
        setValue={(val) => setCharacter((old) => ({ ...old, motherId: val }))}
        min={0}
        max={ParentsList.length - 1}
      />
      <Slider
        label={`Sem. ${ParentsList[character.fatherId].name} / Sem. ${
          ParentsList[character.motherId].name
        }`}
        value={character.shapeMix}
        setValue={(val) => setCharacter((old) => ({ ...old, shapeMix: val }))}
        min={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Title icon={<BsPaintBucket />} title="Tom de pele" space={true} />
      <Slider
        label={`Cor ${ParentsList[character.fatherId].name}`}
        value={character.colorFather}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, colorFather: val }))
        }
        min={0}
        max={44}
        step={1}
        ruler={true}
      />
      <Slider
        label={`Cor ${ParentsList[character.motherId].name}`}
        value={character.colorMother}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, colorMother: val }))
        }
        min={0}
        max={44}
        step={1}
        ruler={true}
      />
      <Slider
        label="Tom de pele"
        value={character.skinMix}
        setValue={(val) => setCharacter((old) => ({ ...old, skinMix: val }))}
        min={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
    </S.Container>
  );
}

export default Parents;
