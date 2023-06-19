import * as S from "./styles";
import Input from "../../Input";
import Title from "../Title";
import Slider from "../../Slider";
import { AiOutlineIdcard } from "react-icons/ai";
import Select from "../../Select";
import { useContext } from "react";
import CharacterContext from "../../../contexts/CharacterContext";

function Identity() {
  const { character, setCharacter } = useContext(CharacterContext);

  return (
    <S.Container>
      <Title icon={<AiOutlineIdcard />} title="Identidade" />
      <Input
        label="Nome"
        placeholder="Ex: Arnaldo"
        value={character.name}
        onChange={(e) =>
          setCharacter((old) => ({ ...old, name: e.target.value }))
        }
      />
      <Input
        label="Sobrenome"
        placeholder="Ex: Da Silva"
        value={character.surname}
        onChange={(e) =>
          setCharacter((old) => ({ ...old, surname: e.target.value }))
        }
      />
      <Select
        value={character.gender}
        onChange={(val) => {
          setCharacter((old) => ({ ...old, gender: val }));
        }}
        placeholder="Gênero"
        options={["masculino", "feminino"]}
      />
      <Slider
        label="Idade"
        value={character.age}
        setValue={(val) => setCharacter((old) => ({ ...old, age: val }))}
        ruler={true}
        min={18}
        max={100}
      />
    </S.Container>
  );
}

export default Identity;
