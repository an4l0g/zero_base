import * as S from "./styles";
import Input from "../../Input";
import Title from "../Title";
import Slider from "../../Slider";
import { AiOutlineIdcard } from "react-icons/ai";
import Select from "../../Select";
import useData from "../../../hooks/useData";

function Identity() {
  const { name, surname, gender, age } = useData();

  return (
    <S.Container>
      <Title icon={<AiOutlineIdcard />} title="Identidade" />
      <Input
        label="Nome"
        placeholder="Ex: Arnaldo"
        value={name.get}
        onChange={(e) => name.set(e.target.value)}
      />
      <Input
        label="Sobrenome"
        placeholder="Ex: Da Silva"
        value={surname.get}
        onChange={(e) => surname.set(e.target.value)}
      />
      <Select
        value={gender.get}
        onChange={(val) => gender.set(val)}
        placeholder="Gênero"
        options={["masculino", "feminino"]}
      />
      <Slider
        label="Idade"
        value={age.get}
        setValue={age.set}
        ruler={true}
        min={18}
        max={100}
      />
    </S.Container>
  );
}

export default Identity;
