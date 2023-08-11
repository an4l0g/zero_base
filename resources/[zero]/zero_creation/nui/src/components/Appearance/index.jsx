import * as S from "./styles";

import { AiOutlineIdcard, AiOutlineCheckCircle } from "react-icons/ai";
import { RiParentLine } from "react-icons/ri";
import { BiFace } from "react-icons/bi";
import { GiComb } from "react-icons/gi";
import { useContext, useState } from "react";
import Identity from "./Identity";
import Parents from "./Parents";
import Face from "./Face";
import Hair from "./Hair";
import useRequest from "../../hooks/useRequest";
import CreationContext from "../../contexts/CreationContext";

function Appearance() {
  const [tab, setTab] = useState("identity");
  const { request } = useRequest();
  const { setCreation } = useContext(CreationContext);

  const handleFinish = async () => {
    await request("finish");
  };

  return (
    <S.Container>
      <S.Header>
        <S.Title>
          <span>
            Crie seu <br /> Personagem
          </span>
        </S.Title>
        <S.Description>
          Seja muito bem vindo(a) à Zero! <br />
          Crie seu personagem do seu jeito e aproveite a melhor experiência de
          RP do FiveM.
        </S.Description>
      </S.Header>
      <S.Tabs>
        <S.TabsList>
          <S.TabButton
            active={tab === "identity"}
            onClick={() => setTab("identity")}
          >
            <AiOutlineIdcard />
            <span>Identidade</span>
          </S.TabButton>
          <S.TabButton
            active={tab === "parents"}
            onClick={() => setTab("parents")}
          >
            <RiParentLine />
            <span>Família</span>
          </S.TabButton>
          <S.TabButton active={tab === "face"} onClick={() => setTab("face")}>
            <BiFace />
            <span>Rosto</span>
          </S.TabButton>
          <S.TabButton active={tab === "hair"} onClick={() => setTab("hair")}>
            <GiComb />
            <span>Salão</span>
          </S.TabButton>
          <S.TabButton className="finish" onClick={handleFinish}>
            <AiOutlineCheckCircle />
            <span>Finalizar</span>
          </S.TabButton>
        </S.TabsList>
        {tab === "identity" && <Identity />}
        {tab === "parents" && <Parents />}
        {tab === "face" && <Face />}
        {tab === "hair" && <Hair />}
      </S.Tabs>
    </S.Container>
  );
}

export default Appearance;
