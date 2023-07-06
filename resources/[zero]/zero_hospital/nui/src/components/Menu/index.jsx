import * as S from "./styles";
import { BsCardChecklist, BsPeople } from "react-icons/bs";
import { LiaFileMedicalAltSolid } from "react-icons/lia";

function Menu() {
  return (
    <S.Menu>
      <S.ItemMenu>
        <BsCardChecklist /> Meus serviços
      </S.ItemMenu>
      <S.ItemMenu>
        <BsPeople />
        Pacientes
      </S.ItemMenu>
      <S.ItemMenu>
        <LiaFileMedicalAltSolid />
        Relatórios
      </S.ItemMenu>
    </S.Menu>
  );
}

export default Menu;
