import Title from "../Title";
import * as S from "./styles";
import { GiComb, GiBeard } from "react-icons/gi";
import { BiBody } from "react-icons/bi";
import { RiBrushLine } from "react-icons/ri";
import Slider from "../../Slider";
import ColorPicker from "../../ColorPicker";
import { useContext } from "react";
import CharacterContext from "../../../contexts/CharacterContext";

function Hair() {
  const { character, setCharacter } = useContext(CharacterContext);

  return (
    <S.Container>
      <Title icon={<GiComb />} title="Cabelo" />
      <Slider
        label="Modelo de cabelo"
        value={character.hairModel}
        setValue={(val) => setCharacter((old) => ({ ...old, hairModel: val }))}
        min={0}
        max={147}
        step={1}
        ruler={true}
      />
      <ColorPicker
        label="Cor de cabelo 1"
        value={character.firstHairColor}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, firstHairColor: val }))
        }
      />
      <ColorPicker
        label="Cor de cabelo 2"
        value={character.secondHairColor}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, secondHairColor: val }))
        }
      />
      <Title icon={<GiBeard />} title="Barba" space={true} />
      <Slider
        label="Modelo de barba"
        value={character.beardModel}
        setValue={(val) => setCharacter((old) => ({ ...old, beardModel: val }))}
        min={-1}
        middle={0}
        max={28}
        step={1}
        ruler={true}
      />
      <ColorPicker
        label="Cor da barba"
        value={character.beardColor}
        setValue={(val) => setCharacter((old) => ({ ...old, beardColor: val }))}
      />
      <Slider
        label="Opacidade da barba"
        value={character.beardOpacity}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, beardOpacity: val }))
        }
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Title icon={<BiBody />} title="Pelos corporais" space={true} />
      <Slider
        label="Modelo dos pelos"
        value={character.chestModel}
        setValue={(val) => setCharacter((old) => ({ ...old, chestModel: val }))}
        min={-1}
        middle={0}
        max={16}
        step={1}
        ruler={true}
      />
      <ColorPicker
        label="Cor dos pelos"
        value={character.chestColor}
        setValue={(val) => setCharacter((old) => ({ ...old, chestColor: val }))}
      />
      <Slider
        label="Opacidade dos pelos"
        value={character.chestOpacity}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, chestOpacity: val }))
        }
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Title icon={<RiBrushLine />} title="Maquiagem" space={true} />
      <Slider
        label="Modelo de blush"
        value={character.blushModel}
        setValue={(val) => setCharacter((old) => ({ ...old, blushModel: val }))}
        min={-1}
        middle={0}
        max={6}
        step={1}
        ruler={true}
      />
      <ColorPicker
        label="Cor do blush"
        value={character.blushColor}
        setValue={(val) => setCharacter((old) => ({ ...old, blushColor: val }))}
      />
      <Slider
        label="Opacidade de blush"
        value={character.blushOpacity}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, blushOpacity: val }))
        }
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Modelo do batom"
        value={character.lipstickModel}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, lipstickModel: val }))
        }
        min={-1}
        middle={0}
        max={9}
        step={1}
        ruler={true}
      />
      <ColorPicker
        label="Cor do batom"
        value={character.lipstickColor}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, lipstickColor: val }))
        }
      />
      <Slider
        label="Opacidade do batom"
        value={character.lipstickOpacity}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, lipstickOpacity: val }))
        }
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Modelo de Manchas"
        value={character.blemishesModel}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, blemishesModel: val }))
        }
        min={-1}
        middle={0}
        max={23}
        step={1}
        ruler={true}
      />
      <Slider
        label="Opacidade de Manchas"
        value={character.blemishesOpacity}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, blemishesOpacity: val }))
        }
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Modelo de envelhecimento"
        value={character.ageingModel}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, ageingModel: val }))
        }
        min={-1}
        middle={0}
        max={14}
        step={1}
        ruler={true}
      />
      <Slider
        label="Intensidade de envelhecimento"
        value={character.ageingOpacity}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, ageingOpacity: val }))
        }
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Aspecto"
        value={character.complexionModel}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, complexionModel: val }))
        }
        min={-1}
        middle={0}
        max={11}
        step={1}
        ruler={true}
      />
      <Slider
        label="Opacidade de aspecto"
        value={character.complexionOpacity}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, complexionOpacity: val }))
        }
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Danos de sol"
        value={character.sundamageModel}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, sundamageModel: val }))
        }
        min={-1}
        middle={0}
        max={10}
        step={1}
        ruler={true}
      />
      <Slider
        label="Intensidade dos danos de sol"
        value={character.sundamageOpacity}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, sundamageOpacity: val }))
        }
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Sardas"
        value={character.frecklesModel}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, frecklesModel: val }))
        }
        min={-1}
        middle={0}
        max={17}
        step={1}
        ruler={true}
      />
      <Slider
        label="Intensidade das sardas"
        value={character.frecklesOpacity}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, frecklesOpacity: val }))
        }
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Maquiagem"
        value={character.makeupModel}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, makeupModel: val }))
        }
        min={-1}
        middle={0}
        max={74}
        step={1}
        ruler={true}
      />
      <Slider
        label="Opacidade da maquiagem"
        value={character.makeupOpacity}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, makeupOpacity: val }))
        }
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
    </S.Container>
  );
}

export default Hair;
