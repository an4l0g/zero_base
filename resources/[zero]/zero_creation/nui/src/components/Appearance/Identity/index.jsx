import * as S from "./styles";
import Input from "../../Input";
import Title from "../Title";
import Slider from "../../Slider";
import { AiOutlineIdcard } from "react-icons/ai";
import { useState } from "react";
import Select from "../../Select";

function Identity() {
  const [name, setName] = useState("");
  const [surname, setSurname] = useState("");
  const [gender, setGender] = useState("");
  const [age, setAge] = useState(18);

  return (
    <S.Container>
      <Title icon={<AiOutlineIdcard />} title="Identidade" />
      <Input
        label="Nome"
        placeholder="Ex: Arnaldo"
        value={name}
        onChange={(e) => setName(e.target.value())}
      />
      <Input
        label="Sobrenome"
        placeholder="Ex: Da Silva"
        value={surname}
        onChange={(e) => setSurname(e.target.value())}
      />
      <Select
        value={gender}
        onChange={(val) => setGender(val)}
        placeholder="Gênero"
        options={["masculino", "feminino"]}
      />
      <Slider
        label="Idade"
        value={age}
        setValue={setAge}
        ruler={true}
        min={18}
        max={100}
      />
    </S.Container>
  );
}

export default Identity;
