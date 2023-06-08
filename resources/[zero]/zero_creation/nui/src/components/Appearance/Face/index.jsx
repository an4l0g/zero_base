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
import { useContext } from "react";
import CharacterContext from "../../../contexts/CharacterContext";

function Face() {
  const { character, setCharacter } = useContext(CharacterContext);

  return (
    <S.Container>
      <Title icon={<AiOutlineEye />} title="Olhos" />
      <Slider
        label="Cor dos olhos"
        value={character.eyesColor}
        setValue={(val) => setCharacter((old) => ({ ...old, eyesColor: val }))}
        min={0}
        max={31}
        step={1}
        ruler={true}
      />
      <Slider
        label="Abertura dos olhos"
        value={character.eyesOpening}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, eyesOpening: val }))
        }
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Title icon={<VscEye />} title="Sobrancelhas" space={true} />
      <Slider
        label="Altura das Sobrancelhas"
        value={character.eyebrowsHeight}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, eyebrowsHeight: val }))
        }
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Largura das Sobrancelhas"
        value={character.eyebrowsWidth}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, eyebrowsWidth: val }))
        }
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Modelo das Sobrancelhas"
        value={character.eyebrowsModel}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, eyebrowsModel: val }))
        }
        min={0}
        max={33}
        step={1}
        ruler={true}
      />
      <ColorPicker
        label="Cor das Sobrancelhas"
        value={character.eyebrowsColor}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, eyebrowsColor: val }))
        }
      />
      <Slider
        label="Opacidade das Sobrancelhas"
        value={character.eyebrowsOpacity}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, eyebrowsOpacity: val }))
        }
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Title icon={<GiNoseFront />} title="Nariz" space={true} />
      <Slider
        label="Largura do nariz"
        value={character.noseWidth}
        setValue={(val) => setCharacter((old) => ({ ...old, noseWidth: val }))}
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Altura do nariz"
        value={character.noseHeight}
        setValue={(val) => setCharacter((old) => ({ ...old, noseHeight: val }))}
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Comprimento do nariz"
        value={character.noseLength}
        setValue={(val) => setCharacter((old) => ({ ...old, noseLength: val }))}
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Ponte nasal"
        value={character.noseBridge}
        setValue={(val) => setCharacter((old) => ({ ...old, noseBridge: val }))}
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Ponta do nariz"
        value={character.noseTip}
        setValue={(val) => setCharacter((old) => ({ ...old, noseTip: val }))}
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Variação do nariz"
        value={character.noseShift}
        setValue={(val) => setCharacter((old) => ({ ...old, noseShift: val }))}
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Title icon={<CgSmileNoMouth />} title="Bochechas" space={true} />
      <Slider
        label="Altura dos ossos da bochecha"
        value={character.cheekboneHeight}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, cheekboneHeight: val }))
        }
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Largura dos ossos da bochecha"
        value={character.cheekboneWidth}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, cheekboneWidth: val }))
        }
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Largura da bochecha"
        value={character.cheeksWidth}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, cheeksWidth: val }))
        }
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Title icon={<GiLips />} title="Boca" space={true} />
      <Slider
        label="Lábios"
        value={character.lips}
        setValue={(val) => setCharacter((old) => ({ ...old, lips: val }))}
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Largura da mandíbula"
        value={character.jawWidth}
        setValue={(val) => setCharacter((old) => ({ ...old, jawWidth: val }))}
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Altura da mandíbula"
        value={character.jawHeight}
        setValue={(val) => setCharacter((old) => ({ ...old, jawHeight: val }))}
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Title icon={<SiEgghead />} title="Queixo" space={true} />
      <Slider
        label="Comprimento do queixo"
        value={character.chinLength}
        setValue={(val) => setCharacter((old) => ({ ...old, chinLength: val }))}
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Posição do queixo"
        value={character.chinPosition}
        setValue={(val) =>
          setCharacter((old) => ({ ...old, chinPosition: val }))
        }
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Largura do queixo"
        value={character.chinWidth}
        setValue={(val) => setCharacter((old) => ({ ...old, chinWidth: val }))}
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
      <Slider
        label="Formato do queixo"
        value={character.chinShape}
        setValue={(val) => setCharacter((old) => ({ ...old, chinShape: val }))}
        min={-1}
        middle={0}
        max={0.99}
        step={0.01}
        ruler={true}
      />
    </S.Container>
  );
}

export default Face;
